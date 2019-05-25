#ifndef __JSON_H_
#define __JSON_H_

#ifndef FALSE
#define FALSE 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

typedef enum {vnStart, vnObj, vnArr, vnMem, vnElem, vnPair, vnVal} NodeKind;
typedef enum {IntK, FloatK, StrK, BoolK, NullK, ObjK, ArrK} ValKind;

#define MAXCHILDREN 3

typedef struct _treeNode {
    struct _treeNode * parent;
    struct _treeNode * child[MAXCHILDREN];
    struct _treeNode * sibling;
    struct _treeNode * forwardSib; // 回去的
    NodeKind nodekind; // 节点kind
    ValKind valkind; // 如果kind == value的话，此处有效
    union { // value
        int num_bool; // num, True-1, False-0
        double db; // num
        char* str; // 1)StrK的vnVal; 2)VnPair的name(key)
    } attr;
} TreeNode;

extern char * copyString (char* s);
extern int cmpStrIgnoreCase(char* s, char* t);

TreeNode* newTreeNode (NodeKind nodekind); // 词

static int indentno = 0;
#define INDENT indentno+=2
#define UNINDENT indentno-=2
static void printSpaces (void);
void printSpecificSpace(int num);

void printTree (TreeNode *tree);
void cancelIndent(int num);

#endif








