%{
#include <stdio.h>    
#include <stdlib.h>    
#include <string.h>

int yylex();

void yyerror(const char * s){
    fprintf(stderr,"ERROR IS FOUND IN %s\n ",s);
};
%}

%union {
    char * a;

}
%token <a> ADD SUB MUL DIV
%token <a> OBR EBR
%token <a> VAR
%token <a> SIN COS

%left ADD SUB
%left MUL DIV
%nonassoc OBR EBR

%token NEWLINE

%type <a> term sentence line

%%
input:/*void*/
|input line NEWLINE {printf("%s\n",$2);}
;

line: sentence
|line ADD sentence {$$=strcat(strcat($1,"+"),$3);free($2);}
|line SUB sentence {$$=strcat(strcat($1,"-"),$3);free($2);}
;

sentence: term
|sentence MUL term {$$=strcat(strcat($1,"*"),$3);free($2);}
|sentence DIV term {$$=strcat(strcat($1,"/"),$3);free($2);}
;

term: VAR
/*|sentence WORD{$$=strcat($1,$2);free($2);}*/
|SIN OBR line EBR {$$=strcat(strcat(strcat($1,strdup("[")),$3),"]");free($2);free($4);}
|COS OBR line EBR {$$=strcat(strcat(strcat($1,strdup("[")),$3),"]");free($2);free($4);}
/*|sentence ADD sentence {$$=strcat(strcat($1,"+"),$3);free($2);}*/
;

%%

int main(){
    yyparse();
    return 0;
}