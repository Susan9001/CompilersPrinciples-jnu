%{
    #include "stdio.h"
    #define MAX_FLIE_LEN 50

    int line_num = 1;
    int preproc_flag = 0;
%}

RESERVED asm|do|if|return|typedef|auto|double|inline|short|typeid|bool|dynamic_cast|int|signed|typename|break|else|long|sizeof|union|case|enum|mutable|static|unsigned|catch|explicit|namespace|static_cast|using|char|export|new|struct|virtual|class|extern|operator|switch|void|const|false|private|template|volatile|const_cast|float|protected|this|wchar_t|continue|for|public|throw|while|default|friend|register|true|delete|goto|reinterpret_cast|try
PREPORCESS ^{SPACE}*#{SPACE}*
DIGIT [0-9]
INTEGER [-+]?{DIGIT}+
DOUBLE [-+]?{DIGIT}+[.]{DIGIT}+
SCIENCE_NUM ({DOUBLE}|{INTEGER})e{INTEGER}
NUMBER {INTEGER}|{DOUBLE}|{SCIENCE_NUM}
LETTER [a-zA-Z]
IDENTIFIER ({LETTER}|[_])({LETTER}|{DIGIT}){0,31}
SPACE [ \t]+
NEWLINE [\n]+
SEPERATER [\.;\"\'\(\)\[\]\{\},:]
MAYBE_HEADER [\"<](.)+[\">]
SIMPOE_OPERATOR [\+\-\*\/\&\^\%\>\<=~]
OPERATOR {SIMPOE_OPERATOR}|{SIMPOE_OPERATOR}"="|(\+\+)|(\-\-)|(\>\>)|(\<\<)|"->"|"::"|(new(\[\])?)|(delete(\[\])?)|sizeof
%start forPredef forHeader

%%
{PREPORCESS} {
    fprintf(yyout, "---%d行: 预处理指令---\n", line_num);
    preproc_flag = 1;
    BEGIN forPredef; // 像是闭包？
}
<forPredef>"define" {
    fprintf (yyout, "%d行: %s\t宏定义\n", line_num, yytext);
    BEGIN 0;
}
<forPredef>"include" {
    fprintf (yyout, "%d行: %s\t含头文件\n", line_num, yytext);
    BEGIN forHeader;
}
<forPredef>"if"|"endif" {
    fprintf (yyout, "%d行: %s\t条件编译指令\n", line_num, yytext);
    BEGIN 0;
}
{SPACE}  {
    /*do nothing...*/
}
{NEWLINE} {
    preproc_flag = 0;
    line_num++;
    fprintf(yyout, "------%d行------\n", line_num);
}
<forHeader>{MAYBE_HEADER} {
    // 去头去尾
    int ok = 0;
    char header[MAX_FLIE_LEN];
    char* hPtr = header;
    yytext++;
    while (*yytext != '>' && *yytext != '"') {
        if (*yytext != ' ' && *yytext != '\t') {
            *hPtr = *yytext;
            hPtr++;
        }
        yytext++;
    }
    *hPtr = '\0';

    fprintf (yyout, "%d行: %s\t头文件名\n", line_num, header);
    BEGIN 0;
 }
{NUMBER} {
    // 必定放在识别头文件之后，否则头文件名会直接被识别为数字
    fprintf (yyout, "%d行: %s\t数字\n",line_num, yytext);
}
{SEPERATER} {
    fprintf (yyout, "%d行: %s\t分隔符\n", line_num, yytext);
}
{OPERATOR} {
    fprintf (yyout, "%d行: %s\t运算符\n", line_num, yytext);
}
{RESERVED} {
    // 保留字，优先级放除了标识符之后
    fprintf(yyout, "%d行: %s\t保留字\n", line_num,yytext);
}
{IDENTIFIER} {
    fprintf (yyout, "%d行: %s\t标识符\n", line_num, yytext);
}
"//".* {}
"/*"."*/" {/* 只有一行不到的情况*/ }
"/*" {
    char ch ;
    int done=0;
    do {
        while((ch=input())!='*' && ch != '\0') {
            if (ch == '\n') line_num++;
        }
        while((ch=input())=='*' && ch != '\0') {
            if (ch == '\n') line_num++;
        }
        if(ch=='/') done=1;
    }while(!done);
} 
. fprintf (yyout, "%d行: %s\t我是谁\n", line_num, yytext);
%%

int main(int argc,char **argv)
{
    ++argv,--argc;
    if(argc>0)
        yyin=fopen(argv[0],"r");
    else
        yyin=stdin;
        ++argv,--argc;
    if(argc>0)
        yyout=fopen(argv[0],"w");
    else
        yyout=stdout;
        yylex();
    return 0;
}

int yywrap() {
    return 1;
}











