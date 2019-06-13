CC = gcc
OBJ = main.o parse.o scan.o util.o analyze.o symtab.o cgen.o code.o

CompletedTool :	$(OBJ)
	$(CC) 	-o	$@ 	$^
%.o	:	%.c
	$(CC)	-c -g	$<	

.PHONY: clean
clean:
	rm -rf $(OBJ)

