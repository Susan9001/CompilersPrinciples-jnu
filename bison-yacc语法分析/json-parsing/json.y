%{
#include <stdio.h>
#include <stdlib.h>
#include "json.h"

void yyerror(const char*s);
TreeNode *root; // 从start开始...
%}

%union {
    // 以下一个针对非终结符
    TreeNode* pNode;
    // 以下三个是针对终结符的
    char* str;
    int num_bool;
    double db;
}

%token BEGIN_OBJECT	 END_OBJECT	
%token BEGIN_ARRAY	END_ARRAY	
%token INT  FLOAT   STRING  BOOLEAN NULL_T
%token SEP_COLON    SEP_COMMA	
%token SCAN_ERR

%type<num_bool> INT  BOOLEAN
%type<db> FLOAT 
%type<str> STRING

%type<pNode> start
%type<pNode> array elements
%type<pNode> object members pair
%type<pNode> value

%%

start: object 
     | array {
        printf ("start->obj\n");
        $$ = newTreeNode (vnStart);
        $$->child[0] = $1;
        root = $$;
     }  
;
object: BEGIN_OBJECT END_OBJECT {
        $$ = newTreeNode (vnObj);
      }
      | BEGIN_OBJECT members END_OBJECT {
        printf ("obj->members\n");
        $$ = newTreeNode (vnObj);
        $$->child[0] = $2; 
      }
;
members: pair {
        printf ("members->pair\n");
        $$ = newTreeNode (vnPair);
        $$->child[0] = $1;
       }
       | members SEP_COMMA pair {
        printf ("members->members , pair\n");
        $$ = newTreeNode (vnPair);
        $$->child[0] = $1;
        $$->child[1] = $3;
       }
;
array: BEGIN_ARRAY END_ARRAY {
        printf ("array ->[ ]\n");
        $$ = newTreeNode (vnArr);
     }
     | BEGIN_ARRAY elements END_ARRAY {
        printf ("array ->[ elements ]\n");
        $$ = newTreeNode (vnArr);
        $$->child[0] = $2;
     }
;
elements: value {
            printf ("elements -> value\n");
            $$ = newTreeNode (vnElem);
            $$->child[0] = $1;
        }
        | elements SEP_COMMA value {
            printf ("elements -> value , elements\n");
            $$ = newTreeNode (vnElem);
            $$->child[0] = $1;
            $$->sibling = $3;
        }
;
pair: STRING SEP_COLON value {
        printf ("pair -> STRING : value\n");
        $$ = newTreeNode (vnPair);     
        $$->attr.str = copyString((char*)$1);
        $$->child[0] = $3;
    } 
;
value: INT {
        printf ("value -> INT\n");
        $$ = newTreeNode (vnVal);     
        $$->attr.num_bool = (int)$1;
        $$->valkind = IntK;
     }
     | FLOAT {
        printf ("value -> FLOAT\n");
        $$ = newTreeNode (vnVal);     
        $$->attr.num_bool = (double)$1;
        $$->valkind = FloatK;
     }
     | STRING {
        printf ("value -> STRING\n");
        $$ = newTreeNode (vnVal); 
        $$->attr.str = copyString ((char*)$1);
        $$->valkind = StrK;
     }
     | BOOLEAN {
        printf ("value -> BOOLEAN\n");
        $$ = newTreeNode (vnVal);     
        $$->attr.num_bool = (int)$1;
        $$->valkind = BoolK;
     }
     | NULL_T {
        printf ("value -> NULL_T\n");
        $$ = newTreeNode (vnVal); 
        $$->valkind = NullK;
     }
     | object 
     | array {
        printf ("value -> obj/arr\n");
        $$ = newTreeNode (vnVal); 
        $$->child[0] = $1;
     }
;

%%

int main(int argc, char **argv) {
    yyparse();
    printTree(root);
    return 0;
}

void yyerror(const char*s) {
    printf("yacc error: %s\n", s);
}

int yywrap() {
    return 1;
}














