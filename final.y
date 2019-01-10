%{
    #include <stdio.h>
    #include <string.h>
    void yyerror(const char *message);
    char* array_name[100];
    int array_val[100];
    int ptr=0;
    int yylex();
%}

%code requires{
    typedef struct{
        int num;
        int boolean;
        char* id_name;
    } nodeType;
}

%union{
    int ival;
    nodeType node;
    char* string;
}

%token <ival> number bool_val
%token print_num print_bool mod and or not IF define
%token <string> id
%type <node> PROGRAM STMT STMTs PRINT_STMT EXP
%type <node> NUM_OP LOGICAL_OP DEF_STMT IF_EXP
%type <node> PLUS PLUSs MINUS MULTIPLY MULTIPLYs DIVIDE
%type <node> MODULUS GREATER SMALLER EQUAL EQUALs
%type <node> AND_OP OR_OP NOT_OP AND_OPs OR_OPs
%type <node> VARIABLE TEST_EXP THAN_EXP ELSE_EXP

%%

PROGRAM
    : STMTs
    ;
STMTs
    : STMT STMTs
    | STMT
    ;
STMT
    : EXP
    | DEF_STMT
    | PRINT_STMT
    ;
PRINT_STMT
    : '(' print_num EXP ')'           { printf("%d\n",$3.num); }
    | '(' print_bool EXP ')'          {
                                        if($3.boolean==0)
                                            printf("#f\n");
                                        else
                                            printf("#t\n");
                                      }
    ;
EXP
    : bool_val                        { $$.boolean=$1; }
    | number                          { $$.num=$1; }
    | NUM_OP                          { $$.num=$1.num; $$.boolean=$1.boolean; }
    | LOGICAL_OP                      { $$.num=$1.num; $$.boolean=$1.boolean; }
    | IF_EXP                          { $$.num=$1.num; $$.boolean=$1.boolean; }
    | VARIABLE                        { $$.num=$1.num; $$.boolean=$1.boolean; }
    ;
NUM_OP
    : PLUS                            { $$.num=$1.num; $$.boolean=$1.boolean; }
    | MINUS                           { $$.num=$1.num; $$.boolean=$1.boolean; }
    | MULTIPLY                        { $$.num=$1.num; $$.boolean=$1.boolean; }
    | DIVIDE                          { $$.num=$1.num; $$.boolean=$1.boolean; }
    | MODULUS                         { $$.num=$1.num; $$.boolean=$1.boolean; }
    | GREATER                         { $$.num=$1.num; $$.boolean=$1.boolean; }
    | SMALLER                         { $$.num=$1.num; $$.boolean=$1.boolean; }
    | EQUAL                           { $$.num=$1.num; $$.boolean=$1.boolean; }
    ;
PLUS
    : '(' '+' PLUSs ')'               { $$.num=$3.num; }
    ;
PLUSs
    : EXP PLUSs                       { $$.num=$1.num; $$.num += $2.num; }
    | EXP                             { $$.num=$1.num; }
    ;
MINUS
    : '(' '-' EXP EXP ')'             { $$.num=$3.num; $$.num -= $4.num; }
    ;
MULTIPLY
    : '(' '*' MULTIPLYs ')'           { $$.num=$3.num; }
    ;
MULTIPLYs
    : EXP MULTIPLYs                   { $$.num=$1.num; $$.num *= $2.num; }
    | EXP                             { $$.num=$1.num; }
    ;
DIVIDE
    : '(' '/' EXP EXP ')'             { $$.num=$3.num; $$.num /= $4.num; }
    ;
MODULUS
    : '(' mod EXP EXP ')'             { $$.num=$3.num; $$.num %= $4.num; }
    ;
GREATER
    : '(' '>' EXP EXP ')'             { $$.boolean=($3.num > $4.num); }
    ;
SMALLER
    : '(' '<' EXP EXP ')'             { $$.boolean=($3.num < $4.num); }
    ;
EQUAL
    : '(' '=' EQUALs ')'              { $$.boolean=$3.boolean; }
    ;
EQUALs
    : EXP EQUALs                      { $$.boolean=($2.boolean && ($1.num == $2.num)); }
    | EXP                             { $$.boolean=$1.boolean; }
    ;
LOGICAL_OP
    : AND_OP                          { $$.num=$1.num; $$.boolean=$1.boolean; }
    | OR_OP                           { $$.num=$1.num; $$.boolean=$1.boolean; }
    | NOT_OP                          { $$.num=$1.num; $$.boolean=$1.boolean; }
    ;
AND_OP
    : '(' and AND_OPs ')'             { $$.boolean=$3.boolean; }
    ;
AND_OPs
    : EXP AND_OPs                     { $$.boolean=($1.boolean && $2.boolean); }
    | EXP                             { $$.boolean=$1.boolean; }
    ;
OR_OP
    : '(' or OR_OPs ')'               { $$.boolean=$3.boolean; }
    ;
OR_OPs
    : EXP OR_OPs                      { $$.boolean=($1.boolean || $2.boolean); }
    | EXP                             { $$.boolean=$1.boolean; }
    ;
NOT_OP
    : '(' not EXP ')'                 { $$.boolean=!($3.boolean); }
    ;
DEF_STMT
    : '(' define VARIABLE EXP ')'     {
                                        array_name[ptr]=$3.id_name;
                                        array_val[ptr]=$4.num;
                                        ptr++;
                                      }
    ;
VARIABLE
    : id                              {
                                        int i;
                                        for(i=0;i<ptr;i++){
                                            if(strcmp(array_name[i],$1)==0){
                                                $$.id_name=$1;
                                                $$.num=array_val[i];
                                                break;
                                            }
                                        }
                                        if(i>=ptr){
                                            $$.id_name=$1;
                                        }
                                      }
    ;
IF_EXP
    : '(' IF TEST_EXP THAN_EXP ELSE_EXP ')'    {
                                                 if($3.boolean == 0){
                                                     $$.boolean=$5.boolean;
                                                     $$.num=$5.num;
                                                 } else {
                                                     $$.boolean=$4.boolean;
                                                     $$.num=$4.num;
                                                 }
                                               }
    ;
TEST_EXP
    : EXP
    ;
THAN_EXP
    : EXP
    ;
ELSE_EXP
    : EXP
    ;

%%

void yyerror(const char *message) {
    fprintf(stderr, "%s\n", message);
}

int main(int argc, char *argv[]) {
    yyparse();
    return(0);
}
