#include <stdlib.h>
#include <math.h>
#include "armstrong_numbers.h"

static int calc_armstrong_val(int n)
{
	if (n == 0) return 0;

	n = abs(n);

	int len = log10(n) + 1;
	int sum = 0;

	while (n != 0)
	{
		sum += pow(n % 10, len);
		n /= 10;
	}

	return sum;
}


bool is_armstrong_number(int n)
{
	return n == calc_armstrong_val(n);
}
