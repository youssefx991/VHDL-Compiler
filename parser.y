%{
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <ctype.h>

 typedef struct {
 	char* name;
	char* type;
 } Signal;

 Signal signals[100];
 int signal_count = 0;
 char* entity_name = NULL;

 void yyerror(char* s);
 int yylex();
 int is_valid_identifier(char* identifier);
 int is_signal_exist(char* signal_name);
 void handle_assignment(char* lhs, char* rhs);
%}


%union {char* str;}

%start program

%token ENTITY IS END SEMICOLON ARCHITECTURE OF SIGNAL COLON T_BEGIN OP_ASSIGN
%token <str> IDENTIFIER TYPE


%%

program : entity_statement architecture_statement  program { printf("Program pair Parsed Successfully\n"); }
	| /* empty pair */		          //{ printf("Empty program pair parsed successfully\n"); }
	;

entity_statement : ENTITY IDENTIFIER IS END SEMICOLON {
		 	if (! is_valid_identifier($2))
			{
				fprintf(stderr, "Error: Ivalid Identifier %s\n", $2);	
				exit(1);
			}
			
		 	entity_name = strdup($2);
			//printf("Entity : %s\n", $2);
		 }
		 ;

architecture_statement : ARCHITECTURE IDENTIFIER OF IDENTIFIER IS signal_declaration T_BEGIN signal_statement END SEMICOLON
{
	if (strcmp(entity_name, $4) != 0)
	{
		fprintf(stderr, "Error: %s does not match the declared entity name %s\n", $4, entity_name);
		exit(1);
	}
	
	if (! is_valid_identifier($2))
	{
		fprintf(stderr, "Error: Ivalid Identifier %s\n", $2);
		exit(1);
	}
	
	//printf("Architecture : %s\n", $2);
	
}
;

signal_declaration : /* Empty Signal */  //{printf("Empty signal decl\n");}

		   | SIGNAL IDENTIFIER COLON TYPE SEMICOLON signal_declaration
		   {
			if (! is_valid_identifier($2))
                        {
                                fprintf(stderr, "Error: Ivalid Identifier %s\n", $2);
                                exit(1);
                        }
			if (is_signal_exist($2))
                        {
                                fprintf(stderr, "Error: Signal %s Already exists\n", $2);
                                exit(1);
                        }

			signals[signal_count].name = strdup($2);
			signals[signal_count].type = strdup($4);
			signal_count++;

			//printf("Signal : %s of type %s\n", $2, $4);

		   }
;



signal_statement : /* empty statement */ | assignment_statement
		 ;

assignment_statement : IDENTIFIER OP_ASSIGN IDENTIFIER SEMICOLON assignment_statement{
		     	handle_assignment($1, $3);
		     }
		     |

		     /*empty*/
		     ;





%%

void yyerror(char* s)
{
	fprintf(stderr, "Error: %s\n", s);
}

int is_valid_identifier(char* identifier)
{
	char first_char = identifier[0];
	if (isalpha(first_char) || first_char == '_' || (first_char >= 'A' && first_char <= 'z'))
		return 1;
	else			// not valid identifier
		return 0;
}

int is_signal_exist(char* signal)
{
	for (int i=0; i<signal_count; i++)
	{
		if (strcmp(signal, signals[i].name) == 0)
			return 1;
	}

	return 0;
}
void handle_assignment(char* lhs, char* rhs)
{
	char* lhs_type = NULL;
	char* rhs_type = NULL;

	for (int i=0; i<signal_count; i++)
	{
		if (strcmp(signals[i].name, lhs) == 0)
			lhs_type = signals[i].type;
		if (strcmp(signals[i].name, rhs) == 0)
			rhs_type = signals[i].type;
		
		if (lhs_type != NULL && rhs_type != NULL)
			break;
	}

	if (lhs_type == NULL)
	{
		fprintf(stderr, "Error: Unknown Signal %s\n", lhs);
		exit(1);
	}

	if (rhs_type == NULL)
	{
		fprintf(stderr, "Error: Unknown Signal %s\n", rhs);
		exit(1);
	}

	if (strcmp(lhs_type, rhs_type) != 0)
	{
		fprintf(stderr, "Signal types don't match in assignment. LHS type %s, RHS type %s\n", lhs_type, rhs_type);
		exit(1);
	}

	//printf("Assignment: %s <= %s\n", lhs, rhs);
}

int main(void)
{
	return yyparse();
}

