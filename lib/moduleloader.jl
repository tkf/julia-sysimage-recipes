module __Moduleloader

using Pkg.Operations: dependency_order_uuids
using Pkg.Types: Context, EnvCache

function sorted_packages(project=nothing)
    ctx = Context(env=EnvCache(project))
    uuids = collect(keys(ctx.env.manifest))
    order = dependency_order_uuids(ctx, uuids)
    packages = [
        Base.PkgId(uuid, String(pkgentry.name))
        for (uuid, pkgentry) in ctx.env.manifest if haskey(order, uuid)]
    sort!(packages, by = pkg -> order[pkg.uuid])
    return packages
end

"""
    loade_all_packages(tomlpath=nothing)

Load packages in `tomlpath` ordered by dependency.

See: https://github.com/JuliaLang/PackageCompiler.jl/issues/192
"""
function loade_all_packages(tomlpath=nothing)

    @debug "Loading standard libraries..."
    # See: https://github.com/JuliaLang/julia/issues/31621

    # Following list is taken from
    # https://github.com/JuliaLang/julia/blob/v1.1.0/base/sysimg.jl#L494-L525
    #
    # Stdlibs manually sorted in top down order
    stdlibs = [
            # No deps
            :Base64,
            :CRC32c,
            :SHA,
            :FileWatching,
            :Unicode,
            :Mmap,
            :Serialization,
            :Libdl,
            :Markdown,
            :LibGit2,
            :Logging,
            :Sockets,
            :Printf,
            :Profile,
            :Dates,
            :DelimitedFiles,
            :Random,
            :UUIDs,
            :Future,
            :LinearAlgebra,
            :SparseArrays,
            :SuiteSparse,
            :Distributed,
            :SharedArrays,
            :Pkg,
            :Test,
            :REPL,
            :Statistics,
        ]

    ctx = Context()
    stdlibids = Dict(
        Symbol(name) => Base.PkgId(uuid, name)
        for (uuid, name) in ctx.stdlibs
    )
    for name in stdlibs
        pkg = stdlibids[name]

        @debug "Loading stdlib $pkg"
        mod = Base.require(pkg)

        # TODO: minimize the list (or maybe whilte listing?)
        if pkg.name in [
                "REPL"
                "Logging"
                "FileWatching"
                "Distributed"
                ]
            # avoid "Task cannot be serialized"
            precompile(mod.__init__, ())
            continue
        end

        isdefined(mod, :__init__) && Base.invokelatest(mod.__init__)
        # TODO: call `__init__` of sub-modules
    end

    @debug "Loading all packages in manifest..."
    # See: https://github.com/JuliaLang/PackageCompiler.jl/issues/192

    for pkg in sorted_packages(tomlpath)
        if pkg.name in [
                "DiffBase"
                ]
            @info "Skip loading $(pkg.name)"
            continue
        end

        @debug "Loading $pkg"
        mod = Base.require(pkg)

        if pkg.name in [
                "IPython"
                "PyPlot"
                "Revise"
                "Rebugger"
                ]
            # avoid "Task cannot be serialized"
            precompile(mod.__init__, ())
            continue
        end

        isdefined(mod, :__init__) && Base.invokelatest(mod.__init__)
        # TODO: call `__init__` of sub-modules
    end
    @debug "All packages loaded"
end

end  # module
