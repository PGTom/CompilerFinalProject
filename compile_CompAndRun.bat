#!/bin/bash

read -p "File Name:" name

#copile bision
bison -d -o y.tab.c ${name}.y 2> /dev/null
gcc -c -g -I.. y.tab.c 2> /dev/null
#compile flex
flex -o lex.yy.c ${name}.l 2> /dev/null
gcc -c -g -I.. lex.yy.c 2> /dev/null
#compile and link bison and flex
gcc -o ${name} y.tab.o lex.yy.o -ll 2> /dev/null

#run 
./${name}

