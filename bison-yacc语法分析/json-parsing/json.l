%{
#include "json.tab.h"
#include "json.h"
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
extern "C" { int yylex(void); }
%}

digit [0-9]
integer [-+]?{DIGIT}+
double [-+]?{DIGIT}+[.]{DIGIT}+
string [\"]([^"])*[\"]
boolean false|true|FALSE|TRUE|False|True
null null|NULL|Null

%%

"{" {
    fprintf(yyout, "--- BEGIN_OBJECT \"{\"---\n");
    return BEGIN_OBJECT;
}
"}" {
    fprintf(yyout, "--- END_OBJECT \"}\"---\n");
    return END_OBJECT;
}
"[" {
    fprintf(yyout, "--- BEGIN_ARRAY \"[\"---\n");
    return BEGIN_ARRAY;
}
"]" {
    fprintf(yyout, "--- END_ARRAY \"[\"---\n");
    return END_ARRAY;
}
"," {
    fprintf(yyout, "--- SEP_COMMA \",\"---\n");
    return SEP_COMMA;
}
";" {
    fprintf(yyout, "--- SEP_COLON \";\"---\n");
    return SEP_COLON;
}
integer {
    int num = atoi (yytext);
    yylval.num_bool = num; // for value->INT
    fprintf(yyout, "--- INT \"%d\"---\n", num);
    return INT;
}
double {
    double num = atof (yytext);
    yylval.db = num; // for value->INT
    fprintf(yyout, "--- DOUBLE \"%lf\"---\n", num);
    return FLOAT;
}
string {
    yylval.str = copyString (yytext); // for value->STRING
    fprintf (yyout, "--- STRING \"%s\"---\n", yytext);
    return STRING;
}
boolean {
    int isTrue = cmpStrIgnoreCase(yytext, "true");
    yylval.num_bool = isTrue;
    fprintf (yyout, "--- BOOLEAN \"%s\"---\n", yytext);
    return BOOLEAN;
}
null {
    fprintf (yyout, "--- NULL --------\n");    
    return NULL;
}

%%














