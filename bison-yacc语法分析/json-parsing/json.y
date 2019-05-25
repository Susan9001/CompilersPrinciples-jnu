%{
#include <stdio.h>
#include <stdlib.h>
#include "json.h"

void yyerror(const char*s);
//extern char*  copyString(char*s);
//extern int cmpStrIgnoreCase (char* s, char*t);
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
        $$ = newTreeNode (vnStart);
        $$->child[0] = $1;
        root = $$;
     }  
;
object: BEGIN_OBJECT BEGIN_ARRAY {
        $$ = newTreeNode (vnObj);
      }
      | BEGIN_OBJECT members BEGIN_ARRAY {
        $$ = newTreeNode (vnObj);
        $$->child[0] = $2; 
      }
;
members: pair {
        $$ = newTreeNode (vnPair);
        $$->child[0] = $1;
       }
       | pair SEP_COMMA pair {
        $$ = newTreeNode (vnPair);
        $$->child[0] = $1;
        $$->child[1] = $3;
       }
;
array: BEGIN_ARRAY END_ARRAY {
        $$ = newTreeNode (vnArr);
     }
     | BEGIN_ARRAY elements END_ARRAY {
        $$ = newTreeNode (vnArr);
        $$->child[0] = $2;
     }
;
elements: value {
            $$ = newTreeNode (vnElem);
            $$->child[0] = $1;
        }
        | value SEP_COMMA elements {
            $$ = newTreeNode (vnElem);
            $$->child[0] = $1;
            $$->sibling = $3;
        }
;
pair: STRING SEP_COLON value {
        $$ = newTreeNode (vnPair);     
        $$->attr.str = copyString((char*)$1);
        $$->child[0] = $3;
    } 
;
value: INT {
        $$ = newTreeNode (vnVal);     
        $$->attr.num_bool = (int)$1;
        $$->valkind = IntK;
     }
     | FLOAT {
        $$ = newTreeNode (vnVal);     
        $$->attr.num_bool = (double)$1;
        $$->valkind = FloatK;
     }
     | STRING {
        $$ = newTreeNode (vnVal); 
        $$->attr.str = copyString ((char*)$1);
        $$->valkind = StrK;
     }
     | BOOLEAN {
        $$ = newTreeNode (vnVal);     
        $$->attr.num_bool = (int)$1;
        $$->valkind = BoolK;
     }
     | NULL_T {
        $$ = newTreeNode (vnVal); 
        $$->valkind = NullK;
     }
     | object 
     | array {
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
    return 0;
}














