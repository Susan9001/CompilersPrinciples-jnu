/****************************************************/
/* File: parse.c                                    */
/* The parser implementation for the TINY compiler  */
/****************************************************/

#include "globals.h"
#include "util.h"
#include "scan.h"
#include "parse.h"

static TokenType token; /* holds current token */

/* function prototypes for recursive calls */
static TreeNode * stmt_sequence(void);
static TreeNode * statement(void);
static TreeNode * if_stmt(void);
static TreeNode * repeat_stmt(void);
static TreeNode * assign_stmt(void);
static TreeNode * read_stmt(void);
static TreeNode * write_stmt(void);
static TreeNode * exp(void); // demo 1
static TreeNode * simple_exp(void);
static TreeNode * term(void);
static TreeNode * factor(void);

static void syntaxError(char * message) { 
    fprintf(listing,"\n>>> ");
    fprintf(listing,"Syntax error at line %d: %s",lineno,message);
    Error = TRUE;
}

static void match(TokenType expected) {
    if (token == expected) token = getToken();
    else {
        syntaxError("unexpected token -> ");
        printToken(token,tokenString);
        fprintf(listing,"      ");
    }
}

TreeNode * stmt_sequence(void){ 
    TreeNode * t = statement();
    TreeNode * p = t;
    while ((token!=ENDFILE) && (token!=END) &&
            (token!=ELSE) && (token!=UNTIL)) {
        TreeNode * q;
        match(SEMI);
        q = statement(); // SEMI
        if (q!=NULL) {
            if (t==NULL) t = p = q;
            else /* now p cannot be NULL either */
            { 
                p->sibling = q;
                p = q;
            }
        }
    }
    return t;
}

TreeNode * statement(void) { 
    TreeNode * t = NULL;
    switch (token) {
        case IF : t = if_stmt(); break;
        case REPEAT : t = repeat_stmt(); break;
        case ID : t = assign_stmt(); break;
        case READ : t = read_stmt(); break;
        case WRITE : t = write_stmt(); break;
        default : syntaxError("unexpected token -> ");
                  printToken(token,tokenString);
                  token = getToken();
                  break;
    } /* end case */
    return t;
}

TreeNode * if_stmt(void) {          
    /** if_stmt -> IF exp THEN stmt_sequence END 
     *          | IF exp THEN stmt_sequence ELSE stmt_sequence END
     **/
    TreeNode * t = newStmtNode (IfK);
    if (t != NULL) {
        match (IF);
        t->child[0] = exp ();
        match (THEN);
        t->child[1] = stmt_sequence ();
        if (token == END) {
            match (token); 
        }
        else if (token == ELSE) {
            t->child[2] = stmt_sequence ();
            match (END);
        }
    }
    return t;
}

TreeNode * repeat_stmt(void) {
    /* repeat_stmt -> REPEAT stmt_sequence UNTIL exp */
    TreeNode * t = newStmtNode(RepeatK);
    if (t != NULL) {
        match (REPEAT);
        t->child[0] = stmt_sequence();
        match(UNTIL);
        t->child[1] = exp();
    }
    return t; 
}

TreeNode * assign_stmt(void) { 
    /* assign_stmt -> DI ASSIGN exp */
    TreeNode * t = newStmtNode (AssignK);
    if (t != NULL) {
        t->attr.name = copyString (tokenString); // id
        match (ID);
        match (ASSIGN);
        t->child[0] = exp();
    }
    return t;
}

TreeNode * read_stmt(void) {
    /* read_stmt -> READ ID */
    TreeNode * t = newStmtNode (ReadK);
    if (t != NULL) {
        match (READ);
        t->attr.name = copyString (tokenString); // ID
        match (ID); // move forward 
    }
    return t;
}

TreeNode * write_stmt(void) {
    /* write_stmt -> WRITE exp */
    TreeNode * t = newStmtNode(WriteK);
    if (t !=  NULL) {
        t->attr.op = WRITE;
        match (WRITE);
        t->child[0] = exp();
    }
    return t;
}

TreeNode * exp(void){
    /**
     * exp -> simple_exp
     *      | simple_exp LT simple_exp
     *      | simple_exp EQ simple_exp
     **/
    TreeNode * t = simple_exp();
    if ((token==LT)||(token==EQ)) {
        TreeNode * p = newExpNode(OpK); // 生成中间>/=节点
        if (p!=NULL) {
            p->child[0] = t;
            p->attr.op = token; 
            t = p;
        }
        match(token);
        if (t!=NULL)
            t->child[1] = simple_exp();
    } // else 则是exp -> simple_exp
    return t;
}

TreeNode * simple_exp(void) {
    /**
     * simple->exp -> term
     *              | term MINUS term
     *              | term PLUS term
     **/
    TreeNode *t = term ();
    if ((token == PLUS) || (token == MINUS)) {
        TreeNode *p = newExpNode (OpK);
        if (p != NULL) {
            p->child[0] = t;
            p->attr.op = token;
            t = p;
        }
        match (token);
        if (t != NULL)
            t->child[1] = term ();
    }
    return t;
}

TreeNode * term(void) {
    /**
     * term -> factor
     *      | factor TIMES factor
     *      | factor MINUS factor
     * */
    TreeNode *t = factor ();
    if ((token == TIMES) || (token == OVER)) {
        TreeNode *p = newExpNode (OpK);
        if (p != NULL) {
            p->child[0] = t;
            p->attr.op = token;
            t = p;
        }
        match (token);
        if (t != NULL)
            t->child[1] = factor ();
    }
    return t;
}

TreeNode * factor(void) {
    /**
     * factor -> (exp) 
     *          | ID 
     *          | NUM
     * */
    TreeNode * t;
    if (token == NUM) {
        t = newExpNode (ConstK);
        //t->attr.val = (int)(copyString(tokenString)); 
        t->attr.val = atoi(copyString(tokenString)); 
        match(token); // move forward
    }
    else if (token == ID) {
        t = newExpNode (IdK);
        t->attr.name = copyString (tokenString);
        match(token); // move forward
    }
    else { // (exp)
        match (LPAREN); // match "("
        t = exp ();
        match (REPEAT); // match ")"
    }
    return t;
}

/****************************************/
/* the primary function of the parser   */
/****************************************/
/* Function parse returns the newly 
 * constructed syntax tree
 */
TreeNode * parse(void) { 
    TreeNode * t;
    token = getToken();
    t = stmt_sequence();
    if (token!=ENDFILE)
        syntaxError("Code ends before file\n");
    return t;
}









