# Makefile

MYLIB_INCLUDES = target/include/julia_init.h target/include/mylib.h
MYLIB_PATH := target/lib/libmylib.so

$(MYLIB_PATH) $(MYLIB_INCLUDES): build/build.jl src/MyLib.jl
	julia --startup-file=no --project=. -e 'using Pkg; Pkg.instantiate()'
	# Remove the following line when `create_library()` is merged upstream
	julia --startup-file=no --project=build -e 'import Pkg; Pkg.add(url="https://github.com/kmsquire/PackageCompiler.jl.git", rev="kms/create_library")'
	julia --startup-file=no --project=build -e 'using Pkg; Pkg.instantiate()'
	julia --startup-file=no --project=build build/build.jl

.PHONY: clean
clean:
	$(RM) *~ *.o *.so
	$(RM) -Rf target
