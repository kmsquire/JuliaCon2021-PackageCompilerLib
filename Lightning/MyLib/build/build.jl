# build/build.jl

using PackageCompiler

target_dir = "./target"

PackageCompiler.create_library(
    ".", target_dir;
    lib_name="mylib",
    incremental=false,
    filter_stdlibs=true,
    header_files=["$(@__DIR__)/mylib.h"],
)
