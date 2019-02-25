using RigidBodyDynamics
using Random
using BenchmarkTools
using LinearAlgebra

BLAS.set_num_threads(1) # see https://github.com/JuliaRobotics/RigidBodyDynamics.jl/issues/500

const ScalarType = Float64
# const ScalarType = Float32

function create_floating_atlas()
    urdf = joinpath(@__DIR__, "..", "atlas.urdf")
    atlas = parse_urdf(urdf, scalar_type=ScalarType, floating=true)
    atlas
end

function create_benchmark_suite()
    suite = BenchmarkGroup()
    mechanism = create_floating_atlas()

    state = MechanismState{ScalarType}(mechanism)
    result = DynamicsResult{ScalarType}(mechanism)
    nv = num_velocities(state)
    torques = similar(velocity(state))
    rootframe = root_frame(mechanism)
    centroidalframe = CartesianFrame3D("centroidal")
    mat = MomentumMatrix(centroidalframe, Matrix{ScalarType}(undef, 3, nv), Matrix{ScalarType}(undef, 3, nv))

    suite["mass_matrix!"] = @benchmarkable(begin
        setdirty!($state)
        mass_matrix!($(result.massmatrix), $state)
    end, setup = rand!($state), evals = 10)

    suite["dynamics_bias!"] = @benchmarkable(begin
        setdirty!($state)
        dynamics_bias!($result, $state)
    end, setup = begin
        rand!($state)
    end, evals = 10)

    suite["mass_matrix! + dynamics_bias!"] = @benchmarkable(begin
        setdirty!($state)
        mass_matrix!($(result.massmatrix), $state)
        dynamics_bias!($result, $state)
    end, setup = rand!($state), evals = 10)

    suite["inverse_dynamics!"] = @benchmarkable(begin
        setdirty!($state)
        inverse_dynamics!($torques, $(result.jointwrenches), $(result.accelerations), $state, v̇, externalwrenches)
    end, setup = begin
        v̇ = similar(velocity($state))
        rand!(v̇)
        externalwrenches = RigidBodyDynamics.BodyDict(convert(BodyID, body) => rand(Wrench{ScalarType}, root_frame($mechanism)) for body in bodies($mechanism))
        rand!($state)
    end, evals = 10)

    suite["dynamics!"] = @benchmarkable(begin
        setdirty!($state)
        dynamics!($result, $state, τ, externalwrenches)
    end, setup = begin
        rand!($state)
        τ = similar(velocity($state))
        rand!(τ)
        externalwrenches = RigidBodyDynamics.BodyDict(convert(BodyID, body) => rand(Wrench{ScalarType}, root_frame($mechanism)) for body in bodies($mechanism))
    end, evals = 10)

    suite["centroidal momentum_matrix!"] = @benchmarkable(begin
        setdirty!($state)
        com = center_of_mass($state)
        world_to_centroidal = Transform3D($rootframe, $centroidalframe, -com.v)
        momentum_matrix!($mat, $state, world_to_centroidal)
    end, setup = rand!($state), evals = 10)

    suite
end

function runbenchmarks()
    suite = create_benchmark_suite()
    overhead = BenchmarkTools.estimate_overhead()
    Random.seed!(1)
    results = run(suite, verbose=true, overhead=overhead, gctrial=false)
    for result in results
        println("$(first(result)):")
        display(last(result))
        println()
    end
end

runbenchmarks()
