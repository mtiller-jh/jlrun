# Explanation

This script takes one or two arguments.  The first argument is the name of a
package (currently assumes this exists in the default environment only but if
you set JULIA_PROJECT, it might honor that).  If only one argument is provided,
then this script looks for a file called ./scripts/run.jl in that package's
directory structure and runs that **under the environment of that package**
(i.e., using its Project.toml file).  If a second argument is provided, _e.g..,_
`foo`, then this script looks for a script by that name, _e.g.,_
`scripts/foo.jl`, instead of the default `scripts/run.jl`.

Note, this script only needs to be installed in your path.  It can be named
whatever you want although `jlrun.jl` or just `jlrun` are what I tested it with.