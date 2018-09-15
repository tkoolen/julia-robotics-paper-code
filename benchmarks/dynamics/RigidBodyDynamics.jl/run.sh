#!/bin/sh
# julia --project --color=yes -e 'import Pkg; Pkg.instantiate()'
julia --project --color=yes --startup-file=no -O3 --check-bounds=no runbenchmarks.jl
