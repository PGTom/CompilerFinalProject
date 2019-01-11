%{
#include<stdio.h>
#include<string.h>
#include "final.tab.h"
%}
separator [\t|\n|\r|" "]
letter    [a-z]
digit     [0-9]
number    0|[1-9]{digit}*|\-[1-9]{digit}*
id        {letter}({letter}|{digit}|\-)*
bool-val  #t|#f
%%
{separator}  { ; }
{number}     { yylval.ival=atoi(yytext); return(number); }
{bool-val}   {
               if(strcmp(yytext,"#t")==0)
                   yylval.ival=1;
               else
                   yylval.ival=0;
               return(bool_val);
             }
"print-num"  { return(print_num); }
"print-bool" { return(print_bool); }
"mod"        { return(mod); }
"and"        { return(and); }
"or"         { return(or); }
"not"        { return(not); }
"define"     { return(define); }
"if"         { return(IF); }
{id}         { yylval.string=strdup(yytext); return(id); }
.            { return(yytext[0]); }
%%
