#!/bin/bash
rm ~/.cache/SpaceVim/swap/*.swp
input="sample.tny"
make && make clean
./AnalyzeTool $input
vim -O $input result.txt



