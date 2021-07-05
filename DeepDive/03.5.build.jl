import PackageCompiler, TOML

const build_dir = @__DIR__
const target_dir = "target"

PackageCompiler.create_library(".", target_dir;
                            lib_name="cg",
                            incremental=false,
                            filter_stdlibs=true,
                            header_files = [joinpath(build_dir, "cg.h")],
                            force=true,
                        )
