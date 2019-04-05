using Pkg
Pkg.test(["PyCall"])
try
    Pkg.test("IPython")
catch exception
    @error "Ignoring IPython test failures" exception
end
