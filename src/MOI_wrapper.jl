using MathOptInterface
const MOI = MathOptInterface
const MOIU = MOI.Utilities

# indices
const VI = MOI.VariableIndex
const CI = MOI.ConstraintIndex
# supported functions
const SAF = MOI.ScalarAffineFunction{Float64}
const SQF = MOI.ScalarQuadraticFunction{Float64}
const VAF = MOI.VectorAffineFunction{Float64}
const VECTOR = MOI.VectorOfVariables
# supported sets
const BOUNDS = Union{
    MOI.EqualTo{Float64},
    MOI.GreaterThan{Float64},
    MOI.LessThan{Float64},
    MOI.Interval{Float64},
}
const VAR_TYPES = Union{MOI.ZeroOne,MOI.Integer}
const SOS1 = MOI.SOS1{Float64}
const SOS2 = MOI.SOS2{Float64}
# other MOI types
const AFF_TERM = MOI.ScalarAffineTerm{Float64}
const QUAD_TERM = MOI.ScalarQuadraticTerm{Float64}
const VEC_TERM = MOI.VectorAffineTerm{Float64}

const PtrMap = Dict{Ptr{Cvoid},Union{VarRef,ConsRef}}
const ConsTypeMap = Dict{Tuple{DataType,DataType},Set{ConsRef}}

mutable struct Optimizer <: MOI.AbstractOptimizer
    inner::SCIPData
    reference::PtrMap
    constypes::ConsTypeMap
    binbounds::Dict{VI,BOUNDS} # only for binary variables
    params::Dict{String,Any}
    start::Dict{VI,Float64} # can be partial
    moi_separator::Any # ::Union{CutCbSeparator, Nothing}
    moi_heuristic::Any # ::Union{HeuristicCb, Nothing}
    objective_sense::Union{Nothing,MOI.OptimizationSense}
    objective_function_set::Bool
    conflict_status::MOI.ConflictStatusCode

    function Optimizer(; kwargs...)
        scip = Ref{Ptr{SCIP_}}(C_NULL)
        @SCIP_CALL SCIPcreate(scip)
        @assert scip[] != C_NULL
        @SCIP_CALL SCIPincludeDefaultPlugins(scip[])
        @SCIP_CALL SCIP.SCIPcreateProbBasic(scip[], "")

        scip_data = SCIPData(
            scip,
            Dict(),
            Dict(),
            0,
            0,
            Dict(),
            Dict(),
            Dict(),
            Dict(),
            Dict(),
            Dict(),
            [],
        )

        o = new(
            scip_data,
            PtrMap(),
            ConsTypeMap(),
            Dict(),
            Dict(),
            Dict(),
            nothing,
            nothing,
            nothing,
            false,
            MOI.COMPUTE_CONFLICT_NOT_CALLED,
        )
        finalizer(free_scip, o)

        # Set all parameters given as keyword arguments, replacing the
        # delimiter, since "/" is used by all SCIP parameters, but is not
        # allowed in Julia identifiers.
        for (key, value) in kwargs
            name = replace(String(key), "_" => "/")
            MOI.set(o, MOI.RawOptimizerAttribute(name), value)
        end
        return o
    end
end

free_scip(o::Optimizer) = free_scip(o.inner)

Base.cconvert(::Type{Ptr{SCIP_}}, o::Optimizer) = o
# Protect Optimizer from GC for ccall with Ptr{SCIP_} argument.
Base.unsafe_convert(::Type{Ptr{SCIP_}}, o::Optimizer) = o.inner.scip[]

## convenience functions (not part of MOI)

"Return pointer to SCIP variable."
function var(o::Optimizer, v::VI)::Ptr{SCIP_VAR}
    return var(o.inner, VarRef(v.value))
end

"Return var/cons reference of SCIP variable/constraint."
ref(o::Optimizer, ptr::Ptr{Cvoid}) = o.reference[ptr]

"Return pointer to SCIP constraint."
function cons(o::Optimizer, c::CI{F,S})::Ptr{SCIP_CONS} where {F,S}
    return cons(o.inner, ConsRef(c.value))
end

"Extract bounds from sets."
bounds(set::MOI.EqualTo{Float64}) = (set.value, set.value)
bounds(set::MOI.GreaterThan{Float64}) = (set.lower, nothing)
bounds(set::MOI.LessThan{Float64}) = (nothing, set.upper)
bounds(set::MOI.Interval{Float64}) = (set.lower, set.upper)

"Make set from bounds."
function from_bounds(::Type{MOI.EqualTo{Float64}}, lower, upper)
    MOI.EqualTo{Float64}(lower)
end
function from_bounds(::Type{MOI.GreaterThan{Float64}}, lower, upper)
    MOI.GreaterThan{Float64}(lower)
end
function from_bounds(::Type{MOI.LessThan{Float64}}, lower, upper)
    MOI.LessThan{Float64}(upper)
end
function from_bounds(::Type{MOI.Interval{Float64}}, lower, upper)
    MOI.Interval{Float64}(lower, upper)
end

"Register pointer in mapping, return var/cons reference."
function register!(
    o::Optimizer,
    ptr::Ptr{Cvoid},
    ref::R,
) where {R<:Union{VarRef,ConsRef}}
    @assert !haskey(o.reference, ptr)
    o.reference[ptr] = ref
    return ref
end

"Register constraint in mapping, return constraint reference."
function register!(o::Optimizer, c::CI{F,S}) where {F,S}
    cr = ConsRef(c.value)
    if haskey(o.constypes, (F, S))
        push!(o.constypes[F, S], cr)
    else
        o.constypes[F, S] = Set([cr])
    end
    return c
end

"Go back from solved stage to problem modification stage, invalidating results."
function allow_modification(o::Optimizer)
    if !(SCIPgetStage(o) in (SCIP_STAGE_PROBLEM, SCIP_STAGE_SOLVING))
        @SCIP_CALL SCIPfreeTransform(o)
    end
    return nothing
end

## general queries and support

MOI.get(::Optimizer, ::MOI.SolverName) = "SCIP"

MOI.supports_incremental_interface(::Optimizer) = true

function _throw_if_invalid(o::Optimizer, ci::CI{F,S}) where {F,S}
    if !haskey(o.constypes, (F, S)) || !in(ConsRef(ci.value), o.constypes[F, S])
        throw(MOI.InvalidIndex(ci))
    end
    return nothing
end

function MOI.get(o::Optimizer, param::MOI.RawOptimizerAttribute)
    return get_parameter(o.inner, param.name)
end

function MOI.set(o::Optimizer, param::MOI.RawOptimizerAttribute, value)
    set_parameter(o.inner, param.name, value)
    o.params[param.name] = value
    return nothing
end

MOI.supports(o::Optimizer, ::MOI.Silent) = true

function MOI.get(o::Optimizer, ::MOI.Silent)
    return MOI.get(o, MOI.RawOptimizerAttribute("display/verblevel")) == 0
end

function MOI.set(o::Optimizer, ::MOI.Silent, value)
    param = MOI.RawOptimizerAttribute("display/verblevel")
    if value
        MOI.set(o, param, 0) # no output at all
    else
        MOI.set(o, param, 4) # default level
    end
end

MOI.supports(o::Optimizer, ::MOI.TimeLimitSec) = true

function MOI.get(o::Optimizer, ::MOI.TimeLimitSec)
    raw_value = MOI.get(o, MOI.RawOptimizerAttribute("limits/time"))
    if raw_value == SCIPinfinity(o)
        return nothing
    else
        return raw_value
    end
end

function MOI.set(o::Optimizer, ::MOI.TimeLimitSec, value)
    if value === nothing
        return MOI.set(o, MOI.RawOptimizerAttribute("limits/time"), SCIPinfinity(o))
    end
    return MOI.set(o, MOI.RawOptimizerAttribute("limits/time"), value)
end

MOI.supports(::Optimizer, ::MOI.AbsoluteGapTolerance) = true
function MOI.get(o::Optimizer, ::MOI.AbsoluteGapTolerance)
    raw_value = MOI.get(o, MOI.RawOptimizerAttribute("limits/absgap"))
    if raw_value == 0
        return nothing
    end
    return raw_value
end
function MOI.set(o::Optimizer, ::MOI.AbsoluteGapTolerance, value)
    if value === nothing
        MOI.set(o, MOI.RawOptimizerAttribute("limits/absgap"), 0.0)
    else
        MOI.set(o, MOI.RawOptimizerAttribute("limits/absgap"), value)
    end
    return nothing
end

MOI.supports(::Optimizer, ::MOI.RelativeGapTolerance) = true
function MOI.get(o::Optimizer, ::MOI.RelativeGapTolerance)
    raw_value = MOI.get(o, MOI.RawOptimizerAttribute("limits/gap"))
    if raw_value == 0
        return nothing
    end
    return raw_value
end
function MOI.set(o::Optimizer, ::MOI.RelativeGapTolerance, value)
    if value === nothing
        MOI.set(o, MOI.RawOptimizerAttribute("limits/gap"), 0.0)
    else
        MOI.set(o, MOI.RawOptimizerAttribute("limits/gap"), value)
    end
    return nothing
end

MOI.supports(::Optimizer, ::MOI.SolverVersion) = true

MOI.get(::Optimizer, ::MOI.SolverVersion) = "v" * string(SCIP_versionnumber())

## model creation, query and modification

function MOI.is_empty(o::Optimizer)
    return length(o.inner.vars) == 0 && length(o.inner.conss) == 0
end

function MOI.empty!(o::Optimizer)
    # free the underlying problem
    free_scip(o.inner)
    # clear auxiliary mapping structures
    o.reference = PtrMap()
    o.constypes = ConsTypeMap()
    o.binbounds = Dict()
    o.start = Dict()
    # manually recreate empty o.inner (formerly done by creating a new mscip before ManagedSCIP was removed)
    scip = Ref{Ptr{SCIP_}}(C_NULL)
    @SCIP_CALL SCIPcreate(scip)
    @assert scip[] != C_NULL
    @SCIP_CALL SCIPincludeDefaultPlugins(scip[])
    @SCIP_CALL SCIP.SCIPcreateProbBasic(scip[], "")
    # create a new problem
    o.inner =
        SCIPData(scip, Dict(), Dict(), 0, 0, Dict(), Dict(), Dict(), Dict(), Dict(), Dict(), [])
    # reapply parameters
    for pair in o.params
        set_parameter(o.inner, pair.first, pair.second)
    end
    o.objective_sense = nothing
    o.objective_function_set = false
    o.conflict_status = MOI.COMPUTE_CONFLICT_NOT_CALLED
    o.moi_separator = nothing
    o.moi_heuristic = nothing
    return nothing
end

function MOI.copy_to(dest::Optimizer, src::MOI.ModelLike)
    return MOIU.default_copy_to(dest, src)
end

MOI.get(o::Optimizer, ::MOI.Name) = unsafe_string(SCIPgetProbName(o))
function MOI.set(o::Optimizer, ::MOI.Name, name::String)
    @SCIP_CALL SCIPsetProbName(o, name)
end

"""
    Presolving

Attribute for activating presolving in SCIP.
"""
struct Presolving <: MOI.AbstractOptimizerAttribute end

MOI.supports(o::Optimizer, ::Presolving) = true

function MOI.get(o::Optimizer, ::Presolving)
    return MOI.get(o, MOI.RawOptimizerAttribute("presolving/maxrounds")) != 0
end

function MOI.set(o::Optimizer, ::Presolving, value::Bool)
    param = MOI.RawOptimizerAttribute("presolving/maxrounds")
    if value
        MOI.set(o, param, -1) # max presolving rounds
    else
        MOI.set(o, param, 0) # no presolving
    end
end

function MOI.get(o::Optimizer, ::MOI.NumberOfConstraints{F,S}) where {F,S}
    return haskey(o.constypes, (F, S)) ? length(o.constypes[F, S]) : 0
end

function MOI.get(o::Optimizer, ::MOI.ListOfConstraintTypesPresent)
    return collect(keys(o.constypes))
end

function MOI.get(o::Optimizer, ::MOI.ListOfConstraintIndices{F,S}) where {F,S}
    list_indices = Vector{CI{F,S}}()
    if !haskey(o.constypes, (F, S))
        return list_indices
    end
    for cref in o.constypes[F, S]
        push!(list_indices, CI{F,S}(cref.val))
    end
    return sort!(list_indices; by=v -> v.value)
end

function set_start_values(o::Optimizer)
    if isempty(o.start)
        # no primal start values are given
        return
    end

    # create new partial solution object
    sol__ = Ref{Ptr{SCIP_SOL}}(C_NULL)
    @SCIP_CALL SCIPcreatePartialSol(o, sol__, C_NULL)
    @assert sol__[] != C_NULL

    # set all given values
    sol_ = sol__[]
    for (vi, value) in o.start
        @SCIP_CALL SCIPsetSolVal(o, sol_, var(o, vi), value)
    end

    # submit the candidate
    stored_ = Ref{SCIP_Bool}(FALSE)
    @SCIP_CALL SCIPaddSolFree(o, sol__, stored_)
    @assert sol__[] == C_NULL
end

function MOI.optimize!(o::Optimizer)
    set_start_values(o)
    if o.objective_sense == MOI.FEASIBILITY_SENSE
        MOI.set(o, MOI.ObjectiveFunction{SAF}(), SAF([], 0.0))
    end
    @SCIP_CALL SCIPsolve(o)
    return nothing
end

function MOI.delete(o::Optimizer, ci::CI{F,S}) where {F,S}
    _throw_if_invalid(o, ci)
    allow_modification(o)
    delete!(o.constypes[F, S], ConsRef(ci.value))
    if isempty(o.constypes[F, S])
        delete!(o.constypes, (F, S))
    end
    delete!(o.reference, cons(o, ci))
    delete(o.inner, ConsRef(ci.value))
    return nothing
end

function MOI.get(o::Optimizer, ::MOI.ListOfVariableAttributesSet)
    attributes = MOI.AbstractVariableAttribute[MOI.VariableName()]
    if !isempty(o.start)
        push!(attributes, MOI.VariablePrimalStart())
    end
    return attributes
end

function MOI.get(o::Optimizer, ::MOI.ListOfModelAttributesSet)
    ret = MOI.AbstractModelAttribute[MOI.Name()]
    if o.objective_sense !== nothing
        push!(ret, MOI.ObjectiveSense())
    end
    if o.objective_function_set
        F = MOI.get(o, MOI.ObjectiveFunctionType())
        push!(ret, MOI.ObjectiveFunction{F}())
    end
    return ret
end

function MOI.get(
    ::Optimizer,
    ::MOI.ListOfConstraintAttributesSet{F,S},
) where {F,S}
    attributes = MOI.AbstractConstraintAttribute[]
    if F != MOI.VariableIndex
        return push!(attributes, MOI.ConstraintName())
    end
    return attributes
end

function MOI.get(::Optimizer, ::MOI.ListOfOptimizerAttributesSet)
    attributes = MOI.ListOfOptimizerAttributesSet[]
    timelim = MOI.get(o, MOI.TimeLimitSec())
    if timelim !== nothing
        push!(attributes, MOI.TimeLimitSec())
    end
    return attributes
end

function MOI.compute_conflict!(o::Optimizer)
    if o.conflict_status != MOI.COMPUTE_CONFLICT_NOT_CALLED
        error("Conflict computation is destructive for the model and cannot be called twice.")
    end
    # free the transformed problem first
    if LibSCIP.SCIPgetStage(o) != LibSCIP.SCIP_STAGE_PROBLEM
        @SCIP_CALL LibSCIP.SCIPfreeTransform(o)
    end
    # first transform all variable bound constraints to constraint bounds
    for (F, S) in MOI.get(o, MOI.ListOfConstraintTypesPresent())
        sname = replace(string(S), "MathOptInterface." => "", "{Float64}" => "")
        if Tuple{F, S} <: Tuple{VI, BOUNDS}
            for (idx, c_index) in enumerate(MOI.get(o, MOI.ListOfConstraintIndices{F,S}()))
                s = MOI.get(o, MOI.ConstraintSet(), c_index)
                MOI.delete(o, c_index)
                vi = MOI.VariableIndex(c_index.value)
                ci_new = MOI.add_constraint(o, 1.0 * vi, s)
                MOI.set(o, MOI.ConstraintName(), ci_new, "varcons_$(c_index.value)_$sname")
            end
        end
    end
    # we need names for all constraints
    for (F, S) in MOI.get(o, MOI.ListOfConstraintTypesPresent())
        if F === VI
            continue
        end
        for (idx, c_index) in enumerate(MOI.get(o, MOI.ListOfConstraintIndices{F,S}()))
            if MOI.get(o, MOI.ConstraintName(), c_index) == ""
                cons_ptr = cons(o, c_index)
                handler_name = unsafe_string(SCIPconshdlrGetName(SCIPconsGetHdlr(cons_ptr)))
                cons_name = "$(handler_name)_moi_$(idx)"
                MOI.set(o, MOI.ConstraintName(), c_index, cons_name)
            end
        end
    end
    success = Ref{LibSCIP.SCIP_Bool}(SCIP.FALSE)
    @SCIP_CALL LibSCIP.SCIPtransformMinUC(o, success)
    if success[] != SCIP.TRUE
        error("Failed to compute the minimum unsatisfied constraints system.\nSome constraint types may not support the required transformations")
    end
    MOI.optimize!(o)
    st = MOI.get(o, MOI.TerminationStatus())
    if st != MOI.OPTIMAL
        error("Unexpected status $st when computing conflicts")
    end
    o.conflict_status = if MOI.get(o, MOI.ObjectiveValue()) > 0
        MOI.CONFLICT_FOUND
    else
        MOI.NO_CONFLICT_EXISTS
    end
    return
end

MOI.get(o::Optimizer, ::MOI.ConflictStatus) = o.conflict_status

function MOI.get(o::Optimizer, ::MOI.ConstraintConflictStatus, index::MOI.ConstraintIndex{MOI.VariableIndex})
    o.conflict_status == MOI.CONFLICT_FOUND || error("no conflict")
    # we cannot determine whether variable constraint (integer, binary, variable bounds) participate
    return MOI.MAYBE_IN_CONFLICT
end

function MOI.get(o::Optimizer, ::MOI.ConstraintConflictStatus, index::MOI.ConstraintIndex)
    o.conflict_status == MOI.CONFLICT_FOUND || error("no conflict")
    c_name = MOI.get(o, MOI.ConstraintName(), index)
    slack_name = "$(c_name)_master"
    ptr = SCIPfindVar(o, slack_name)
    if ptr == C_NULL
        error("No constraint name corresponds to the index $index - name $c_name")
    end
    sol = SCIPgetBestSol(o)
    slack_value = SCIPgetSolVal(o, sol, ptr)
    return slack_value > 0.5 ? MOI.IN_CONFLICT : MOI.NOT_IN_CONFLICT
end

include(joinpath("MOI_wrapper", "variable.jl"))
include(joinpath("MOI_wrapper", "constraints.jl"))
include(joinpath("MOI_wrapper", "linear_constraints.jl"))
include(joinpath("MOI_wrapper", "quadratic_constraints.jl"))
include(joinpath("MOI_wrapper", "sos_constraints.jl"))
include(joinpath("MOI_wrapper", "indicator_constraints.jl"))
include(joinpath("MOI_wrapper", "nonlinear_constraints.jl"))
include(joinpath("MOI_wrapper", "objective.jl"))
include(joinpath("MOI_wrapper", "results.jl"))
include(joinpath("MOI_wrapper", "conshdlr.jl"))
include(joinpath("MOI_wrapper", "sepa.jl"))
include(joinpath("MOI_wrapper", "heuristic.jl"))
