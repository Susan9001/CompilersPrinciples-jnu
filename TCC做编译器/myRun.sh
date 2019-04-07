#!/bin/bash
input="sample.tny"
make && make clean
./ScanTool $input
vim -O $input result.txt



