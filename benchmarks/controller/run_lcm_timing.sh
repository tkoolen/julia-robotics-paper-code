#!/bin/bash
julia --project --color=yes -e 'using Pkg; pkg"precompile"; using HumanoidLCMSim'
lcm-logger &
julia --project -O3 --check-bounds=no --color=yes -e 'using HumanoidLCMSim; AtlasControl.run()' &
julia --project -O3 --check-bounds=no --color=yes -e 'using HumanoidLCMSim; AtlasSim.run(final_time=10.0, max_rate=1.0, headless=true)'

# Clean up child process on exit: https://stackoverflow.com/a/2173421/641846
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT