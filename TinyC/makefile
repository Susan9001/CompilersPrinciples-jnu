CC = gcc
OBJ = main.o parse.o scan.o util.o

ScanTool	:	$(OBJ)
	$(CC) 	-o	$@ 	$^
%.o	:	%.c
	$(CC)	-c	$<	

.PHONY: clean
clean:
	rm -rf $(OBJ)

