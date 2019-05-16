using SHA: bytes2hex, sha256

for (path, url, checksum) in [
    ("python/precompile.jl",
     "https://raw.githubusercontent.com/tkf/julia-sysimage-recipes/ae79bc8b3c10d6018d934f27dd0f9abfe573fcba/precompile.jl",
     "bc6c6eaec1010534df177a45c7ef52e0fdf8332e006979de1be4180ce7c6e978"),
    ("plots/precompile.jl",
     "https://raw.githubusercontent.com/tkf/julia-sysimage-recipes/6e939c99e31e7cdec0f0e9d64f1986fc6f2d3d19/precompile.jl",
     "37bbdd1826c889ab1c5ee683b3ec72d61a670cff8e3e6a581210651c52772902")
]
    mkpath(dirname(path))
    if !(isfile(path) && bytes2hex(sha256(read(path))) == checksum)
        @info "Downloading $path from $url"
        download(url, path)
    end
    actual_checksum = bytes2hex(sha256(read(path)))
    if actual_checksum != checksum
        error("""
        Invalid checksum for $path.
        Actual  : $actual_checksum
        Expected: $checksum
        """)
    end
end
