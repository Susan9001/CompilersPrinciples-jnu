#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include "json.h"

char * copyString(char * s) { 
    int n;
    char * t;
    if (s==NULL) return NULL;
    n = strlen(s)+1;
    t = (char*)malloc(n);
    if (t==NULL)
        printf("Out of memory error!\n");
    else strcpy(t,s);
    return t;
}

int cmpStrIgnoreCase(char* s, char* t) {
    int n, i;
    if (s == NULL) {
        if (t == NULL)
            return TRUE;
        return FALSE;
    }
    n = strlen(s) + 1;
    for (i = 0; i < n; i++) {
        if (tolower(s[i]) != tolower(t[i]))
            return FALSE;
    }
    return TRUE;
}

TreeNode * newTreeNode (NodeKind kind) {
    TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
    int i;
    if (t==NULL)
        printf("Out of memory error!\n");
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
        printf(" ");
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
                        printf ( "%d\n", tree->attr.num_bool);
                        break;
                    case FloatK:
                        printf ( "%lf\n", tree->attr.db);
                        break;
                    case StrK:
                        printf ( "%s\n", tree->attr.str);
                        break;
                    case BoolK:
                        if (tree->attr.num_bool == 0)
                            printf ( "false\n");
                        else if (tree->attr.num_bool == 1)
                            printf ( "true\n");
                        break;
                    case NullK:
                        printf ( "null\n");
                        break;
                    case ObjK:case ArrK:
                        break; // 左右括号在转移到vnObj or vArr时候才转
                    default:
                        printf ( "Unexpected ValKind~\n");
                } 
            case vnStart:
                printf ( "--------JsonTree--------\n");
                break;
            case vnObj:
                printf ( "{\n"); 
                break;
                // 回退时再处理右括号
                break;
            case vnArr:
                printf ( "[\n");
                break;
                // 回退时再处理右括号
            case vnMem:
                break; // vnPair时再处理
            case vnElem:
                break;
            case vnPair:
                printf ( "%s: ", tree->attr.str); // print key
                INDENT; // 抵消掉缩进
                break;
            default:
                printf ( "Unexpected NodeKind~\n");
                break;
        }
        // 处理儿子
        for (i = 0; i < MAXCHILDREN; i++) {
            printTree (tree->child[i]);
        }
        // 完结括号
        if (tree->nodekind == vnObj) {
            printf ( "}\n");
        } else if (tree->nodekind == vnArr) {
            printf ( "]\n");
        }
        // sibling主要针对elements
        tree = tree->sibling;
    }
    UNINDENT;
}











