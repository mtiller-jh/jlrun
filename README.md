# Explanation

## Installation

Typically this script is installed as either `jlrun.jl` or `jlrun`.  It should
be given the executable permission and placed somewhere in your `PATH.`  Note,
this script only needs to be installed in your path.  It can be named whatever
you want although `jlrun.jl` or just `jlrun` are what I tested it with.
## Usage

The script usage is as follows:

```
$ jlrun <package>[/<script>] ...
```

...where `<package>` name is a Julia package installed in the current
environment and `<script>` is an optional script name to run (by default, the
`run` script is used if no script is specified).  The `...` represents any
additional command line arguments which will be passed to the underlying script.

## Function

When invoked, `jlrun` find the location of the specified `<package>` in the
current environment.  It then looks for a `scripts` directory in that package
and expects to find a file named `<script>.jl` in that directory.  It then runs
that scripts and appends the additional command line arguments (_e.g.,_ `...`).

Note that the script itself is run **under the environment of that package**.
This means it should have access to all dependencies specified by that package
(and _only_ those dependencies).

## Example

```
$ jlrun Runlit --size 10
```

This will run the `scripts/run.jl` script found in the `Runlit` package and
using the command line arguments `--size 10`.

```
$ jlrun Runlit/alt
```

This will run the `scripts/alt.jl` script found in the `Runlit` package but
without any command line arguments.