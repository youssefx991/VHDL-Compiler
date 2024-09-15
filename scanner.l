%{
 #include "scanner.h"
%}

%%

"entity"		return ENTITY;
"architecture"		return ARCHITECTURE;
"begin"			return T_BEGIN;
"end"			return END;
"is"			return IS;
"signal"		return SIGNAL;
"process"		return PROCESS;
"of"			return OF;

"<="			return OP_ASSIGN;

";"			return SEMICOLON;
":"			return COLON;

[_a-zA-Z][_a-zA-Z0-9]*	return IDENTIFIER;
[1-9][0-9]*		return NUMBER;

[ \t\n]			;

%%

int yywrap()
{
	return 1;
}
