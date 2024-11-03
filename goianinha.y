%{
#include <stdio.h>
#include <stdlib.h>
#include "goianinha.h"

extern int yylineno;
extern int yylex();
void yyerror(const char *s);
%}

%token PROGRAMA CAR INT RETORNE LEIA ESCREVA NOVALINHA SE ENTAO SENAO ENQUANTO EXECUTE
%token INTCONST ID STRINGCONST EQ PLUS MINUS TIMES DIVIDE SEMICOLON COMMA LPAREN RPAREN
%token LBRACE RBRACE LESSTHAN MORETHAN ASSIGN OU E NEQ GE LE CARCONST FACT EQEQ

%start Programa

%%

Programa:
    DeclFuncVar DeclProg 

DeclFuncVar:
    Tipo ID DeclVar SEMICOLON DeclFuncVar 
    | Tipo ID DeclFunc DeclFuncVar 
    | %empty

DeclProg:
    PROGRAMA Bloco

DeclVar:
    COMMA ID DeclVar
    | %empty

DeclFunc:
    LPAREN ListaParametros RPAREN Bloco

ListaParametros:
    %empty 
    | ListaParametrosCont

ListaParametrosCont:
    Tipo ID
    | Tipo ID COMMA ListaParametrosCont

Bloco:
    LBRACE ListaDeclVar ListaComando RBRACE
    | LBRACE ListaDeclVar RBRACE

ListaDeclVar:
     %empty 
    | Tipo ID DeclVar SEMICOLON ListaDeclVar

Tipo:
    INT
    | CAR

ListaComando:
    Comando
    | Comando ListaComando

Comando:
    SEMICOLON
    | Expr SEMICOLON
    | RETORNE Expr SEMICOLON
    | LEIA LValueExpr SEMICOLON
    | ESCREVA Expr SEMICOLON
    | ESCREVA STRINGCONST SEMICOLON
    | NOVALINHA SEMICOLON
    | SE LPAREN Expr RPAREN ENTAO Comando
    | SE LPAREN Expr RPAREN ENTAO Comando SENAO Comando
    | ENQUANTO LPAREN Expr RPAREN EXECUTE Comando
    | Bloco

Expr:
    OrExpr
    | LValueExpr EQ Expr

OrExpr:
    OrExpr OU AndExpr
    | AndExpr

AndExpr:
    AndExpr E EqExpr
    | EqExpr

EqExpr:
    EqExpr EQEQ DesigExpr
    | EqExpr NEQ DesigExpr
    | DesigExpr

DesigExpr:
    DesigExpr LESSTHAN AddExpr
    | DesigExpr MORETHAN AddExpr
    | DesigExpr GE AddExpr
    | DesigExpr LE AddExpr
    | AddExpr

AddExpr:
    AddExpr PLUS MulExpr
    | AddExpr MINUS MulExpr
    | MulExpr

MulExpr:
    MulExpr TIMES UnExpr
    | MulExpr DIVIDE UnExpr
    | UnExpr

UnExpr:
    MINUS PrimExpr
    | FACT PrimExpr
    | PrimExpr

LValueExpr:
    ID

PrimExpr:
    ID LPAREN ListExpr RPAREN
    | ID LPAREN RPAREN
    | ID
    | CARCONST
    | INTCONST
    | LPAREN Expr RPAREN

ListExpr:
    Expr
    | ListExpr COMMA Expr

%%

void yyerror(const char *s) {
    fprintf(stderr, "ERRO: %s linha %d\n", s, yylineno);
}
