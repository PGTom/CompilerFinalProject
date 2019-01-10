#!/bin/bash

bison -d -o final.tab.c final.y
gcc -c -g -I.. final.tab.c


