#include <stdio.h>
#include <zlib.h>

int main()
{
	gzFile file;
	file = gzopen("/tmp/test.gz", "w");
	gzwrite(file, "hello\0", 6);
	gzclose(file);

	char text[6];
	file = gzopen("/tmp/test.gz", "r");
	gzread(file, text, 6);
	printf("file contains: %s\n", text);

	return 0;
}
