%{
   #include "stdio.h"
   #include "stdlib.h"
   int num_count=0,id_count=0;
%}
INTEGER [-+]?[1-9][0-9]*
ID [a-zA-Z][a-zA-Z_0-9]*
SPACE [ \n\t]
%%

{INTEGER} { 
    num_count++;
    printf("(num=%d)\n",atoi(yytext));/*打印数字值*/
    /*数字数加一*/
}

{ID} { id_count++;
    printf("(id=%s)\n",yytext);
    }

{SPACE} |
. {
   /*什么也不做,滤掉白字符和其它字符*/
   }
%%

int main()
{
   yylex();
   printf("num=%d,id=%d\n",num_count,id_count);
   return 0;
}

int yywrap()//此函数必须由用户提供
{
    return 1;
}
