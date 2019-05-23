%{
#include "expr.tab.h"
%}

%%
"q"   return STOP;
"("   return LP;
")"   return RP;
"\+"  return PLUS;
"\-"  return MINUS; 
"\*"  return MUL; 
"\/"  return DIV;

[0-9]+ {yylval=atoi(yytext); return DIGIT;} 
%%


