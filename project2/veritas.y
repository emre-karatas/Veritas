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

%%

program:
    START stmt_list FINISH


    stmt_list:
        stmt SC |
        stmt SC stmt_list

    stmt:
        matched | unmatched

    matched:
        IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES ELSE LEFT_BRACES matched RIGHT_BRACES
        | IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES else_if_stmts
        | IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES else_if_stmts ELSE LEFT_BRACES matched RIGHT_BRACES
        | non_if_statement


    else_if_stmts: else_if_stmt | else_if_stmt else_if_stmts
    else_if_stmt: ELSEIF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES

    unmatched: IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES stmt RIGHT_BRACES
                | IF LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES matched RIGHT_BRACES ELSE unmatched RIGHT_BRACES
    
    non_if_statement: non_if_expression | non_if_expression SC non_if_statement

    non_if_expression: assign_stmt | declaration_stmt | operation | loop_stmt | method_declare | method_call | COMMENT

    assign_stmt: IDENTIFIER ASSIGN_OP IDENTIFIER 
                | IDENTIFIER ASSIGN_OP method_call
                | IDENTIFIER ASSIGN_OP operation
                | IDENTIFIER ASSIGN_OP data_type
    
    data_type: hash_array | boolean
    
    boolean: TRUE | FALSE

    declaration_stmt: declaration | declaration_assign | hash_array_declaration

    declaration: TAG identifier_list

    declaration_assign: TAG assign_stmt | CONST TAG identifier_list

    identifier_list: 
        IDENTIFIER SC 
        | IDENTIFIER COMMA identifier_list

    operation: 
        basic_operation 
        | LEFT_PARENTHESIS operation RIGHT_PARENTHESIS

    identifier_combinations: 
        IDENTIFIER 
        | basic_operation 

    basic_operation : 
        logical_operation 
        | LEFT_PARENTHESIS basic_operation RIGHT_PARENTHESIS

    logical_operation : 
        identifier_combinations DOUBLE_IMPLICATION_OP identifier_combinations 
        | logical_operation2

    logical_operation2 : 
        identifier_combinations IMPLICATION_OP identifier_combinations 
        | logical_operation3

    logical_operation3 : 
        identifier_combinations OR_OP identifier_combinations 
        | logical_operation4

    logical_operation4 : 
        identifier_combinations AND_OP identifier_combinations 
        | logical_operation5

    logical_operation5 : 
        identifier_combinations equality_check identifier_combinations 
        | logical_operation6

    logical_operation6: 
        NOT_OP identifier_combinations 
        | logical_operations7

    logical_operations7: 
        LEFT_PARENTHESIS basic_operation RIGHT_PARENTHESIS

    equality_check: 
        EQUALITY_OP 
        | NOT_EQUAL_OP

    implication: 
        identifier_combinations IMPLICATION_OP identifier_combinations

    double_implication: 
        identifier_combinations DOUBLE_IMPLICATION_OP identifier_combinations

    loop_stmt : 
        while_loop 
        | for_loop

    while_loop: 
        WHILE LEFT_PARENTHESIS operation RIGHT_PARENTHESIS LEFT_BRACES stmt RIGHT_BRACES
        | DO LEFT_BRACES stmt RIGHT_BRACES WHILE LEFT_PARENTHESIS operation RIGHT_PARENTHESIS SC

    for_loop: 
        FOR_EACH IDENTIFIER IN IDENTIFIER LEFT_BRACES stmt RIGHT_BRACES
        | IDENTIFIER IN hash_array LEFT_BRACES stmt RIGHT_BRACES

    method_declare: 
        return_type IDENTIFIER LEFT_PARENTHESIS parameter_list RIGHT_PARENTHESIS LEFT_BRACES stmt RETURN return_stmt RIGHT_BRACES

    parameter_list: 
        parameter 
        | parameter COMMA parameter_list
        | IS_EMPTY

    parameter: TAG IDENTIFIER

    method_call: 
        IDENTIFIER LEFT_PARENTHESIS parameter_identifier RIGHT_PARENTHESIS SC
        | IDENTIFIER LEFT_PARENTHESIS IS_EMPTY RIGHT_PARENTHESIS SC

    parameter_identifier: 
        IDENTIFIER 
        | IDENTIFIER COMMA parameter_identifier



comment:
        COMMENT
hash_array_declaration:
        HASH_ARRAY_TAG identifier equality_op hash_array
        | HASH_ARRAY_TAG identifier equality_op method_call
hash_array:
        left_curly item_list right_curly
item_list:
        item
        | item comma item_list
item:
        identifier
        | boolean!!!! boolean tokenla nonterminalla ayni olmasi sikinti yaratabilir
        | empty!!!!!
        
primitive_methods:
        scan_input
        | display
        | print_hash
        | get_name
        | get_function_name
        | add_to_hash
        | delete_all_false
        | delete_all_true
        | all_true_hash
        | all_false_hash
        | is_empty
        
scan_input:
        SCAN_INPUT left_paranthesis io_str right_paranthesis
        
display:
        DISPLAY left_paranthesis output right_paranthesis
output:
        io_str
        | identifier
        | boolean
print_hash:
        PRINT_HASH left_paranthesis identifier right_paranthesis
        | PRINT_HASH left_paranthesis hash_array right_paranthesis
add_to_hash:
        identifier DOT ADD_TO_HASH left_paranthesis identifier right_paranthesis
        | identifier DOT ADD_TO_HASH left_paranthesis boolean right_paranthesis
delete_all_false:
        identifier DOT DELETE_ALL_FALSE left_paranthesis right_paranthesis
delete_all_true:
        identifier DOT DELETE_ALL_TRUE left_paranthesis right_paranthesis
all_true_hash:
        identifier DOT ALL_TRUE_HASH left_paranthesis right_paranthesis
all_false_hash:
        identifier DOT ALL_FALSE_HASH left_paranthesis right_paranthesis
is_empty:
        identifier DOT IS_EMPTY left_paranthesis right_paranthesis
start:
        START
finish:
        FINISH
sc:
        SC
comma:
        COMMA
assign_op:
        ASSIGN_OP
equality_op:
        EQUALITY_OP
not_equal_op:
        NOT_EQUAL_OP
not_operation:
        NOT_OP
and:
        AND_OP
or:
        OR_OP
left_braces:
        LEFT_BRACES
right_braces:
        RIGHT_BRACES
left_curly:
        LEFT_CURLY
right_curly:
        RIGHT_CURLY
left_paranthesis:
        LEFT_PARENTHESIS
righ_paranthesis
        RIGHT_PARENTHESIS
empty:

data_type:
    BOOLEAN_TAG
    | HASH_ARRAY_TAG
implication_single_symbol:
        IMPLICATION_OP

implication_double_symbol:
        DOUBLE_IMPLICATION_OP
identifier:
        IDENTIFIER
io_str:
    STR
return_type:
        VOID_TAG
        | BOOLEAN_TAG
        | hash_array
return:
        RETURN
return_stmt:
        identifier
        | BOOLEAN_TAG
        | method_call
        | operation
        | hash_array
        
%%
