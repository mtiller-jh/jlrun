using Comonicon
using Pkg

@main function jlrun(pkg::String)
    println("Package: $(pkg)")
    # Run using to get Module loaded
    eval(Meta.parse("using $(pkg)"))
    m = eval(Meta.parse(pkg))
    dir = Pkg.pkgdir(m)
    println("Package directory: $(dir)")
end
