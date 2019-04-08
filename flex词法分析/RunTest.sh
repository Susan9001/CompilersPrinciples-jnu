#!/bin/bash
flex $1
analyser=`date +%Y-%m-%d-%H:%M`
gcc -g lex.yy.c -o ${analyser}
./${analyser} $2 $3 & vim -O $3 $2

