/****************************************************/
/* File: scan.h                                     */
/* The scanner interface for the TINY compiler      */
/****************************************************/

#ifndef _SCAN_H_
#define _SCAN_H_

/* MAXTOKENLEN is the maximum size of a token */
#define MAXTOKENLEN 40

/* tokenString array stores the lexeme of each token */
extern char tokenString[MAXTOKENLEN+1];

/* function getToken returns the 
 * next token in source file
 */
TokenType getToken(void);
/* the valid punctuations */
static char PUNCTUATIONS[] = "=<>,;+-*/";
int isValidPunc(char ch);
int isLetter(char ch);
int isBlank(char ch);

#endif


