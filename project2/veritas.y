%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token IMPLICATION_OP
%token DOUBLE_IMPLICATION_OP
%token COMMENT
%token TRUE
%token FALSE
%token STR
%token BOOLEAN_TAG
%token HASH_ARRAY_TAG
%token VOID_TAG
%token IN
%token WHILE
%token DO
%token SCAN_INPUT
%token DISPLAY
%token PRINT_HASH
%token ADD_TO_HASH
%token DELETE_ALL_FALSE
%token DELETE_ALL_TRUE
%token ALL_TRUE_HASH
%token ALL_FALSE_HASH
%token IS_EMPTY
%token IDENTIFIER
%token SC
%token COMMA
%token COLON
%token DOT
%token ASSIGN_OP
%token EQUALITY_OP
%token NOT_EQUAL_OP
%token NOT_OP
%token AND_OP
%token OR_OP
%token LEFT_BRACES
%token RIGHT_BRACES
%token LEFT_CURLY
%token RIGHT_CURLY
%token LEFT_PARENTHESIS
%token RIGHT_PARENTHESIS
%token START
%token FINISH
%token RETURN
%token IF
%token ELSEIF
%token ELSE
%token CONST
%token FOR_EACH

%start program

%%

program:START stmt_list FINISH;


    stmt_list:
        stmt |
        stmt stmt_list |
        COMMENT |
        COMMENT stmt_list |
        error SC {yyerrok;}

    stmt:
        matched | unmatched

    matched:
        IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES ELSE LEFT_BRACES matched RIGHT_BRACES
        | IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES else_if_stmts
        | IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES else_if_stmts ELSE LEFT_BRACES matched RIGHT_BRACES
        | non_if_statement 


    else_if_stmts: else_if_stmt | else_if_stmt else_if_stmts
    else_if_stmt: ELSEIF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES



    unmatched: IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES
        |IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES unmatched RIGHT_BRACES
        |IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES  ELSE LEFT_BRACES unmatched RIGHT_BRACES
    
    non_if_statement: expression SC | method_declare  | loop_stmt 

    expression: assign_stmt  | declaration_stmt | operation | empty
    
    assign_stmt:  IDENTIFIER ASSIGN_OP operation
                | IDENTIFIER ASSIGN_OP data_type 
    
    boolean: TRUE | FALSE
    
    declaration_stmt: declaration | declaration_assign | hash_array_declaration

    declaration: BOOLEAN_TAG identifier_list

    declaration_assign: BOOLEAN_TAG assign_stmt | CONST BOOLEAN_TAG assign_stmt

    identifier_list: 
        IDENTIFIER 
        | IDENTIFIER COMMA identifier_list

   operation: 
        logical_operation 
        | NOT_OP logical_operation



    logical_operation : 
        logical_operation DOUBLE_IMPLICATION_OP logical_operation2 
        | logical_operation2

    logical_operation2 : 
        logical_operation2 IMPLICATION_OP logical_operation3 
        | logical_operation3

    logical_operation3 : 
        logical_operation3 OR_OP logical_operation4 
        | logical_operation4

    logical_operation4 : 
        logical_operation4 AND_OP logical_operation5 
        | logical_operation5

    logical_operation5 : 
        logical_operation5 equality_check logical_operation6 
        | logical_operation5 equality_check boolean
        | logical_operation6

    logical_operation6: 
        variable_combo |
        LEFT_PARENTHESIS operation RIGHT_PARENTHESIS

    equality_check: 
        EQUALITY_OP 
        | NOT_EQUAL_OP

    variable_combo: IDENTIFIER | method_call | primitive_methods


    loop_stmt : 
        while_loop 
        | for_loop

    while_loop: 
        WHILE LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES stmt_list RIGHT_BRACES
        | DO LEFT_BRACES stmt_list RIGHT_BRACES WHILE LEFT_PARENTHESIS operation RIGHT_PARENTHESIS

    for_loop: 
        FOR_EACH IDENTIFIER IN IDENTIFIER LEFT_BRACES stmt_list RIGHT_BRACES
        |FOR_EACH IDENTIFIER IN hash_array LEFT_BRACES stmt_list RIGHT_BRACES

    method_declare: 
        VOID_TAG IDENTIFIER LEFT_PARENTHESIS parameter_list RIGHT_PARENTHESIS LEFT_BRACES stmt_list RIGHT_BRACES
        | VOID_TAG IDENTIFIER LEFT_PARENTHESIS empty RIGHT_PARENTHESIS LEFT_BRACES stmt_list  RIGHT_BRACES
        | BOOLEAN_TAG IDENTIFIER LEFT_PARENTHESIS parameter_list RIGHT_PARENTHESIS LEFT_BRACES stmt_list RETURN return_stmt RIGHT_BRACES
        | BOOLEAN_TAG IDENTIFIER LEFT_PARENTHESIS empty RIGHT_PARENTHESIS LEFT_BRACES stmt_list RETURN return_stmt RIGHT_BRACES
        | HASH_ARRAY_TAG IDENTIFIER LEFT_PARENTHESIS parameter_list RIGHT_PARENTHESIS LEFT_BRACES stmt_list RETURN return_stmt RIGHT_BRACES
        | HASH_ARRAY_TAG IDENTIFIER LEFT_PARENTHESIS empty RIGHT_PARENTHESIS LEFT_BRACES stmt_list RETURN return_stmt RIGHT_BRACES
    parameter_list: 
        parameter 
        | parameter COMMA parameter_list

    
    parameter: BOOLEAN_TAG IDENTIFIER |
               HASH_ARRAY_TAG IDENTIFIER

    method_call: 
        IDENTIFIER LEFT_PARENTHESIS parameter_identifier RIGHT_PARENTHESIS
        | IDENTIFIER LEFT_PARENTHESIS empty RIGHT_PARENTHESIS

    parameter_identifier: 
        IDENTIFIER 
	| boolean
	| boolean COMMA parameter_identifier
        | IDENTIFIER COMMA parameter_identifier

	
    hash_array_declaration:
            HASH_ARRAY_TAG IDENTIFIER ASSIGN_OP hash_array
            | HASH_ARRAY_TAG IDENTIFIER ASSIGN_OP method_call
    hash_array:
            LEFT_CURLY item_list RIGHT_CURLY
    item_list:
            item
            | item COMMA item_list
    item:
            IDENTIFIER
            | boolean
            | empty
            
    primitive_methods:
            scan_input
            | display
            | print_hash
            | add_to_hash
            | delete_all_false
            | delete_all_true
            | all_true_hash
            | all_false_hash
            | is_empty
            
    scan_input:
            SCAN_INPUT LEFT_PARENTHESIS STR RIGHT_PARENTHESIS
            
    display:
            DISPLAY LEFT_PARENTHESIS output RIGHT_PARENTHESIS
    output:
            STR
            | IDENTIFIER
            | boolean
    print_hash:
            PRINT_HASH LEFT_PARENTHESIS IDENTIFIER RIGHT_PARENTHESIS
            | PRINT_HASH LEFT_PARENTHESIS hash_array RIGHT_PARENTHESIS
    add_to_hash:
            IDENTIFIER DOT ADD_TO_HASH LEFT_PARENTHESIS IDENTIFIER RIGHT_PARENTHESIS
            | IDENTIFIER DOT ADD_TO_HASH LEFT_PARENTHESIS BOOLEAN_TAG RIGHT_PARENTHESIS
    delete_all_false:
            IDENTIFIER DOT DELETE_ALL_FALSE LEFT_PARENTHESIS RIGHT_PARENTHESIS
    delete_all_true:
            IDENTIFIER DOT DELETE_ALL_TRUE LEFT_PARENTHESIS RIGHT_PARENTHESIS
    all_true_hash:
            IDENTIFIER DOT ALL_TRUE_HASH LEFT_PARENTHESIS RIGHT_PARENTHESIS
    all_false_hash:
            IDENTIFIER DOT ALL_FALSE_HASH LEFT_PARENTHESIS RIGHT_PARENTHESIS
    is_empty:
            IDENTIFIER DOT IS_EMPTY LEFT_PARENTHESIS RIGHT_PARENTHESIS


    empty:

    data_type:
            hash_array| boolean
      
    return_stmt:
             boolean
            | operation
            | hash_array

        

%%
bool error = false;
void yyerror(char *s) {
  error = true;
	  printf("\n%s on line %d\n", s, yylineno);
}

int main(void){
     yyparse();
     if (error == false) {
        printf("Input program is valid\n");
        return 0;
    }
    else {
        return 1;
    }
}
