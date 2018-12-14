# Julia wrapper for header: /usr/include/scip/scip_solvingstats.h
# Automatically generated using Clang.jl wrap_c, version 0.0.0


function SCIPgetNRuns(scip)
    ccall((:SCIPgetNRuns, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNReoptRuns(scip)
    ccall((:SCIPgetNReoptRuns, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPaddNNodes(scip, nnodes::Clonglong)
    ccall((:SCIPaddNNodes, libscip), Cvoid, (Ptr{SCIP}, Clonglong), scip, nnodes)
end

function SCIPgetNNodes(scip)
    ccall((:SCIPgetNNodes, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNTotalNodes(scip)
    ccall((:SCIPgetNTotalNodes, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNFeasibleLeaves(scip)
    ccall((:SCIPgetNFeasibleLeaves, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNInfeasibleLeaves(scip)
    ccall((:SCIPgetNInfeasibleLeaves, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNObjlimLeaves(scip)
    ccall((:SCIPgetNObjlimLeaves, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDelayedCutoffs(scip)
    ccall((:SCIPgetNDelayedCutoffs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNLPs(scip)
    ccall((:SCIPgetNLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNLPIterations(scip)
    ccall((:SCIPgetNLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNNZs(scip)
    ccall((:SCIPgetNNZs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNRootLPIterations(scip)
    ccall((:SCIPgetNRootLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNRootFirstLPIterations(scip)
    ccall((:SCIPgetNRootFirstLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNPrimalLPs(scip)
    ccall((:SCIPgetNPrimalLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNPrimalLPIterations(scip)
    ccall((:SCIPgetNPrimalLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDualLPs(scip)
    ccall((:SCIPgetNDualLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDualLPIterations(scip)
    ccall((:SCIPgetNDualLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNBarrierLPs(scip)
    ccall((:SCIPgetNBarrierLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNBarrierLPIterations(scip)
    ccall((:SCIPgetNBarrierLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNResolveLPs(scip)
    ccall((:SCIPgetNResolveLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNResolveLPIterations(scip)
    ccall((:SCIPgetNResolveLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNPrimalResolveLPs(scip)
    ccall((:SCIPgetNPrimalResolveLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNPrimalResolveLPIterations(scip)
    ccall((:SCIPgetNPrimalResolveLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDualResolveLPs(scip)
    ccall((:SCIPgetNDualResolveLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDualResolveLPIterations(scip)
    ccall((:SCIPgetNDualResolveLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNNodeLPs(scip)
    ccall((:SCIPgetNNodeLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNNodeLPIterations(scip)
    ccall((:SCIPgetNNodeLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNNodeInitLPs(scip)
    ccall((:SCIPgetNNodeInitLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNNodeInitLPIterations(scip)
    ccall((:SCIPgetNNodeInitLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDivingLPs(scip)
    ccall((:SCIPgetNDivingLPs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNDivingLPIterations(scip)
    ccall((:SCIPgetNDivingLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNStrongbranchs(scip)
    ccall((:SCIPgetNStrongbranchs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNStrongbranchLPIterations(scip)
    ccall((:SCIPgetNStrongbranchLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNRootStrongbranchs(scip)
    ccall((:SCIPgetNRootStrongbranchs, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNRootStrongbranchLPIterations(scip)
    ccall((:SCIPgetNRootStrongbranchLPIterations, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNPriceRounds(scip)
    ccall((:SCIPgetNPriceRounds, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNPricevars(scip)
    ccall((:SCIPgetNPricevars, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNPricevarsFound(scip)
    ccall((:SCIPgetNPricevarsFound, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNPricevarsApplied(scip)
    ccall((:SCIPgetNPricevarsApplied, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNSepaRounds(scip)
    ccall((:SCIPgetNSepaRounds, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNCutsFound(scip)
    ccall((:SCIPgetNCutsFound, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNCutsFoundRound(scip)
    ccall((:SCIPgetNCutsFoundRound, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNCutsApplied(scip)
    ccall((:SCIPgetNCutsApplied, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNConflictConssFound(scip)
    ccall((:SCIPgetNConflictConssFound, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNConflictConssFoundNode(scip)
    ccall((:SCIPgetNConflictConssFoundNode, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNConflictConssApplied(scip)
    ccall((:SCIPgetNConflictConssApplied, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetMaxDepth(scip)
    ccall((:SCIPgetMaxDepth, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetMaxTotalDepth(scip)
    ccall((:SCIPgetMaxTotalDepth, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNBacktracks(scip)
    ccall((:SCIPgetNBacktracks, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNActiveConss(scip)
    ccall((:SCIPgetNActiveConss, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetNEnabledConss(scip)
    ccall((:SCIPgetNEnabledConss, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPgetAvgDualbound(scip)
    ccall((:SCIPgetAvgDualbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgLowerbound(scip)
    ccall((:SCIPgetAvgLowerbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetDualbound(scip)
    ccall((:SCIPgetDualbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetLowerbound(scip)
    ccall((:SCIPgetLowerbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetDualboundRoot(scip)
    ccall((:SCIPgetDualboundRoot, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetLowerboundRoot(scip)
    ccall((:SCIPgetLowerboundRoot, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetFirstLPDualboundRoot(scip)
    ccall((:SCIPgetFirstLPDualboundRoot, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetFirstLPLowerboundRoot(scip)
    ccall((:SCIPgetFirstLPLowerboundRoot, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetFirstPrimalBound(scip)
    ccall((:SCIPgetFirstPrimalBound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetPrimalbound(scip)
    ccall((:SCIPgetPrimalbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetUpperbound(scip)
    ccall((:SCIPgetUpperbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetCutoffbound(scip)
    ccall((:SCIPgetCutoffbound, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPupdateCutoffbound(scip, cutoffbound::Cdouble)
    ccall((:SCIPupdateCutoffbound, libscip), SCIP_RETCODE, (Ptr{SCIP}, Cdouble), scip, cutoffbound)
end

function SCIPisPrimalboundSol(scip)
    ccall((:SCIPisPrimalboundSol, libscip), UInt32, (Ptr{SCIP},), scip)
end

function SCIPgetGap(scip)
    ccall((:SCIPgetGap, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetTransGap(scip)
    ccall((:SCIPgetTransGap, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetNSolsFound(scip)
    ccall((:SCIPgetNSolsFound, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNLimSolsFound(scip)
    ccall((:SCIPgetNLimSolsFound, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetNBestSolsFound(scip)
    ccall((:SCIPgetNBestSolsFound, libscip), Clonglong, (Ptr{SCIP},), scip)
end

function SCIPgetAvgPseudocost(scip, solvaldelta::Cdouble)
    ccall((:SCIPgetAvgPseudocost, libscip), Cdouble, (Ptr{SCIP}, Cdouble), scip, solvaldelta)
end

function SCIPgetAvgPseudocostCurrentRun(scip, solvaldelta::Cdouble)
    ccall((:SCIPgetAvgPseudocostCurrentRun, libscip), Cdouble, (Ptr{SCIP}, Cdouble), scip, solvaldelta)
end

function SCIPgetAvgPseudocostCount(scip, dir::SCIP_BRANCHDIR)
    ccall((:SCIPgetAvgPseudocostCount, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR), scip, dir)
end

function SCIPgetAvgPseudocostCountCurrentRun(scip, dir::SCIP_BRANCHDIR)
    ccall((:SCIPgetAvgPseudocostCountCurrentRun, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR), scip, dir)
end

function SCIPgetPseudocostCount(scip, dir::SCIP_BRANCHDIR, onlycurrentrun::UInt32)
    ccall((:SCIPgetPseudocostCount, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR, UInt32), scip, dir, onlycurrentrun)
end

function SCIPgetAvgPseudocostScore(scip)
    ccall((:SCIPgetAvgPseudocostScore, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetPseudocostVariance(scip, branchdir::SCIP_BRANCHDIR, onlycurrentrun::UInt32)
    ccall((:SCIPgetPseudocostVariance, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR, UInt32), scip, branchdir, onlycurrentrun)
end

function SCIPgetAvgPseudocostScoreCurrentRun(scip)
    ccall((:SCIPgetAvgPseudocostScoreCurrentRun, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgConflictScore(scip)
    ccall((:SCIPgetAvgConflictScore, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgConflictScoreCurrentRun(scip)
    ccall((:SCIPgetAvgConflictScoreCurrentRun, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgConflictlengthScore(scip)
    ccall((:SCIPgetAvgConflictlengthScore, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgConflictlengthScoreCurrentRun(scip)
    ccall((:SCIPgetAvgConflictlengthScoreCurrentRun, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgInferences(scip, dir::SCIP_BRANCHDIR)
    ccall((:SCIPgetAvgInferences, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR), scip, dir)
end

function SCIPgetAvgInferencesCurrentRun(scip, dir::SCIP_BRANCHDIR)
    ccall((:SCIPgetAvgInferencesCurrentRun, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR), scip, dir)
end

function SCIPgetAvgInferenceScore(scip)
    ccall((:SCIPgetAvgInferenceScore, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgInferenceScoreCurrentRun(scip)
    ccall((:SCIPgetAvgInferenceScoreCurrentRun, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgCutoffs(scip, dir::SCIP_BRANCHDIR)
    ccall((:SCIPgetAvgCutoffs, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR), scip, dir)
end

function SCIPgetAvgCutoffsCurrentRun(scip, dir::SCIP_BRANCHDIR)
    ccall((:SCIPgetAvgCutoffsCurrentRun, libscip), Cdouble, (Ptr{SCIP}, SCIP_BRANCHDIR), scip, dir)
end

function SCIPgetAvgCutoffScore(scip)
    ccall((:SCIPgetAvgCutoffScore, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetAvgCutoffScoreCurrentRun(scip)
    ccall((:SCIPgetAvgCutoffScoreCurrentRun, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPgetDeterministicTime(scip)
    ccall((:SCIPgetDeterministicTime, libscip), Cdouble, (Ptr{SCIP},), scip)
end

function SCIPprintOrigProblem(scip, file, extension, genericnames::UInt32)
    ccall((:SCIPprintOrigProblem, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{FILE}, Cstring, UInt32), scip, file, extension, genericnames)
end

function SCIPprintTransProblem(scip, file, extension, genericnames::UInt32)
    ccall((:SCIPprintTransProblem, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{FILE}, Cstring, UInt32), scip, file, extension, genericnames)
end

function SCIPprintStatusStatistics(scip, file)
    ccall((:SCIPprintStatusStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintTimingStatistics(scip, file)
    ccall((:SCIPprintTimingStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintOrigProblemStatistics(scip, file)
    ccall((:SCIPprintOrigProblemStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintTransProblemStatistics(scip, file)
    ccall((:SCIPprintTransProblemStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintPresolverStatistics(scip, file)
    ccall((:SCIPprintPresolverStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintConstraintStatistics(scip, file)
    ccall((:SCIPprintConstraintStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintConstraintTimingStatistics(scip, file)
    ccall((:SCIPprintConstraintTimingStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintPropagatorStatistics(scip, file)
    ccall((:SCIPprintPropagatorStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintConflictStatistics(scip, file)
    ccall((:SCIPprintConflictStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintSeparatorStatistics(scip, file)
    ccall((:SCIPprintSeparatorStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintPricerStatistics(scip, file)
    ccall((:SCIPprintPricerStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintBranchruleStatistics(scip, file)
    ccall((:SCIPprintBranchruleStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintHeuristicStatistics(scip, file)
    ccall((:SCIPprintHeuristicStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintCompressionStatistics(scip, file)
    ccall((:SCIPprintCompressionStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintLPStatistics(scip, file)
    ccall((:SCIPprintLPStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintNLPStatistics(scip, file)
    ccall((:SCIPprintNLPStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintRelaxatorStatistics(scip, file)
    ccall((:SCIPprintRelaxatorStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintTreeStatistics(scip, file)
    ccall((:SCIPprintTreeStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintRootStatistics(scip, file)
    ccall((:SCIPprintRootStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintSolutionStatistics(scip, file)
    ccall((:SCIPprintSolutionStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintConcsolverStatistics(scip, file)
    ccall((:SCIPprintConcsolverStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintBendersStatistics(scip, file)
    ccall((:SCIPprintBendersStatistics, libscip), Cvoid, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintStatistics(scip, file)
    ccall((:SCIPprintStatistics, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintReoptStatistics(scip, file)
    ccall((:SCIPprintReoptStatistics, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintBranchingStatistics(scip, file)
    ccall((:SCIPprintBranchingStatistics, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{FILE}), scip, file)
end

function SCIPprintDisplayLine(scip, file, verblevel::SCIP_VERBLEVEL, endline::UInt32)
    ccall((:SCIPprintDisplayLine, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{FILE}, SCIP_VERBLEVEL, UInt32), scip, file, verblevel, endline)
end

function SCIPgetNImplications(scip)
    ccall((:SCIPgetNImplications, libscip), Cint, (Ptr{SCIP},), scip)
end

function SCIPwriteImplicationConflictGraph(scip, filename)
    ccall((:SCIPwriteImplicationConflictGraph, libscip), SCIP_RETCODE, (Ptr{SCIP}, Cstring), scip, filename)
end

function SCIPstoreSolutionGap(scip)
    ccall((:SCIPstoreSolutionGap, libscip), Cvoid, (Ptr{SCIP},), scip)
end
