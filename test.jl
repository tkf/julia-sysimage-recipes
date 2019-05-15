using Pkg
try
    Pkg.test("Rebugger")
catch exception
    @error "Ignoring Rebugger test failures" exception
end
Pkg.test(["Revise"])
