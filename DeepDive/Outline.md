## Deep Dive: Talk outline

1. Motivation
    - Why we did this, and why you might (not) want to
    - Typical use cases
    - Limitations/Drawbacks
    - Alternatives
2. Anatomy of a Julia Installation
    - Directory structure / installed libraries
    - PackageCompiler.jl
3. Creating a shared library
    - Plan: what do we want the end product to look like
    - Details:
        1. Using PackageCompiler to create this structure
        2. Packaging it up
        3. Installing it
        4. Linking against and calling the installed library
4. Example: libcg in C
5. Example: libcg in Rust
6. Conclusions
