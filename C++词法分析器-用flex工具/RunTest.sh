#!/bin/bash
# $1为源.cpp文件
flex CPP词法分析.l
output="result.txt"
analyser="词法分析器.exe"
gcc -g lex.yy.c -o ${analyser}
./${analyser} $1 ${output} & vim -O ${output} $1

