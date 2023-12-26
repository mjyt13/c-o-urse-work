%{
#include <stdio.h>    
#include <stdlib.h>   
#include <string.h>
#include "calc.tab.h"

int yylex();

void yyerror(const char * s){
    fprintf(stderr,"ERROR IS FOUND IN %s\n ",s);
};
%}

%union {
    struct {
        char * fun;
        char * der;
        int num;    
    } a;
}

%token <a> NUMBER VAR
%token <a> ADD SUB MUL DIV DEG
%left ADD SUB
%left MUL DIV DEG
%token <a> OBR EBR
%token <a> SIN COS EXP
%nonassoc OBR EBR
%token NEWLINE

%type <a> term num line

%%
input: /*void*/
|input line NEWLINE{printf("%s\n",$2.fun);}
;

line:term{$$.fun=$1.der;}
|line ADD term {$$.fun=strcat(strcat($1.der,"+"),$3.der);}
|line SUB term {$$.fun=strcat(strcat($1.der,"-"),$3.der);}
|line MUL term {$$.fun=strcat(strcat($1.der,"*"),$3.der);}
|line DIV term {$$.fun=strcat(strcat($1.der,"/"),$3.der);}
;

term: VAR {$$.der=strdup("1");}
|VAR DEG OBR num EBR {char * temp = malloc(7);
$$.der=strcat(strcat(strcat(strcat(strdup($4.der),
strdup("*")),$1.der),strdup("^")),strdup("["));
int value = atoi($4.der);
value--;
sprintf(temp,"%d",value);
$$.der=strcat(strcat($$.der,temp),"]");}
|SIN OBR VAR EBR {$$.der=strcat(strcat(strcat(strdup("cos"),strdup("[")),$3.der),strdup("]"));}
|COS OBR VAR EBR {$$.der=strcat(strcat(strcat(strdup("-sin"),strdup("[")),$3.der),strdup("]"));}
|EXP OBR VAR EBR {$$.der=strcat(strcat(strcat($1.der,strdup("[")),$3.der),strdup("]"));}
|num MUL term{$$.der=strcat(strcat(strdup($1.der),strdup("*")),$3.der);}
;

num: NUMBER{$$.der=malloc(20);sprintf($$.der,"%d",$1.num);}
;
%%

int main(){
    yyparse();
    return 0;
}