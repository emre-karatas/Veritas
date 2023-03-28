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
%token ELSE
%token CONST
%token FOR_EACH

%%




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
