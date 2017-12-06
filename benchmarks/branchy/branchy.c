#include <stdio.h>


int main(void) 
{

	int i,a,b = 0;
	for (i = 0; i<1000; i++)
	{
		if (i % 9 == 0) a++;
		else b++;
	}


	return 0; 
}
