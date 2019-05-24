CC = gcc
OBJ = main.o parse.o scan.o util.o

ParseTools	:	$(OBJ)
	$(CC) 	-o	$@ 	$^
%.o	:	%.c
	$(CC)	-c -g	$<	

.PHONY: clean
clean:
	rm -rf $(OBJ)

