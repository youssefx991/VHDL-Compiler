
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
"type"			{yylval.str = yytext; return TYPE;}
"<="			return OP_ASSIGN;

";"			return SEMICOLON;
":"			return COLON;

[_a-zA-Z][_a-zA-Z0-9]*	{yylval.str = yytext; return IDENTIFIER;}

[ \t\n]			;

.			{ECHO; yyerror("unexpected cahracter"); }
%%

int yywrap()
{
	return 1;
}

