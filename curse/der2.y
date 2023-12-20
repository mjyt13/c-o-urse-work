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
%token <a> VAR NUMBER
%token <a> SIN COS EXP

%left ADD SUB
%left MUL DIV
%nonassoc OBR EBR

%token NEWLINE

%type <a> term num line

%%
input:/*void*/
|input line NEWLINE {printf("%s\n",$2);}
;

line: term
|line ADD term {$$=strcat(strcat($1,"+"),$3);free($2);}
|line SUB term {$$=strcat(strcat($1,"-"),$3);free($2);}
|line MUL term {$$=strcat(strcat($1,"*"),$3);free($2);}
|line DIV term {$$=strcat(strcat($1,"/"),$3);free($2);}
|num
;

num: NUMBER MUL term{$$=strcat(strcat(strdup($1),strdup("*")),$3);};

/*sentence: term
|sentence MUL term {$$=strcat(strcat($1,"*"),$3);free($2);}
|sentence DIV term {$$=strcat(strcat($1,"/"),$3);free($2);}
//|NUMBER MUL term {$$=strcat(strcat(strdup($1),"*"),$3);free($2);}
;
*/


term: VAR {$$=strdup("1");}
/*|sentence WORD{$$=strcat($1,$2);free($2);}*/
|SIN OBR VAR EBR {$$=strcat(strcat(strcat(strdup("cos"),strdup("[")),$3),"]");free($2);free($4);}
|COS OBR VAR EBR {$$=strcat(strcat(strcat(strdup("-sin"),strdup("[")),$3),"]");free($2);free($4);}
|EXP OBR VAR EBR {$$=strcat(strcat(strcat($1,strdup("[")),$3),"]");free($2);free($4);}
/*|sentence ADD sentence {$$=strcat(strcat($1,"+"),$3);free($2);}*/
;

%%

int main(){
    yyparse();
    return 0;
}