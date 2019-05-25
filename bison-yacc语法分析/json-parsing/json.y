%{
#include <stdio.h>
#include <stdlib.h>
#include "json.h"

void yyerror(const char*s);
TreeNode *root; // 从start开始...
TreeNode *tmpRoot;
%}

%union {
    // 以下一个针对非终结符
    TreeNode* pNode;
    // 以下三个是针对终结符的
    char* str;
    int num_bool;
    double db;
}

%token BEGIN_OBJECT	 END_OBJECT END_DOCUMENT
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
%left END_DOCUMENT

%%

start: object END_DOCUMENT
     | array END_DOCUMENT {
        printf ("start->obj/arr\n");
        $$ = newTreeNode (vnStart);
        $$->child[0] = $1;
        $1->parent = $$;
        tmpRoot = $$;
     }  
;
object: BEGIN_OBJECT END_OBJECT {
        $$ = newTreeNode (vnObj);
        tmpRoot = $$;
      }
      | BEGIN_OBJECT members END_OBJECT {
        // 找回members的头结点
        TreeNode* p = $2;
        while (p->forwardSib != NULL)
            p = p->forwardSib;
        printf ("obj->members\n");
        // 连起来
        $$ = newTreeNode (vnObj);
        $$->child[0] = p; 
        p->parent = $$;
        tmpRoot = $$;
      }
;
members: pair {
        printf ("members->pair\n");
        $$ = newTreeNode (vnMem);
        $$->child[0] = $1;
        $1->parent = $$;
       }
       | members SEP_COMMA pair {
        printf ("members->members , pair\n");
        $$ = newTreeNode (vnMem);
        $1->sibling = $$;
        $$->forwardSib = $1;
        $$->child[0] = $3;
        $3->parent = $$;
       }
;
array: BEGIN_ARRAY END_ARRAY {
        printf ("array ->[ ]\n");
        $$ = newTreeNode (vnArr);
        tmpRoot = $$;
     }
     | BEGIN_ARRAY elements END_ARRAY {
        TreeNode *p = $2;
        while (p->forwardSib != NULL) 
            p = p->forwardSib;
        printf ("array ->[ elements ]\n");
        $$ = newTreeNode (vnArr);
        $$->child[0] = p;
        p->parent = $$;
        tmpRoot = $$;
     }
;
elements: value {
            printf ("elements -> value\n");
            $$ = newTreeNode (vnElem);
            $$->child[0] = $1;
            $1->parent = $$;
        }
        | elements SEP_COMMA value {
            printf ("elements -> value , elements\n");
            $$ = newTreeNode (vnElem);
            $1->sibling = $$;
            $$->forwardSib = $1;
            $$->child[0] = $3;
            $3->parent = $$;
        }
;
pair: STRING SEP_COLON value {
        printf ("pair -> STRING : value\n");
        $$ = newTreeNode (vnPair);     
        $$->attr.str = copyString((char*)$1);
        $$->child[0] = $3;
        $3->parent = $$;
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
     | object  {
        printf ("value -> object\n");
        $$ = newTreeNode (vnVal); 
        $$->child[0] = $1;
        $1->parent = $$;
        $$->valkind = ObjK;
     }
     | array {
        printf ("value -> array\n");
        $$ = newTreeNode (vnVal); 
        $$->child[0] = $1;
        $1->parent = $$;
        $$->valkind = ArrK;
     }
;

%%

int main(int argc, char **argv) {
    yyparse();
    root = newTreeNode (vnStart);
    root->child[0] = tmpRoot;
    printf ("\n-----Reconstruct from the Syntax Tree-----\n");
    printTree(root);
    return 0;
}

void yyerror(const char*s) {
    printf("yacc error: %s\n", s);
}

int yywrap() {
    return 1;
}














