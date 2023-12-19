%{
#include <stdio.h>    
#include <stdlib.h>    
#include <string.h>

int yylex();

void yyerror(const char * s){
    fprintf(stderr,"ERROR IS FOUND IN %s ",s);
};
%}

%union {
    char * a;

}

%token <a> WORD OBR EBR
%token NEWLINE

%type <a> sentence

%%
input:/*void*/
|input sentence NEWLINE {printf("%s\n",$2);}
;

sentence: WORD
|sentence WORD{$$=strcat($1,$2);free($2);}
|sentence OBR sentence EBR {$$=strcat(strcat(strcat($1,strdup("[")),$3),"]");free($2);free($4);}
;

%%

int main(){
    yyparse();
    return 0;
}