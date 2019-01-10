#!/bin/bash

read -p "File Name:" name

flex -o lex.yy.c ${name}.l
gcc -c -g -I.. lex.yy.c
