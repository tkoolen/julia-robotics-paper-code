#!/bin/sh
~/code/julia/julia --project --startup-file=no -O3 --check-bounds=no -e 'import Pkg; Pkg.instantiate(); include("runbenchmarks.jl")'
