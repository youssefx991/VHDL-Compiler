#include <stdio.h>
#include "scanner.h"

extern int yylex();
extern int yylineno;
extern char* yytext;

const char* token_names[] = {
        "",            // 0 (not used)
        "ENTITY",      // 1
        "ARCHITECTURE",// 2
        "BEGIN",       // 3
        "END",         // 4
        "IS",          // 5
        "SIGNAL",      // 6
        "PROCESS",     // 7
        "SEMICOLON",   // 8
        "OF",          // 9
        "COLON",       // 10
        "OP_Assig",    // 11
        "TYPE",        // 12
        "IDENTIFIER",  // 13
        "NUMBER"       // 14
};


int main(void)
{
	int ntoken;

	while(ntoken = yylex())
	{
		printf("%s ", token_names[ntoken]);
	}
	printf("\n");
	return 0;
}
