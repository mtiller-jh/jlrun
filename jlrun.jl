using Pkg

if length(ARGS)!=2 && length(ARGS)!=1
    println("jlrun <package> [<script>]")
    exit(1)
end

pkg = ARGS[1]
script = length(ARGS)==2 ? ARGS[2] : "run"

println("ARGS = $(ARGS)")
println("ARGV = $(PROGRAM_FILE)")
println("Package: $(pkg)")
println("Script: $(script)")
# Run using to get Module loaded
eval(Meta.parse("using $(pkg)"))
m = eval(Meta.parse(pkg))
dir = Pkg.pkgdir(m)
println("Package directory: $(dir)")
scriptfile = joinpath(dir, "scripts", "$(script).jl")
println("Scriptfile: $(scriptfile)")

ENV["JULIA_PROJECT"] = dir
include(scriptfile)

