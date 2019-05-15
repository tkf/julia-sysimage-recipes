sysout, = ARGS
outdir = dirname(sysout)

using PackageCompiler

_toml, precompile = PackageCompiler.snoop_packages(:Makie, :AbstractPlotting)

wrapper = joinpath(@__DIR__, "build", "precompile_wrapper-$VERSION.jl")
preamble = joinpath(@__DIR__, "lib", "precompile_preamble.jl")
write(wrapper, """
Base.include(Main, $(repr(preamble)))
Base.include(Main, $(repr(precompile)))
""")

systmp, _curr_syso = compile_incremental(
    joinpath(outdir, "Project.toml"),
    wrapper,
)

cp(systmp, sysout, force=true)

write(joinpath(outdir, "julia_executable"), Base.julia_cmd().exec[1])
