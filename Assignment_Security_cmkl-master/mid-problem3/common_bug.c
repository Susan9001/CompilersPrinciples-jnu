#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void pbaweja() {
  printf("pbaweja() is called.\n");
  exit(0);
}

void pli() {
  printf("pli() is called.\n");
  exit(0);
}

void xli() {
  printf("xli() is called.\n");
  exit(0);
}

void yqi() {
  printf("yqi() is called.\n");
  exit(0);
}

void ytian() {
  printf("ytian() is called.\n");
  exit(0);
}

void output_mem(char *mem) {
  char unused_buffer[160]; /* empty space to avoid damaging the stack */
  printf("Content of mem is: %s (", mem);
  for (int i = 0; i < strlen(mem); i = i + 1) {
    printf("%02hhx ", mem[i]);
  }
  printf(")\n");
}

/* dangerously allocate 40 bytes of stack memory for future use */
void buggy_alloc(char** mem) {
  char local_buffer[40];
  *mem = local_buffer;
}

void beta(char* mem) {
  char unused_buffer[160]; /* empty space to avoid damaging the stack */
  fgets(mem, 40, stdin);
}

void alpha(char* mem) {
  beta(mem);
}

int main() {
  char* mem;

  buggy_alloc(&mem);
  alpha(mem);
  output_mem(mem);

  return 0;
}
