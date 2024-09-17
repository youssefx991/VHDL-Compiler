#include <stdio.h>
#include "y.tab.h"

extern int yyparse();
extern int yylex();
extern int yylineno;
extern char* yytext;

char* names[] = {NULL, "ENTITY", "IS", "END", "SEMICOLON", "ARCHITECTURE", "OF", "SIGNAL", "COLON", "BEGIN", "Assignment operator", "IDENTIFIER", "TYPE"};


int scanner_main(void)
{
	int ntoken, vtoken;
	while (ntoken = yylex())
	{
		int value = ntoken;
		if (value == ENTITY || value == ARCHITECTURE || value == SIGNAL || value == OP_ASSIGN)
		{
			vtoken = yylex();
			if (vtoken != IDENTIFIER)
			{
				printf(" Invalid Identifier %s in line %d\n", yytext, yylineno);
				return 1;
			}
		}

	}

	return yyparse();
}
