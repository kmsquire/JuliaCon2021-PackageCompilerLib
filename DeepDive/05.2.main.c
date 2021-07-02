// main.c

#include <stdio.h>
#include <julia_init.h>
#include <mylib.h>

int main(int argc, char **argv) {
    init_julia(argc, argv);

    int i = 41;


    printf("C: i = %d\n", i);


    printf("C: incrementing i\n");
    i = increment32(i);


    printf("C: i = %d\n", i);


    shutdown_julia(0);
    return 0;
}
