#!/bin/bash
# $1为源.json文件
output="result.txt"
analyser="json_parser"
CC="gcc"
target="json"
buffer="tmp.txt"
end_doc="#"

# 加结束符#号
cat $1 > ${buffer}
echo "${end_doc} ">> ${buffer}

# 编译
$CC -c "${target}.c" -o "${target}.o"
flex "${target}.l"
bison -vdt "${target}.y"
gcc -c "${target}.tab.c" -o "${target}_y.o"
gcc -c lex.yy.c -o "${target}_l.o"
gcc -g "${target}_y.o" "${target}_l.o" "${target}.o" -o "${target}"_parser -lfl
rm lex.yy.c "${target}.tab.h" "${target}.tab.c" *.o 

# 运行
./${analyser} <${buffer}> ${output} && vim -O ${output} 

# 删掉buffer file
rm ${buffer}
