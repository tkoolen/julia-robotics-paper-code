## Julia for Robotics: Simulation and Real-time Control in a High-level Programming Language

This repository contains code associated with the paper "Julia for Robotics: Simulation and Real-time Control in a High-level Programming Language", submitted to ICRA 2019.

### Video

The video associated with the paper can be found [here](https://player.vimeo.com/video/320647370).

### Packages

Main packages discussed in the paper:

* [RigidBodyDynamics.jl](https://github.com/JuliaRobotics/RigidBodyDynamics.jl): rigid body dynamics library.
* [MeshCat.jl](https://github.com/rdeits/MeshCat.jl): 3D visualizer.
* [RigidBodySim.jl](https://github.com/JuliaRobotics/RigidBodySim.jl): a simulation environment.
* [Parametron.jl](https://github.com/tkoolen/Parametron.jl): optimization framework.
* [QPControl.jl](https://github.com/tkoolen/QPControl.jl): QP-based low-level control algorithms.

Additional relevant packages:

* [StrandBeestRobot.jl](https://github.com/rdeits/StrandbeestRobot.jl): simulation of a strandbeest-like mechanism, used to create Fig. 3.
* [LCMCore.jl](https://github.com/JuliaRobotics/LCMCore.jl): bindings to the LCM (Lightweight Communications and Marshalling) message passing library.
* [QPWalkingControl.jl](https://github.com/tkoolen/QPWalkingControl.jl): a walking controller for Atlas based on QPControl.jl (under development).

### Setup

To run benchmarks and notebooks locally, simply clone the package and follow the instructions below.

### Benchmarks

* [benchmarks/dynamics](https://github.com/tkoolen/julia-robotics-paper-code/tree/master/benchmarks/dynamics): code used to benchmark RigidBodyDynamics.jl and RBDL (Table I).
* [benchmarks/controller](https://github.com/tkoolen/julia-robotics-paper-code/tree/master/benchmarks/controller): controller benchmark code (used to create Fig. 6).

Please see the associated `README.md` for information on how to run these benchmarks.

The figure below shows an additional quick benchmark result for the standing controller that does *not* include network communication using LCMCore.jl, as opposed to the figure in the paper. There is one sample at 1.67 ms.

![dtbenchmarks](https://raw.githubusercontent.com/tkoolen/QPControl.jl/tk/bench/notebooks/controller_dt_histogram.png)

### Notebooks

The [`notebooks`](https://github.com/tkoolen/julia-robotics-paper-code/tree/master/notebooks) directory contains the Jupyter notebook used to generate Fig. 4.

Most of the packages listed above also have a `notebooks` directory with usage examples.
