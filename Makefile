app : lex.yy.c y.tab.c
	gcc lex.yy.c y.tab.c -ll -o app
lex.yy.c : y.tab.c scanner.l
	lex -i scanner.l
y.tab.c : parser.y
	yacc -d parser.y
clean : 
	rm -rf lex.yy.c y.tab.c y.tab.h app app.dSYM
