## Controller benchmarks

Run `./run_lcm_timing.sh` in this directory to generate an LCM log file. It may take a while to precompile all of the packages.

After generating the LCM log file, run `jupyter notebook` (after [setting up IJulia](https://github.com/JuliaLang/IJulia.jl)), open the `Controller dt histogram.` notebook, change the `lcmlog` variable to the file name of the LCM log that was created using `run_lcm_timing.sh` and run all cells to generate a histogram similar to Fig. 6.

Run `./run.sh` to run a 10 second simulation with visualization.
