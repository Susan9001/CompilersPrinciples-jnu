ffname="token.l"
yyname="expr.y"
outname="expr"

flex $ffname
bison -d $yyname
gcc lex.yy.c "${outname}.tab.c" -o "${outname}"
"./${outname}" <b.c> result.txt && vim -O b.c result.txt

