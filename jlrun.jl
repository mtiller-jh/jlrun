#!/usr/bin/env julia
using Pkg

# This script takes one or two arguments.  The first argument is 
# the name of a package (currently assumes this exists in the 
# default environment only but if you set JULIA_PROJECT, it might 
# honor that).  If only one argument is provided, then this script
# looks for a file called ./scripts/run.jl in that package's
# directory structure and runs that **under the environment of
# that package** (i.e., using its Project.toml file).  If a second
# argument is provided, _e.g..,_ `foo`, then this script looks 
# for a script by that name, _e.g.,_ `scripts/foo.jl`, instead of 
# the default `scripts/run.jl`

# Parse command line arguments
if length(ARGS)==0
    println("jlrun <package>[/<script>]")
    exit(1)
end

parts = split(ARGS[1], "/")
if length(parts)>2
    println("jlrun <package>[/<script>]")
    exit(2)
end

# Extract values from arguments
pkg = parts[1]
script = length(parts)==2 ? parts[2] : "run"

# Trigger package where script exists to be loaded
eval(Meta.parse("using $(pkg)"))
# Get the Module object for that package
m = eval(Meta.parse(pkg))
# Get the directory where the module is stored
dir = Pkg.pkgdir(m)
# Identify the actual file to run
scriptfile = joinpath(dir, "scripts", "$(script).jl")

# Point Julia to the environment associated with the package
println("Setting environment to: $(dir)")
ENV["JULIA_PROJECT"] = dir

newargs = ARGS[2:length(ARGS)]

cmd::Vector{String} = []

push!(cmd, joinpath(Sys.BINDIR, Base.julia_exename()))
push!(cmd, "--project=$(dir)")
push!(cmd, scriptfile)
for a in newargs
    # push!(cmd, "\"$(a)\"")
    push!(cmd, a)
end

cmdstr = join(cmd, " ")
println("cmdstr = $(cmdstr)")
run(pipeline(Cmd(cmd)))
# empty!(ARGS)
# for a in newargs
#     push!(ARGS, a)
# end

# run(Cmd(`pwd`, dir="/"))
# # "Run" the script
# include(scriptfile)

