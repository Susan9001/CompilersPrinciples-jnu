#include <stdio.h>
#include <stdlib.h>
#include <sys/unistd.h>
#define TRUE 1
#define FALSE 0

static char PUNCTUATIONS[] = "=<>,;+-*/";

int isValidPunc(char ch);

int main() {
    printf("total count: %d\n", (int)sizeof (PUNCTUATIONS)/sizeof (char));
    return 0;
}

int isValidPunc(char ch) {
    int i;
    for (i = 0; i < sizeof(PUNCTUATIONS) / sizeof(char); i++) {
        if (ch == PUNCTUATIONS[i]) 
            return TRUE;
    }    
    return FALSE;
}


