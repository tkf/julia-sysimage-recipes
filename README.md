# Customized scripts for using [PackageCompiler.jl](https://github.com/JuliaLang/PackageCompiler.jl)

Generated system images are compatible with
[JuliaManager.jl / `jlm`](https://github.com/tkf/JuliaManager.jl).

Currently, following "recipes" are [tested](https://travis-ci.com/tkf/julia-sysimage-recipes).

<!-- table start -->

| Recipe | Build Status |  |
| --- | --- | --- |
| [`all`](https://github.com/tkf/julia-sysimage-recipes/tree/all/master) | [![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=all/master)](https://travis-ci.com/tkf/julia-sysimage-recipes/branches) | [`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/all/master/Project.toml) |
| [`all2`](https://github.com/tkf/julia-sysimage-recipes/tree/all2/master) | [![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=all2/master)](https://travis-ci.com/tkf/julia-sysimage-recipes/branches) | [`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/all2/master/Project.toml) |
| [`plots`](https://github.com/tkf/julia-sysimage-recipes/tree/plots/master) | [![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=plots/master)](https://travis-ci.com/tkf/julia-sysimage-recipes/branches) | [`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/plots/master/Project.toml) |
| [`python`](https://github.com/tkf/julia-sysimage-recipes/tree/python/master) | [![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=python/master)](https://travis-ci.com/tkf/julia-sysimage-recipes/branches) | [`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/python/master/Project.toml) |
| [`rebugger`](https://github.com/tkf/julia-sysimage-recipes/tree/rebugger/master) | [![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=rebugger/master)](https://travis-ci.com/tkf/julia-sysimage-recipes/branches) | [`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/rebugger/master/Project.toml) |
| [`diffeq`](https://github.com/tkf/julia-sysimage-recipes/tree/diffeq/master) | [![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=diffeq/master)](https://travis-ci.com/tkf/julia-sysimage-recipes/branches) | [`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/diffeq/master/Project.toml) |

<!-- table end -->

Look at `Project.toml` (e.g.,
[`all/Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/all/master/Project.toml))
and also corresponding `Manifest.toml` if any for the full set of
packages that are compiled into the system image.

Usage:

```sh
make checkout
cd $RECIPE_DIR  # e.g., `cd all`
make            # compile system image at $RECIPE_DIR/build/x.y.z/sys.so
make repl       # start a Julia session
```

Use `make JULIA=custom-julia` to use `custom-julia` executable instead
of `julia`.
