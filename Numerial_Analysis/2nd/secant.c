#include <stdio.h>

int main(void){
    long double x[100] = {0,};
    long double e = 0.001;
    int i = 1;
    x[0] = 1.0;
    x[1] = 1.7;

    while(x[i] - x[i-1] > 0 && x[i] - x[i-1] > e || x[i] - x[i-1] < 0 && x[i] - x[i-1] < -e){
        long double fxi = x[i] * x[i] * x[i] + x[i] * x[i] - 3 * x[i] - 3;
        long double fxi1 = x[i-1] * x[i-1] * x[i-1] + x[i-1] * x[i-1] - 3 * x[i-1] - 3;
        x[i+1] = x[i] - ((x[i] - x[i-1]) * fxi /(fxi - fxi1));
        printf("%.9Lf\n",x[i+1]);
        i++;
    }
}