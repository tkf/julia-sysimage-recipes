# Customized scripts for using [PackageCompiler.jl](https://github.com/JuliaLang/PackageCompiler.jl)

[![Travis Status][travis-img]][travis-url]

Generated system images are compatible with
[JuliaManager.jl / `jlm`](https://github.com/tkf/JuliaManager.jl).

Currently, following "recipes" are [tested][travis-url].

* `all`: Plots, PyCall, Rebugger, etc.

* `plots`: Plots

* `python`: PyCall and IPython

* `rebugger`: Rebugger and Revise

* `diffeq`: OrdinaryDiffEq etc.

Look at `$RECIPE_DIR/Project.toml` (e.g.,
[`all/Project.toml`](all/Project.toml)) and also corresponding
`Manifest.toml` if any for the full set of packages that are compiled
into the system image.

Usage:

```sh
cd $RECIPE_DIR  # e.g., `cd all`
make            # compile system image at $RECIPE_DIR/build/x.y.z/sys.so
make repl       # start a Julia session
```

Use `make JULIA=custom-julia` to use `custom-julia` executable instead
of `julia`.

[travis-img]: https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=master
[travis-url]: https://travis-ci.com/tkf/julia-sysimage-recipes
