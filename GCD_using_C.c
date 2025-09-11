#include <stdio.h>

int gcd(int a, int b) {
    while (b != 0) {
        int temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

int main() {
    int A, B, Y, Y_Ref;
    int Passed = 1;
    FILE *file_pointer = fopen("gcd_test_data.txt", "r");

    if (file_pointer == NULL) {
        printf("Error: could not open test data file\n");
        return 1;
    }

    while (fscanf(file_pointer, "%d %d %d", &A, &B, &Y_Ref) == 3) {
        Y = gcd(A, B);
        if (Y != Y_Ref) {
            printf("Error. A=%d B=%d Y=%d Y_Ref=%d\n", A, B, Y, Y_Ref);
            Passed = 0;
        }
    }

    if (Passed) {
        printf("GCD algorithm test passed ok\n");
    }

    fclose(file_pointer);
    return 0;
}
