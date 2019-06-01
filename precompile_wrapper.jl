# include: lib/precompile_preamble.jl
Base.include(Module(), joinpath(@__DIR__, "lib", "precompile_preamble.jl"))

Base.include(Module(), "precompile.jl")
