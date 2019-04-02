sysout, = ARGS
outdir = dirname(sysout)

using PackageCompiler

systmp, _curr_syso = compile_incremental(
    joinpath(outdir, "Project.toml"),
    joinpath(@__DIR__, "precompile_wrapper.jl"),
)

cp(systmp, sysout, force=true)

write(joinpath(outdir, "julia_executable"), Base.julia_cmd().exec[1])
