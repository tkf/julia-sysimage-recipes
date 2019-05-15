import IPython
precompile(IPython.start_ipython, ())
precompile(IPython.JuliaAPI.eval_str, (String,))
precompile(IPython.JuliaAPI.completions, (String, Int, Module))
precompile(IPython.JuliaAPI.completions, (String, Int))
precompile(IPython.init_repl, (IPython.REPL.LineEditREPL,))
