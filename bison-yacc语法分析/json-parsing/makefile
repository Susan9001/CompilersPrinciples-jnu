CC = g++
LEX = flex
YACC = bison
OBJ = json_y.o json_l.o json.o

json_parser: $(OBJ)
	$(CC) -o $@ -lfl

json_y.o: json.tab.c 
	$(CC) -c $^ -o $@

json_l.o: lex.yy.c json.c
	$(CC) -c $^ -o $@

json.o: json.c
	$(CC) -c $^ -o $@

json.tab.c: json.y
	$(YACC) -vdt json.y

lex.yy.c: json.l
	$(LEX) json.l

.PHONY: clean
clean:
	#rm lex.yy.c json.tab.c json.tab.h json.output *.o 
	rm lex.yy.c json.tab.c json.tab.h json.output *.o 



