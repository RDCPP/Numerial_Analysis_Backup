#include <stdio.h>

int main(void){
    long double low = 1.0;
    long double high = 2.0;
    long double mid = (low + high)/2;
    long double x[100] = {0, };
    long double e = 0.0001;
    int i = 0;
    while(i < 15){
        long double formal_mid = mid;
        mid = (low + high)/2;
        x[i] = mid * mid * mid + 4 * mid * mid - 10;
        printf("%d case - (low)%.9Lf / (high)%.9Lf / (mid)%.9Lf : (res)%.9Lf\n",i+1,low,high,mid,x[i]);
        if(x[i] < 0){
            low = mid;
        }
        else{
            high = mid;
        }
        printf("(high)%.9Lf - (low)%.9Lf =  %.9Lf\n",high,low,high-low);
        printf("(mid) %.9Lf // (high+low/2) %.9Lf\n",mid,(high+low)/2);
        i++;
    }
}