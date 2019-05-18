import IPython
precompile(IPython.start_ipython, ())
precompile(IPython.JuliaAPI.eval_str, (String,))
precompile(IPython.JuliaAPI.completions, (String, Int, Module))
precompile(IPython.JuliaAPI.completions, (String, Int))
precompile(IPython.init_repl, (IPython.REPL.LineEditREPL,))

import DataFrames
import Pandas
df = DataFrames.DataFrame(x=[1, 2, 3], y=[1.0, 2.0, 3.0])
display(DataFrames.DataFrame(Pandas.DataFrame(df)))
display(Pandas.DataFrame(df))
