#!/bin/sh
julia --project --startup-file=no -O3 --check-bounds=no runbenchmarks.jl
