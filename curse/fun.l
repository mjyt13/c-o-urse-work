%{
    
#include "der.tab.h"

%}

%%

x {yylval.a=strdup(yytext); return VAR;}
sin {yylval.a=strdup(yytext); return SIN;}
cos {yylval.a=strdup(yytext); return COS;}

"+" {yylval.a=strdup(yytext);return ADD;}
"-" {yylval.a=strdup(yytext);return SUB;}

"*" {yylval.a=strdup(yytext);return MUL;}
"/" {yylval.a=strdup(yytext);return DIV;}

"[" {yylval.a=strdup(yytext); return OBR;}
"]" {yylval.a=strdup(yytext); return EBR;}

\n return NEWLINE;

[ \t] ;

%%

int yywrap(){
    return 1;
}