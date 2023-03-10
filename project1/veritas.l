%option main

digit [0-9]
letter [a-zA-Z]
implication_op \-\>
double_implication_op \<\-\>
comment ({letter}|{digit})*
identifier_rest  ({digit}|{letter}|_)
line_comment \#\#(.)*\#\#
constant_true veritas
constant_false  falsus
true true|{constant_true}
false false|{constant_false}
const_str  \"(.)*\"
boolean ({true}|{false})
type ({boolean}|{hash_array})
tag ({boolean_tag} | {hash_array_tag} | {void_tag})
boolean_tag boolean
hash_array_tag HashArray
void_tag void
foreach foreach
in in
while while
do do
scan_input  scanInput
display display
print_hash printHash
add_to_hash addHash
delete_all_false deleteAllFalse
delete_all_true deleteAllTrue
all_true_hash allTrueHash
all_false_hash allFalseHash
is_empty isEmpty
identifier {letter}({identifier_rest})*
%%

{line_comment}  printf("COMMENT ");
{implication_op}            printf("IMPLICATION_OP ");
{double_implication_op}          printf("DOUBLE_IMPLICATION_OP ");
\;               printf("SC ");
\,               printf("COMMA ");
\:               printf("COLON ");
\.               printf("DOT ");
\=               printf("ASSIGN_OP ");
\=\=              printf("EQUALITY_OP ");
\!\!              printf("NOT_EQUAL_OP ");
\!             printf("NOT_OP ");
\&\&               printf("AND_OP ");
\|\|              printf("OR_OP ");
\[              printf("LEFT_BRACES ");
\]              printf("RIGHT_BRACES ");
\{              printf("LEFT_CURLY ");
\}              printf("RIGHT_CURLY ");
\(              printf("LEFT_PARENTHESIS ");
\)              printf("RIGHT_PARENTHESIS ");
start           printf("START ");
finish          printf("FINISH ");
return          printf("RETURN ");
if              printf("IF ");
else            printf("ELSE ");
const           printf("CONST  ");
{foreach} printf("FOR_EACH");
{in}  printf("IN");
{while} printf("WHILE ");
{do}    printf("DO ");
{hash_array_tag}   printf("HASH_ARRAY_TAG ");
{boolean_tag}   printf("BOOLEAN_TAG ");
{void_tag}        printf("VOID_TAG ");
{scan_input}           printf("SCAN_INPUT ");
{display}              printf("DISPLAY ");
{print_hash}           printf("PRINT_HASH ");
{add_to_hash}          printf("ADD_TO_HASH ");
{delete_all_false}     printf("DELETE_ALL_FALSE ");
{delete_all_true}      printf("DELETE_ALL_TRUE ");
{all_true_hash}        printf("ALL_TRUE_HASH ");
{all_false_hash}       printf("ALL_FALSE_HASH ");
{is_empty}             printf("IS_EMPTY ");
{const_str}   printf("STR ");
{true}    printf("TRUE ");
{false}   printf("FALSE ");
{identifier} printf("IDENTIFIER ");
[ \n\t] printf("%s", yytext);
. ;
