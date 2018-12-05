using DFOLS
using Test, LinearAlgebra

@testset "Vanilla Tests" begin
    # Rosenbrock
    rosenbrock = x -> [10. * (x[2]-x[1]^2), 1. - x[1]]
    initial_values = ([-1.2, 1.],
                      [-3.4, 5.6],
                      [20.0, 34.5],
                      [3.14159, π]
                    )
    for x0 in initial_values
        sol = solve(rosenbrock, [-1.2, 1.])
        @test converged(sol) && flag(sol) == 0
        @test norm(residuals(sol)) < 1e-6
        @test abs(optimum(sol)) < 1e-10
        @test optimizer(sol)[1] ≈ 1.0
        @test optimizer(sol)[2] ≈ 1.0
    end
end

@testset "Tests with user_params Dicts" begin
end

@testset "Julia Edge Cases" begin
    rosenbrock = x -> [10. * (x[2]-x[1]^2), 1. - x[1]]
    @test converged(solve(rosenbrock, [-1.2, 1.], bounds = ([-Inf, -Inf], nothing)))
    @test converged(solve(rosenbrock, [-1.2, 1.], bounds = ([-Inf, -Inf], [Inf, Inf])))
end
