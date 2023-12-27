# Explanation

In other language eco-systems like Go or Node, the package management tools also
provide a means for installing and running a program (and not just downloading a
dependecy).  I couldn't really find something like that for the Julia world so I
wrote this script.

The basic idea is simple.  If you want to run script `foo` inside package `Bar`,
you would invoke that with:

```shell
$ jlrun Bar/foo <arguments passed to **foo**>
```

This will look for a file called `./scripts/foo.jl` in the `Bar` package.  If
you leave the script name off, the default script name is `run` (_e.g.,_ `./scripts/run.jl`).

**NB**: There is a larger effort, associated with the `julia` executable itself, to
enable very similar functionality as described [in this pull
rquest](https://github.com/JuliaLang/julia/pull/52103).  If this were to be
merged, much of this would be unnecessary.

## Installation

Typically this script is installed as either `jlrun.jl` or `jlrun`.  It should
be given the executable permission and placed somewhere in your `PATH.`  Note,
this script only needs to be installed in your path.  It can be named whatever
you want although `jlrun.jl` or just `jlrun` are what I tested it with.

## Usage

As mentioned previous, the script usage is as follows:

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

This will run the `./scripts/run.jl` script found in the `Runlit` package and
using the command line arguments `--size 10`.

```
$ jlrun Runlit/alt
```

This will run the `scripts/alt.jl` script found in the `Runlit` package but
without any command line arguments.

**NB**: The [`Runlit` package](https://github.com/mtiller-jh/Runlit), which
provides a CLI based way of running [Literate.jl](https://github.com/fredrikekre/Literate.jl), is designed
to work with `jlrun`.