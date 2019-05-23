%{
#include <stdio.h>
%}

%token DIGIT STOP LP RP PLUS MINUS MUL DIV

%%
start: expr STOP {
     printf("expr = %d\n", $1);
    exit(1);
    }
;
expr: term {$$ = $1;}
    | term PLUS term {
        $$ = $1 + $3;
        printf("%d + %d = %d, PLUS = %d\n", $1, $3, $$, PLUS);
    }
    | term MINUS term {$$ = $1 - $3;}
;
term: factor {$$ = $1;}
    | factor MUL factor {
        $$ = $1 * $3;
        printf("%d * %d = %d\n", $1, $3, $$);
    }
    | factor DIV factor {$$ = $1 / $3;}
;
factor: LP expr RP {$$ = $2;}
      | DIGIT {$$ = $1;}
;
%%

main(){
    printf("Type something followed by Return. Type 'q' to end.\n");
    printf("\n");
    return(yyparse());          /* Start the parser */
}

yyerror(s)
char *s; {
    printf("yacc error: %s\n", s);
}

yywrap(){
    return(0);
}



