%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "goianinha.h"

extern int yylineno;  
%}

%%

"programa"             { return PROGRAMA; }
"car"                  { return CAR; }
"int"                  { return INT; }
"retorne"              { return RETORNE; }
"leia"                 { return LEIA; }
"escreva"              { return ESCREVA; }
"novalinha"            { return NOVALINHA; }
"se"                   { return SE; }
"entao"                { return ENTAO; }
"senao"                { return SENAO; }
"enquanto"             { return ENQUANTO; }
"execute"              { return EXECUTE; }

"=="                   { return EQEQ; }
"="                    { return EQ; }
"+"                    { return PLUS; }
"-"                    { return MINUS; }
"*"                    { return TIMES; }
"/"                    { return DIVIDE; }
"<"                    { return LESSTHAN; }
">"                    { return MORETHAN; }

";"                    { return SEMICOLON; }
","                    { return COMMA; }
"("                    { return LPAREN; }
")"                    { return RPAREN; }
"{"                    { return LBRACE; }
"}"                    { return RBRACE; }
"!"                    { return FACT; }

\"[^"\n]*\"            { return STRINGCONST; }
\"[^"\n]*              { printf("ERRO: CADEIA NÃO TERMINA linha %d\n", yylineno); }

[0-9]+                 { return INTCONST; }

[a-zA-Z_][a-zA-Z0-9_]* { return ID; }

[ \t]+                 { /* Ignora espaços e tabulações */ }

\n                     { yylineno; }

\/\*([^*]|\*[^/])*\*\/ { /* Ignora comentários */ }

.                      { printf("ERRO: CARACTERE INVÁLIDO linha %d\n", yylineno); }

%%

int yywrap(void) {
    return 1;
}
