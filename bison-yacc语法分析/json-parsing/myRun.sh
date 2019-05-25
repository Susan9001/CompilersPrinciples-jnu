#!/bin/bash
# $1为源.json文件
output="result.txt"
analyser="json_parser"
make && make clean
./${analyser} <$1> ${output} && vim -O ${output} $1
