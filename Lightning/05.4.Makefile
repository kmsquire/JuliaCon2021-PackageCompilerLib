LIB_DIR := ../MyLib/target/lib
INCLUDE_DIR := ../MyLib/target/include

WLARGS := -Wl,-rpath,"$(LIB_DIR)" -Wl,-rpath,"$(LIB_DIR)/julia"

CFLAGS+=-O2 -fPIE -I$(INCLUDE_DIR)
LDFLAGS+=-lm -L$(LIB_DIR) -ljulia $(WLARGS)

main: main.o
	$(CC) -o $@ $< $(LDFLAGS) -lmylib

main.o: main.c
	$(CC) $< -c -o $@ $(CFLAGS)

.PHONY: clean
clean:
	$(RM) *~ *.o main
