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

function loade_all_packages(tomlpath=nothing)
    for pkg in sorted_packages(tomlpath)
        @debug "Loading $pkg"
        mod = Base.require(pkg)

        if pkg.name in ["IPython", "PyPlot"]
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
