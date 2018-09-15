#!/bin/bash
julia --project --color=yes -e 'using Pkg; pkg"precompile"'
julia --project -O3 --check-bounds=no --color=yes -e 'using HumanoidLCMSim; AtlasControl.run()' &
julia --project -O3 --check-bounds=no --color=yes -e 'using HumanoidLCMSim; AtlasSim.run(final_time=10.0)'
