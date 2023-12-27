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
packageName = parts[1]
scriptName = get(parts, 2, "run")

# Identify and locate package
packageName = Base.identify_package(String(packageName))
if packageName == nothing
    println("package $packageName not found in environment")
    exit(2)
end
pathToPackage = Base.locate_package(packageName)
if pathToPackage == nothing
    println("package $packageName not downloaded")
    exit(2)
end

# Get the directory where the module is stored
dir = joinpath(dirname(pathToPackage), "..")

# Identify the actual file to run
scriptfile = joinpath(dir, "scripts", "$(scriptName).jl")

# Determine the Julia exe to use
exe = joinpath(Sys.BINDIR, Base.julia_exename())

# Specify the project directory as the one where the script resides before
# running the script and passing arguments to it.
cmd = `$(exe) --project=$(dir) $(scriptfile) $(ARGS[2:end])`

# Invoke the script
run(cmd)