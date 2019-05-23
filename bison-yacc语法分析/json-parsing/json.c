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
        if (tree->nodekind == vnVal) {
            switch (tree->valkind) {
                case IntK:
                    fprintf (listing, "%d\n", tree->attr.num_bool);
                    break;
                case FloatK:
                    fprintf (listing, "%d\n", tree->attr.db);
                    break;
                case StrK:
                    fprintf (listing, "%s\n", tree->attr.str);
                    break;
            } 
        }
    }
}











