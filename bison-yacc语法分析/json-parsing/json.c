#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "json.h"

FILE * listing; // output. declared in func main, "json.y" 

char * copyString(char * s) { 
    int n;
    char * t;
    if (s==NULL) return NULL;
    n = strlen(s)+1;
    t = malloc(n);
    if (t==NULL)
        fprintf(listing,"Out of memory error!\n");
    else strcpy(t,s);
    return t;
}

TreeNode * newTreeNode (NodeKind kind) {
    TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
    int i;
    if (t==NULL)
        fprintf(listing,"Out of memory error!\n");
    else {
        for (i=0;i<MAXCHILDREN;i++) 
            t->child[i] = NULL;
        t->sibling = NULL;
        t->nodekind = kind;
        // if t->nodekind == vnVal:
        // .l,Vt,生成InK,FloatK,StrK,BoolK, NullK
        // .y,Vn, 生成ObjK,ArrK
    }
}

static void printSpaces(void){ 
    int i;
    for (i=0;i<indentno;i++)
        fprintf(listing," ");
}

void printTree (TreeNode* tree) {
    int i;
    INDENT;
    while (tree != NULL) {
        printSpaces ();
        switch (tree->nodekind) {
            case vnVal:
                switch (tree->valkind) {
                    case IntK:
                        fprintf (listing, "%d\n", tree->attr.num_bool);
                        break;
                    case FloatK:
                        fprintf (listing, "%lf\n", tree->attr.db);
                        break;
                    case StrK:
                        fprintf (listing, "%s\n", tree->attr.str);
                        break;
                    case BoolK:
                        if (tree->attr.num_bool == 0)
                            fprintf (listing, "false\n");
                        else if (tree->attr.num_bool == 1)
                            fprintf (listing, "true\n");
                        break;
                    case NullK:
                        fprintf (listing, "null\n");
                        break;
                    case ObjK:case ArrK:
                        break; // 左右括号在转移到vnObj or vArr时候才转
                    default:
                        fprintf (listing, "Unexpected ValKind~\n");
                } 
            case vnStart:
                fprintf (listing, "--------PrintTree--------\n");
                break;
            case vnObj:
                fprintf (listing, "{"); // pair前才换行
                break;
                // 回退时再处理右括号
                break;
            case vnArr:
                fprintf (listing, "["); // elements前才换行
                break;
                // 回退时再处理右括号
            case vnMem:
                break; // vnPair时再处理
            case vnElem:
                fprintf (listing, "\n");
            case vnPair:
                fprintf (listing, "\n%s: ", tree->attr.str); // print key
                break;
            default:
                fprintf (listing, "Unexpected NodeKind~\n");
                break;
        }
        // 处理儿子
        for (i = 0; i < MAXCHILDREN; i++) {
            printTree (tree->child[i]);
        }
        // 完结括号
        if (tree->nodekind == vnObj) {
            fprintf (listing, "}\n");
        } else if (tree->nodekind == vnArr) {
            fprintf (listing, "]\n");
        }
        // sibling主要针对elements
        tree = tree->sibling;
    }
    UNINDENT;
}











