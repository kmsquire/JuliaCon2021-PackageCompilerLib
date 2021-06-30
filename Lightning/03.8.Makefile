# Makefile

MYLIB_INCLUDES = target/include/julia_init.h target/include/mylib.h
MYLIB_PATH := target/lib/libmylib.so

$(MYLIB_PATH) $(MYLIB_INCLUDES): build/build.jl src/MyLib.jl
	julia --startup-file=no --project=. -e 'using Pkg; Pkg.instantiate()'
	julia --startup-file=no --project=build -e 'using Pkg; Pkg.instantiate()'
	julia --startup-file=no --project=build build/build.jl

.PHONY: clean
clean:
	$(RM) *~ *.o *.so
	$(RM) -Rf target
