# Julia wrapper for header: /usr/include/scip/scip_randnumgen.h
# Automatically generated using Clang.jl wrap_c, version 0.0.0


function SCIPcreateRandom(scip, randnumgen, initialseed::UInt32, useglobalseed::UInt32)
    ccall((:SCIPcreateRandom, libscip), SCIP_RETCODE, (Ptr{SCIP}, Ptr{Ptr{SCIP_RANDNUMGEN}}, UInt32, UInt32), scip, randnumgen, initialseed, useglobalseed)
end

function SCIPfreeRandom(scip, randnumgen)
    ccall((:SCIPfreeRandom, libscip), Cvoid, (Ptr{SCIP}, Ptr{Ptr{SCIP_RANDNUMGEN}}), scip, randnumgen)
end

function SCIPsetRandomSeed(scip, randnumgen, seed::UInt32)
    ccall((:SCIPsetRandomSeed, libscip), Cvoid, (Ptr{SCIP}, Ptr{SCIP_RANDNUMGEN}, UInt32), scip, randnumgen, seed)
end

function SCIPinitializeRandomSeed(scip, initialseedvalue::UInt32)
    ccall((:SCIPinitializeRandomSeed, libscip), UInt32, (Ptr{SCIP}, UInt32), scip, initialseedvalue)
end
