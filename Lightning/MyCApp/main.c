#include <stdio.h>
#include <mylib.h>
#include <julia_init.h>

int main(int argc, char **argv) {
    init_julia(argc, argv);

    float i = 41.0;
    double j = 987654320.0;

    printf("C: i = %0.0f\n", i);
    printf("C: j = %0.0f\n", j);

    printf("C: incrementing i, j\n");
    i = increment32(i);
    j = increment64(j);

    printf("C: i = %0.0f\n", i);
    printf("C: j = %0.0f\n", j);

    shutdown_julia(0);
    return 0;
}
