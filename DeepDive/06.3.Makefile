# Makefile

# variable setup
	JULIA ?= julia
	JULIA_DIR := $(shell $(JULIA) --startup-file=no -e 'print(dirname(Sys.BINDIR))')
	DLEXT := $(shell $(JULIA) --startup-file=no -e 'using Libdl; print(Libdl.dlext)')

	PREFIX ?= $(ROOT_DIR)/../target
	BINDIR := $(PREFIX)/bin
	INCLUDE_DIR = $(PREFIX)/include
	LIBDIR := $(PREFIX)/lib
	MAIN := main-c
	LIBCG := libcg.$(DLEXT)

	LIBCG_INCLUDES = $(INCLUDE_DIR)/julia_init.h $(INCLUDE_DIR)/cg.h
	LIBCG_PATH := $(LIBDIR)/$(LIBCG)

	.DEFAULT_GOAL := main-c

PHONY: install clean
OS := $(shell uname)

WLARGS := -Wl,-rpath,"$(LIBDIR)" -Wl,-rpath,"$(LIBDIR)/julia"
ifneq ($(OS), Windows)
	ifeq ($(OS), DARWIN)
		WLARGS += -Wl,-rpath,@executable_path/../lib
		WLARGS += -Wl,-rpath,@executable_path/../lib/julia
	else
		WLARGS += -Wl,-rpath,$$ORIGIN/../lib
		WLARGS += -Wl,-rpath,$$ORIGIN/../lib/julia
	endif
endif

CFLAGS+=-O2 -fPIE -I$(JULIA_DIR)/include/julia -I$(INCLUDE_DIR)
LDFLAGS+=-lm -L$(LIBDIR) -ljulia $(WLARGS)

main.o: main.c $(LIBCG_INCLUDES)
	$(CC) $< -c -o $@ $(CFLAGS)

main-c: main.o
	mkdir -p $(BINDIR) 2>&1 > /dev/null
	$(CC) -o $@ $< $(LDFLAGS) -lcg

install: main-c
	cp main-c $(PREFIX)/bin

clean:
	$(RM) *~ *.o *.$(DLEXT) main-c
