#include <stdio.h>

int a[20000],b[20000];
int main()
{
  int i;
  int temp;
  int sum = 0;
  int sum1 = 0;
  int sum2 = 0;
  for(i=0;i<200;i++){
    a[i] = i;
  }

  printf("Initialization complete\n");

  for(i=0;i<50000;i++){
  }

  for(i=0;i<200;){
    temp = a[i];
    i++;
    sum = sum + 3;
    sum1 = sum1 + temp;
    sum2 = sum2 + temp;
  }

  b[0] = sum;
  b[1] = sum1;
  b[3] = sum2;

  printf("Array sum complete\n");
  printf("Results Sum1: %d Sum2: %d\n",sum1,sum2);

  return 1;
}
