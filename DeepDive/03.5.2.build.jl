import PackageCompiler, TOML

const build_dir = @__DIR__
const target_dir = "target"
const project_toml = realpath(joinpath(build_dir, "..", "Project.toml"))
const version = VersionNumber(TOML.parsefile(project_toml)["version"])

const compatibility = "major"

PackageCompiler.create_library(".", target_dir;
                            lib_name="cg",
                            precompile_execution_file=[joinpath(build_dir, "generate_precompile.jl")],
                            precompile_statements_file=[joinpath(build_dir, "additional_precompile.jl")],
                            incremental=false,
                            filter_stdlibs=true,
                            header_files = [joinpath(build_dir, "cg.h")],
                            force=true,
                            version=version,
                            compat_level=compatibility,
                        )
