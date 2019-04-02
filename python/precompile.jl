# include: ../lib/precompile_preamble.jl
Base.include(Main, joinpath(@__DIR__, "..", "lib", "precompile_preamble.jl"))

import IPython
precompile(IPython.start_ipython, ())
precompile(IPython.JuliaAPI.eval_str, (String,))
precompile(IPython.JuliaAPI.completions, (String, Int, Module))
precompile(IPython.JuliaAPI.completions, (String, Int))
precompile(IPython.init_repl, (IPython.REPL.LineEditREPL,))
