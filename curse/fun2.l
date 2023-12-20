%{
    
#include "der.tab.h"

%}

%%

[0-9]+ {yylval.a=strdup(yytext); return NUMBER;}
x {yylval.a=strdup(yytext); return VAR;}
sin {yylval.a=strdup(yytext); return SIN;}
cos {yylval.a=strdup(yytext); return COS;}
exp {yylval.a=strdup(yytext); return EXP;}

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