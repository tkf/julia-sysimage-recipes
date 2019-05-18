using Pkg
Pkg.test([
    "Pandas"
    "DataFrames"
])

# Note: Testing PyCall will fail when Pandas is compiled into system
# image.  This is because Pandas fails when Python modules pandas and
# numpy are not found.  It happens during virtual environment tests.
