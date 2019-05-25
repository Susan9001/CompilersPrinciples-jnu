#!/bin/bash
# $1为源.json文件
output="result.txt"
analyser="json_parser"
CC="gcc"
target="json"

$CC -c "${target}.c" -o "${target}.o"
flex "${target}.l"
bison -vdt "${target}.y"
gcc -c "${target}.tab.c" -o "${target}_y.o"
gcc -c lex.yy.c -o "${target}_l.o"
gcc -g "${target}_y.o" "${target}_l.o" "${target}.o" -o "${target}"_parser -lfl

rm lex.yy.c "${target}.tab.h" "${target}.tab.c" *.o 

./${analyser} <$1> ${output} && vim -O ${output} 
