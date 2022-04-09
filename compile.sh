rm lex.yy.c
rm lex.yy.cc

rm y.tab.c
rm y.tab.h

flex -o lex.yy.c lex.l
yacc -d compiler.y
yacc compiler.y

g++ -o compiler y.tab.c