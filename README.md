# Mini-LISP
Compiler final project(2018/01/11-14:20~14:40)

The language that my project’s interpreter will process is a subset of [LISP](https://en.wikipedia.org/wiki/LISP), which we call
it Mini-LISP for convenience. This handout first offers a general description, then goes
into details such as lexical structure and grammar of the subset.

## Enviorment
Oracle VM VirtualBox-Linux,Ubuntu(64-bit) ([OfficalWebLink](https://www.oracle.com/technetwork/server-storage/virtualbox/downloads/index.html))

Editer:[Nano](https://zh.wikipedia.org/wiki/Nano_(%E6%96%87%E5%AD%97%E7%B7%A8%E8%BC%AF%E5%99%A8))

## Overview
LISP is an ancient programming language based on [S-expressions](https://en.wikipedia.org/wiki/S-expression) and [lambda calculus](https://en.wikipedia.org/wiki/Lambda_calculus).
All operations in Mini-LISP are written in parenthesized [prefix notation](https://en.wikipedia.org/wiki/Polish_notation). For example, a
simple mathematical formula “(1 + 2) * 3” written in Mini-LISP is:

<pre><code>(* (+ 1 2) 3)</code></pre>

As a simplified language, Mini-LISP has only three types (*Boolean*, *number* and *function*)
and a few operations.

**Type Definition**

- Boolean: Boolean type includes two values, #t for true and #f for false.
- Number: Signed integer from −(2^31 ) to 2^31 – 1, behavior out of this ran$
- Function:See the label *Grammer Overview*.

## How to Run
Execute these command in sequence, if you want to check if there is any warning Message

<pre><code>
bash compile_bison.bat
(enter filename)

bash compile_flex.bat
(enter filename)

bash compile_link.bat
(enter filename)

./filename<\code><\pre>

To ignore all warning Message, easily execute this command to compile all process and run in one time:

<pre><code>
bash compile_CompAndRun.bat
(enter filename)<\code><\pre>

## Grammer Overview
<pre><code>PROGRAM ::= STMT+
STMT         ::= EXP | DEF-STMT | PRINT-STMT
PRINT-STMT   ::= (print-num EXP) | (print-bool EXP)
EXP          ::= bool-val | number | VARIABLE | NUM-OP | LOGICAL-OP
               | FUN-EXP | FUN-CALL | IF-EXP
NUM-OP       ::= PLUS | MINUS | MULTIPLY | DIVIDE | MODULUS | GREATER
               | SMALLER | EQUAL
    PLUS     ::= (+ EXP EXP+)
    MINUS    ::= (- EXP EXP)
    MULTIPLY ::= (* EXP EXP+)
    DIVIDE   ::= (/ EXP EXP)
    MODULUS  ::= (mod EXP EXP)
    GREATER  ::= (> EXP EXP)
    SMALLER  ::= (< EXP EXP)
    EQUAL    ::= (= EXP EXP+)
LOGICAL-OP   ::= AND-OP | OR-OP | NOT-OP
    AND-OP   ::= (and EXP EXP+)
    OR-OP    ::= (or EXP EXP+)
    NOT-OP   ::= (not EXP)
DEF-STMT     ::= (define VARIABLE EXP)
    VARIABLE ::= id
FUN-EXP      ::= (lambda FUN_IDs FUN-BODY)
    FUN-IDs  ::= (id*)
    FUN-BODY ::= EXP
    FUN-CALL ::= (FUN-EXP PARAM*) | (FUN-NAME PARAM*)
    PARAM    ::= EXP
    LAST-EXP ::= EXP
    FUN-NAME ::= id
IF-EXP       ::= (if TEST-EXP THAN-EXP ELSE-EXP)
    TEST-EXP ::= EXP
    THEN-EXP ::= EXP
    ELSE-EXP ::= EXP</code></pre>

