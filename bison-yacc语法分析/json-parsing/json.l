%{
#include "json.h"
#include "json.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
%}

digit [0-9]
integer [-+]?{digit}+
double [-+]?{digit}+[.]{digit}+
string [\"](\\\"|[^"])*[\"]
boolean false|true|FALSE|TRUE|False|True
null null|NULL|Null
space [ \t\n\r]+

%%

"{" {
    fprintf(yyout, "\tBEGIN_OBJECT \"{\"\n");
    return BEGIN_OBJECT;
}
"}" {
    fprintf(yyout, "	END_OBJECT \"}\"\n");
    return END_OBJECT;
}
"[" {
    fprintf(yyout, "	BEGIN_ARRAY \"[\"\n");
    return BEGIN_ARRAY;
}
"]" {
    fprintf(yyout, "	END_ARRAY \"[\"\n");
    return END_ARRAY;
}
"," {
    fprintf(yyout, "	SEP_COMMA \",\"\n");
    return SEP_COMMA;
}
":" {
    fprintf(yyout, "	SEP_COLON \":\"\n");
    return SEP_COLON;
}
{integer} {
    int num = atoi(yytext);
    yylval.num_bool = num; // for value->int
    fprintf(yyout, "	INT \"%d\"\n", num);
    return INT;
}
{double} {
    double num = atof (yytext);
    yylval.db = num; // for value->int
    fprintf(yyout, "	FLOAT \"%lf\"\n", num);
    return FLOAT;
}
{string} {
    yylval.str = copyString (yytext); // for value->string
    fprintf (yyout, "	STRING \"%s\"\n", yylval.str);
    return STRING;
}
{boolean} {
    int istrue = cmpStrIgnoreCase(yytext, "true"); // in json.h/c
    yylval.num_bool = istrue;
    fprintf (yyout, "	BOOLEAN \"%s\"\n", yytext);
    return BOOLEAN;
}
{null} {
    fprintf (yyout, "	NULL \n");    
    return NULL_T;
}
{space}  { /*do nothing...*/ }
"//".* {/* 单行注释 */}
"/*"."*/" {/* 只有一行不到的情况*/ }
"/*" {
    char ch ;
    int done=0;
    do {
        while((ch=input())!='*' && ch != '\0');
        while((ch=input())=='*' && ch != '\0');
        if(ch=='/') done=1;
    }while(!done);
} 
. { // for error
    fprintf (yyout, "--- 我是谁 \"%s\"---\n", yytext);
    return SCAN_ERR;
}

%%














