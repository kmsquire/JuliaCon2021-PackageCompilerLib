// julia_init.c
//
// This file is part of PackageCompiler.jl, and is compiled into
// into the sysimage when creating a shared library bundle.

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

#include <libgen.h>

// Julia header files
#include "uv.h"
#include "julia.h"


void setup_args(int argc, char **argv)
{
    uv_setup_args(argc, argv);
    libsupport_init();
    jl_parse_opts(&argc, &argv);
}

const char *get_sysimage_path(const char *libname)
{
    if (libname == NULL)
    {
        jl_error("Please specify `libname` when requesting the sysimage path");
        exit(1);
    }

    void *handle;
    const char *libpath;

    handle = jl_load_dynamic_library(libname, JL_RTLD_DEFAULT, 0);
    libpath = jl_pathname_for_handle(handle);

    return libpath;
}

void set_depot_path(char *sysimage_path)
{
    // dirname mutates the original string on some systems,
    // so make a copy
    char *root_dir = dirname(dirname(sysimage_path));
    int root_dir_len = strlen(root_dir);

    // for library bundles, we create the depot path under
    // <root_dir>/share/julia
    char *depot_subdir = "/share/julia";
    int depot_dir_len = strlen(depot_subdir);

    int full_path_len = root_dir_len + depot_dir_len;
    char *dir = malloc(full_path_len + 1);

    strncpy(dir, root_dir, root_dir_len);
    strncpy(dir + root_dir_len, depot_subdir, depot_dir_len);
    dir[full_path_len] = '\0';

    setenv("JULIA_DEPOT_PATH", dir, 1);
    setenv("JULIA_LOAD_PATH", "@", 1);

    free(dir);
}

void init_julia(int argc, char **argv)
{
    setup_args(argc, argv);

    const char *sysimage_path;
    sysimage_path = get_sysimage_path(JULIAC_PROGRAM_LIBNAME);

    set_depot_path((char *)sysimage_path);

    jl_options.image_file = sysimage_path;
    julia_init(JL_IMAGE_CWD);
}

void shutdown_julia(int retcode)
{
    jl_atexit_hook(retcode);
}
