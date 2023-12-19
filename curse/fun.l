%{
    
#include "der.tab.h"

%}

%%

[a-zA-Z]+ {yylval.a=strdup(yytext); return WORD;}
"[" {yylval.a=strdup(yytext); return OBR;}
"]" {yylval.a=strdup(yytext); return EBR;}

\n return NEWLINE;

[ \t] ;

%%

int yywrap(){
    return 1;
}