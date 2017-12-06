#include <stdio.h>

unsigned int fibonacci (unsigned int n)
{
	asm("nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop;nop");
	if (n==1)
	{
		//printf("Fibonacci number %u is %u\n", n , 1u);
		return 1u;
	}
	else if (n==2)
	{
		//printf("Fibonacci number %u is %u\n", n , 1u);
                return 1u;
	}
	else
	{
		unsigned int fib = fibonacci(n-1) + fibonacci(n-2);
		//printf("Fibonacci number %u is %u\n", n , fib);
                return fib;
	}

}


int main(void) 
{
	fibonacci (17);
	return 0; 
}
