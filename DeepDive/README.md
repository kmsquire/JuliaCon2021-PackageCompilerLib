# Deep Dive: Creating Shared Libraries with PackageCompiler.jl

## Abstract
The ability to create shared library bundles was recently added to `PackageCompiler.jl`.  In this talk, we will discuss the technical details of the implementation and give in-depth examples of using the resulting shared library bundles from C and Rust.

## Description
We recently added to `PackageCompiler.jl` functionality for creating shared library bundles, consisting of a "main" dynamic library (`.so`, `.dylib`, or `.dll`) created from Julia code, as well as any required Julia runtime libraries.  The purpose of the library bundle is to allow developers to write Julia code that can be distributed to developers using other languages without the need for Julia to be installed.

This work extends the existing `PackageCompiler.jl` functionality to create self-contained, distributable and relocatable "apps".  In this talk, we will go into the details of the implementation, as well as give in-depth examples of using the resulting shared library from C and rust.

## Notes
This talk is intended to be high in technical details.  We also have a proposal for a higher level "what/why/how" lightning talk.
