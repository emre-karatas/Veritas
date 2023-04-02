parser: y.tab.o lex.yy.o
	gcc -o parser y.tab.o lex.yy.o 

lex.yy.o: lex.yy.c y.tab.h
  lex.yy.o y.tab.o: y.tab.c


y.tab.c y.tab.h: CS315_S23_Team07.yacc
	yacc -d -v CS315_S23_Team07.yacc


lex.yy.c: CS315_S23_Team07.lex
	lex CS315_S23_Team07.lex
 
clean:
	rm -f lex.yy.c lex.yy.o y.tab.c y.tab.h y.tab.o y.output