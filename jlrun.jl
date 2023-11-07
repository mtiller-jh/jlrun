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
if length(ARGS)!=2 && length(ARGS)!=1
    println("jlrun <package> [<script>]")
    exit(1)
end

# Extract values from arguments
pkg = ARGS[1]
script = length(ARGS)==2 ? ARGS[2] : "run"

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

# "Run" the script
include(scriptfile)

