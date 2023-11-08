#!/usr/bin/env julia
using Pkg

# Parse command line arguments
if length(ARGS) == 0
    println("jlrun <package>[/<script>] ...")
    exit(1)
end

# Split out the script, if present
parts = split(ARGS[1], "/")
if length(parts) > 2
    println("jlrun <package>[/<script>] ...")
    exit(2)
end

# Extract values from arguments
pkg = parts[1]
script = get(parts, 2, "run")

# Trigger package where script exists to be loaded
eval(Meta.parse("using $(pkg)"))
# Get the Module object for that package
m = eval(Meta.parse(pkg))
# Get the directory where the module is stored
dir = Pkg.pkgdir(m)
# Identify the actual file to run
scriptfile = joinpath(dir, "scripts", "$(script).jl")

# Point Julia to the environment associated with the package
ENV["JULIA_PROJECT"] = dir

cmd::Vector{String} = []
push!(cmd, joinpath(Sys.BINDIR, Base.julia_exename()))
push!(cmd, "--project=$(dir)")
push!(cmd, scriptfile)
for a in ARGS[2:length(ARGS)]
    push!(cmd, a)
end

run(Cmd(cmd))