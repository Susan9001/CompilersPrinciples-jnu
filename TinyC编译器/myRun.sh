#!/bin/bash
rm ~/.cache/SpaceVim/swap/*.swp
input="sample.tny"
make && make clean
./ParseTools $input
vim -O $input result.txt



