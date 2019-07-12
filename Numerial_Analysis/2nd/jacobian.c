#include <stdio.h>

int main(void){
    long double x = 2.337654321;
    long double y = 2.200308642;

    long double fx;
    long double fy;

    fx = x * x + 4 * y * y - 16;
    fy = x * y * y - 4;

    printf("%.9Lf\n%.9Lf\n",fx,fy);

    long double j[2][2];
    j[0][0] = 2 * x;
    j[0][1] = 8 * y;
    j[1][0] = y * y;
    j[1][1] = 2 * x * y;

    printf("%.9Lf\t%.9Lf\n%.9Lf\t%.9Lf\n",j[0][0],j[0][1],j[1][0],j[1][1]);

    long double ji[2][2];
    long double ad_bc = j[0][0] * j[1][1] - j[0][1] * j[1][0];
    printf("%.9Lf\n",ad_bc);

    ji[0][0] = j[1][1]/ad_bc;
    ji[1][1] = j[0][0]/ad_bc;
    ji[0][1] = -j[0][1]/ad_bc;
    ji[1][0] = -j[1][0]/ad_bc;

    printf("%.9Lf\t%.9Lf\n%.9Lf\t%.9Lf\n",ji[0][0],ji[0][1],ji[1][0],ji[1][1]);

    long double rx;
    long double ry;

    rx = x - (fx * ji[0][0] + fy * ji[0][1]);
    ry = y - (fx * ji[1][0] + fy * ji[1][1]);

    printf("%.9Lf\n%.9Lf\n",rx,ry);
}