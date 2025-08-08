#include <unistd.h>
#include <stdio.h>
#include <string.h>

// gcc -o /tmp/ctest /tmp/ctest.c -Wall -lcrypt && /tmp/ctest

int main()
{
	int i;
	char start = '!';
	char *salt = "sa";
	//char *salt = "$1$sa";
	//char *salt = "$5$sa";
	//char *salt = "$6$sa";
	char buf[95] = {0};
	char last[64] = {0};

	//trükib ekraanile parooli räsi, mis arvutatakse parooli "1234" ja soola "sa" põhjal. 
	//teie ülesanne on suurendada parooli pikkust seni kuni parooli räsi enam ei muutu.
	//printf("%s\n", crypt("1234", "sa"));
	//printf("%s\n", crypt("12345", "sa"));

	for (i = start; i - start < sizeof(buf) - 1; i++)
	{
		buf[i - start] = i;
		const char *hash = crypt(buf, salt);

		printf("%s => %s (%u)\n", hash, buf, strlen(buf));

		if (strcmp(hash, last) == 0)
		{
			printf("Found!\n");
			break;
		}			

		strncpy(last, hash, sizeof(last));
		last[sizeof(last) - 1] = '\0';
	}

	if (i - start == sizeof(buf) -1)
		printf("Not found!\n");

	return 0;
}
