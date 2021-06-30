# Creating a Shared Library Bundle with Package Compiler


## Abstract

[`PackageCompiler.jl`](https://julialang.github.io/PackageCompiler.jl/dev/) has become the de facto method for creating standalone Julia applications. In this talk, we will demonstrate the use of `PackageCompiler.jl` to produce shared library bundles.  This functionality was added recently and allows the easy creation of location-independent dynamic libraries which can be linked to and called from C, C++, Rust, or other languages which can link to and use C libraries.


## Description

Julia has been touted as a great solution to the two-language problem (and it is).  But for many, interacting with code in other languages is a necessity.

Numerous packages exist which aid interoperability with other languages, including C ([`Clang.jl`](https://juliainterop.github.io/Clang.jl/stable/)), C++ ([`CxxWrap.jl`](https://github.com/JuliaInterop/CxxWrap.jl)), Java ([`JavaCall.jl`](https://juliainterop.github.io/JavaCall.jl/)), Matlab ([`Matlab.jl`](https://github.com/JuliaInterop/MATLAB.jl) / [`Mex.jl`](https://github.com/byuflowlab/Mex.jl)), Python ([`PyCall.jl`](https://github.com/JuliaPy/PyCall.jl) / [`pyjulia`](https://pyjulia.readthedocs.io/en/stable/)), R ([`RCall.jl`](https://juliainterop.github.io/RCall.jl/stable/) / [`JuliaCall`](https://cran.r-project.org/web/packages/JuliaCall/readme/README.html)), Mathematica ([`MathLink.jl`](https://github.com/JuliaInterop/MathLink.jl)), and rust ([`jlrs`](https://docs.rs/jlrs/0.9.0/jlrs/)). 

Many of these packages focus on calling out to code in other languages from Julia, but there is also support for calling Julia code from other languages, especially for those that have the ability to call C functions, and that is what we will focus on here.

The Julia manual has a [full section on Embedding Julia](https://docs.julialang.org/en/v1/manual/embedding/).  Until now, this has been the standard way to embed and call Julia from other languages.  Using the ideas here, along with custom Julia sysimage generation with [`PackageCompiler.jl`](https://julialang.github.io/PackageCompiler.jl/dev/), one of us created a proof-of-concept repository for creating a shared library from Julia code for C or other languages (https://github.com/simonbyrne/libcg).

One downside of this work is that the library was not easy to relocate--it contained hard-coded paths to the Julia runtime.  We wanted the ability to create a relocatable shared library.

`PackageCompiler.jl` already allowed the creation of “apps”--bundles of files, including an executable--which could be relocated and moved to other machines (with some minor caveats).  We extended this functionality to create relocatable shared libraries with a `create_library` function.

The actual act of creating a shared library with `PackageCompiler.jl` is very much like creating an “app”, and has a very similar output--a bundle of directories which include the shared library and enough of the Julia runtime to run.  This bundle can be zipped or tarred up, sent to other computers, and installed in any location that a linker can find it.  The user has the option of setting the library version (on Mac and Linux), and can include C header files for the Julia functions she has exported in the shared library.

For this talk, we will give a brief overview of the `create_library` functionality, discuss situations in which it might be used, show how to use it, and discuss its limitations.

## Notes
This talk will focus on using `PackageCompiler.jl` to create a shared library bundle. We are also proposing to give a full 30 minute talk on this functionality, which will go into technical implementation details and more detailed usage examples.
