using VegaLite, VegaDatasets, DataFrames

data = dataset("cars")
plotter = @vlplot(
    :point,
    x=:Horsepower,
    y=:Miles_per_Gallon,
    color=:Origin,
    width=400,
    height=400
)

p1 = data |> plotter
p2 = data |> DataFrame |> plotter

show(devnull, "image/svg+xml", p1)
show(devnull, "image/svg+xml", p2)
