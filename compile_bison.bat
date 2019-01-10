#!/bin/bash

read -p "File Name:" name

bison -d -o y.tab.c ${name}.y
gcc -c -g -I.. y.tab.c


