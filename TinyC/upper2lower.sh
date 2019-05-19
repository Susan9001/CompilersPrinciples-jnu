#!/bin/bash
#for uppercase in `ls`
#do
#    for lowercase in `$uppercase | tr 'A-Z' 'a-z'`
#    do
#        echo $lowercase
#        mv $uppercase $lowercase
#    done
#done

for file in * ;
do mv  $file `echo $file |  tr 'A-Z' 'a-z'` ;
done

#for filename in `ls | grep '[A-Z]'`
#do
#    new_filename=`echo $file | tr 'A-Z' 'a-z'`
#    mv $filename $new_filename 
#done


