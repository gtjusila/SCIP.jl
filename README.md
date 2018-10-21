# SCIP.jl
Julia interface to [SCIP](http://scip.zib.de) solver.

[![Build Status](https://travis-ci.org/SCIP-Interfaces/SCIP.jl.svg?branch=master)](https://travis-ci.org/SCIP-Interfaces/SCIP.jl)

## Related Projects

- [SCIP](http://scip.zib.de): actual solver (implemented in C) that is wrapped
  for Julia.
- [CSIP](https://github.com/SCIP-Interfaces/CSIP): restricted and simplified C
  interface to SCIP which our wrapper is based on.
- [SCIP.jl](https://github.com/ryanjoneil/SCIP.jl): previous attempt to
  interface SCIP from Julia, using autogenerated wrapper code for all public
  functions.
- [MathProgBase](https://github.com/JuliaOpt/MathProgBase.jl): We aim to
  implement MPB's abstract solver interfaces, so that one can use SCIP.jl
  through [JuMP](https://github.com/JuliaOpt/JuMP.jl). For now, the
  `LinearQuadraticModel` interface is implemented, supporting lazy constraint
  and heuristic callbacks.

## Installation

**Note**: These instructions are meant for and only tested with GNU/Linux. OS X used to work, 
but there is an issue (#46) since the update to SCIP 4.0.0.

Follow the steps below to get SCIP.jl working. Unfortunately, these steps can not be automated as part of `Pkg.build("SCIP")`, because the academic license of SCIP does not allow distribution of the source code without tracking the download metadata. See the [license](http://scip.zib.de/academic.txt) for details.

1.The SCIP.jl package requires [SCIP](http://scip.zib.de/) to be installed in a recent version (e.g. 6.0.0).
[Download](http://scip.zib.de) the SCIP Optimization Suite.
```
tar xzf scipoptsuite-6.0.0.tgz
```

2.Choose an installation path and set the **environment variable `SCIPOPTDIR`** to point there.
```
export SCIPOPTDIR=`my/install/dir`
```

3.Build and install the shared library with
```
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$SCIPOPTDIR ..
make
make install
```

4.This package is registered in `METADATA.jl` and can be installed in Julia with
```
Pkg.add("SCIP")
```

## Setting Parameters

SCIP has a [long list of parameters](http://scip.zib.de/doc/html/PARAMETERS.php)
that can all be set through SCIP.jl, by passing them to the constructor of
`SCIPSolver`. To set a value `val` to a parameter `name`, pass the two
parameters `(name, val)`. For example, let's set two parameters, to disable
output and increase the gap limit to 0.05:
```
solver = SCIPSolver("display/verblevel", 0, "limits/gap", 0.05)
```
