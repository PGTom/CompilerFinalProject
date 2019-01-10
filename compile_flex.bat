#!/bin/bash

flex -o final.yy.c final.l
gcc -c -g -I.. final.yy.c
