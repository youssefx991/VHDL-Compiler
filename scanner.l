
%{
 #include "y.tab.h"
 void yyerror(char* s);
 int yylex();
%}

%%

"entity"		return ENTITY;
"architecture"		return ARCHITECTURE;
"begin"			return T_BEGIN;
"end"			return END;
"is"			return IS;
"signal"		return SIGNAL;
"of"			return OF;
"bit" 			|
"std_logic" 		|
"integer" 		|
"real" 			|
"boolean" 		|
"NULL" 			{yylval.str = strdup(yytext); return TYPE;}
"<="			return OP_ASSIGN;

";"			return SEMICOLON;
":"			return COLON;

[_a-zA-Z][_a-zA-Z0-9]*	{yylval.str = strdup(yytext); return IDENTIFIER;}

[ \t\n]			;
.			{printf("unexpected character %s in line %d\n", yytext, yylineno); exit(1);}  
%%

int yywrap()
{
	return 1;
}

