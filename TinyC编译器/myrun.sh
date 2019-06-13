#!/bin/bash
rm ~/.cache/SpaceVim/swap/*.swp
input="fib.tny"
make && make clean
./CompletedTool $input
vim -O $input result.txt



