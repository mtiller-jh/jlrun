#!/usr/bin/env julia

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

# Identify and locate package
pkg = Base.identify_package(String(pkg))
if pkg == nothing
    println("package $pkg not found in environment")
    exit(2)
end
loc = Base.locate_package(pkg)
if loc == nothing
    println("package $pkg not downloaded")
    exit(2)
end

# Get the directory where the module is stored
dir = joinpath(dirname(loc), "..")
# Identify the actual file to run
scriptfile = joinpath(dir, "scripts", "$(script).jl")

exe = joinpath(Sys.BINDIR, Base.julia_exename())
cmd = `$(exe) --project=$(dir) $(scriptfile) $(ARGS[2:end])`
# println("Command: $(cmd)")
run(cmd)