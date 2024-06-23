#=
User have to implement
- A mutable struct that inherit AbstractEventHandler. Note Structure must be mutable!!
- An eventexec function
=#
"""
Abstract eventhander
"""
abstract type AbstractEventHandler end

function eventexec end;

function _eventexec(
    scip::Ptr{SCIP_},
    eventhdlr::Ptr{SCIP_Eventhdlr},
    event::Ptr{SCIP_Event},
    eventdata::Ptr{SCIP_EventData}
)
    # Get Julia object out of eventhandler data
    data::Ptr{SCIP_EventData} = SCIPeventhdlrGetData(eventhdlr)
    event = unsafe_pointer_to_objref(data)
    #call user method
    eventexec(event)
    return SCIP_OKAY
end

"""
[EXPERIMENTAL]
A wrapper for SCIPincludeEventhdlrBasic. Eventdata is not yet supported. Cannot be called when SCIP is in problem creation stage

# Required Parameters
- scip::Ptr{SCIP_} pointer to scip
- eventhdlrs::Dict{Any, Ptr{SCIP_Eventhdlr}} Dictionary of eventhandlers from the SCIPData object
- event_handler::EVENTHDLR the actual eventhandler structure that is a subclass of AbstractEventHandler

# Optional Parameters
- name::String name of the event handler
- desc::String description of the event handler
"""
function include_event_handler(
    scip::Ptr{SCIP_},
    eventhdlrs::Dict{Any,Ptr{SCIP_Eventhdlr}},
    event_handler::EVENTHDLR;
    name::String = "",
    desc::String = ""
    ) where {EVENTHDLR <: AbstractEventHandler}

    @assert SCIPgetStage(scip) == SCIP.LibSCIP.SCIP_STAGE_PROBLEM
    _eventexec = @cfunction(
        _eventexec,
        SCIP_RETCODE,
        (
            Ptr{SCIP_},
            Ptr{SCIP_Eventhdlr},
            Ptr{SCIP_Event},
            Ptr{SCIP_EventData}
        )
    )

    c_handler = Ref{Ptr{SCIP_Eventhdlr}}(C_NULL)
    event_handler_data = pointer_from_objref(event_handler)

    if name == ""
        name = "__eventhdlr__$(length(eventhdlrs))"
    end

    @SCIP_CALL SCIPincludeEventhdlrBasic(
        scip,
        c_handler,
        name,
        desc,
        _eventexec,
        event_handler_data
    )
    
    @assert c_handler[] != C_NULL

    #Persist in scip store against GC
    eventhdlrs[event_handler] = c_handler[]
    
end
