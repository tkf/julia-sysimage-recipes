# include: ../lib/precompile_preamble.jl
Base.include(Main, joinpath(@__DIR__, "..", "lib", "precompile_preamble.jl"))

import Plots

let xs = ones(3)
    Plots.plot(xs)
    Plots.histogram(xs)
    Plots.scatter(xs)
end
