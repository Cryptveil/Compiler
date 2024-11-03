#include <stdio.h>

extern FILE *yyin;
extern int yylineno;
extern int yyparse();

int main(int argc, char **argv) {
    if (argc < 2) {
        printf("Usage: %s <source_file>\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("Could not open file: %s\n", argv[1]);
        return 1;
    }

    yylineno = 1;
    printf("Starting parse...\n");

    int result = yyparse();
    printf("Parse complete with result: %d\n", result);

    if (result == 0) {
        printf("Análise sintática concluída com sucesso.\n");
    } else {
        printf("Erro(s) encontrado(s) durante a análise sintática.\n");
    }

    fclose(yyin);
    return 0;
}
