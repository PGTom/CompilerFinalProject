#!/bin/bash

read -p "File Name:" name

gcc -o ${name} y.tab.o lex.yy.o -ll
