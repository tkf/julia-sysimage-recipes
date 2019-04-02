# include: ../lib/precompile_preamble.jl
Base.include(Main, joinpath(@__DIR__, "..", "lib", "precompile_preamble.jl"))

import Plots

let xs = ones(3)
    mime = MIME("image/png")
    show(devnull, mime, Plots.plot(xs))
    show(devnull, mime, Plots.histogram(xs))
    show(devnull, mime, Plots.scatter(xs))
end
