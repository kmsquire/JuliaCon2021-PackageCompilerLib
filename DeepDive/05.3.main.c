// main.c

#include <stdio.h>
#include <julia_init.h>
#include <mylib.h>

int main(int argc, char **argv) {
    init_julia(argc, argv);

    int i = 41;
    long j = 987654320;

    printf("C: i = %d\n", i);
    printf("C: j = %ld\n", j);

    printf("C: incrementing i, j\n");
    i = increment32(i);
    j = increment64(j);

    printf("C: i = %d\n", i);
    printf("C: j = %ld\n", j);

    shutdown_julia(0);
    return 0;
}
