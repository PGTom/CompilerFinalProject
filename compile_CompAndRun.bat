#!/bin/bash

#copile bision
bison -d -o final.tab.c final.y 2> /dev/null
gcc -c -g -I.. final.tab.c 2> /dev/null
#compile flex
flex -o final.yy.c final.l 2> /dev/null
gcc -c -g -I.. final.yy.c 2> /dev/null
#compile and link bison and flex
gcc -o lispFile final.tab.o final.yy.o -ll 2> /dev/null

