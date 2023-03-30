parser: y.tab.o lex.yy.o
	gcc -o parser y.tab.o lex.yy.o 

lex.yy.o: lex.yy.c y.tab.h
  lex.yy.o y.tab.o: y.tab.c


y.tab.c y.tab.h: veritas.y
	yacc -d -v veritas.y


lex.yy.c: veritas.l
	lex veritas.l
 
clean:
	rm -f lex.yy.c lex.yy.o y.tab.c y.tab.h y.tab.o y.output