RECIPES = ["all", "all2", "plots", "python", "rebugger", "diffeq"]

function genreadme(io, lines)
    tablestart = findfirst(x -> x == "<!-- table start -->", lines)
    tableend = findfirst(x -> x == "<!-- table end -->", lines)
    for ln in lines[1:tablestart-1]
        println(io, ln)
    end
    println(io, "<!-- table start -->")
    println(io)
    println(io, "| Recipe | Build Status |  |")
    println(io, "| --- | --- | --- |")
    for recipe in RECIPES
        recipelink = "[`$recipe`](https://github.com/tkf/julia-sysimage-recipes/tree/$recipe/master)"
        travis = "[![Build Status](https://travis-ci.com/tkf/julia-sysimage-recipes.svg?branch=$recipe/master)](https://travis-ci.com/tkf/julia-sysimage-recipes)"
        project = "[`Project.toml`](https://github.com/tkf/julia-sysimage-recipes/blob/$recipe/master/Project.toml)"
        println(io, "| $recipelink | $travis | $project |")
    end
    println(io)
    println(io, "<!-- table end -->")
    for ln in lines[tableend+1:end]
        println(io, ln)
    end
end

function genreadme(path = "README.md")
    lines = readlines(path)
    open(path, "w") do io
        genreadme(io, lines)
    end
end

function printreadme(path = "README.md")
    genreadme(stdout, readlines(path))
end

if abspath(PROGRAM_FILE) == @__FILE__
    genreadme()
end
