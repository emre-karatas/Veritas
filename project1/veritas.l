%option main

digit [0-9]
letter [a-zA-Z]
identifier_symbols (_|-)
comment ({letter}|{digit})*
identifier_rest  ({digit}|{letter}|{identifier_symbols})
line_comment \#\#(.)*\#\#
hash_array  hash_array
true true|{constant_true}
false false|{constant_false}
const_str  \"(.)*\"
boolean ({true}|{false})
type ({boolean}|{hash_array})
boolean_tag boolean
foreach foreach
in in
for for
while while
do do
constant_true (idil|selin|emre|altay|dilruba|7)
constant_false  (11|13|monday|lahana|matcha|cs223)
scan_input  scan_input
get_name get_name
display display
get_value get_value
get_function_name  get_function_name
primative_methods  ({scan_input}|{get_name}|{display}|{get_value}|{get_function_name})
identifier {letter}({identifier_rest})*
%%

{line_comment}  printf("COMMENT ");


\;               printf("SC ");
\,               printf("COMMA ");
\:               printf("COLON ");
\.               printf("DOT ");
\=               printf("ASSIGN_OP ");
\=\=              printf("EQUALITY_OP ");
\!\!              printf("NOT_EQUAL_OP ");
\&               printf("AND_OP ");
\|               printf("OR_OP ");
\[              printf("LEFT_BRACES ");
\]              printf("RIGHT_BRACES ");
\{              printf("LEFT_CURLY ");
\}              printf("RIGHT_CURLY ");
\(              printf("LEFT_PARENTHESIS ");
\)              printf("RIGHT_PARENTHESIS ");
\>               printf("GREATER ");
\<               printf("LESS ");
\<\=              printf("LESS_EQUAL ");
\>\=              printf("GREATER_EQUAL ");
\-\>            printf("IMPLICATION");
\<\-\>          printf("DOUBLE_IMPLICATION ");
start           printf("START ");
finish          printf("FINISH ");
return          printf("RETURN ");
if              printf("IF ");
else            printf("ELSE ");
{foreach} printf("FOR_EACH");
{in}  printf("IN");
{for} printf("FOR ");
{while} printf("WHILE ");
{do}    printf("DO ");
{hash_array}    printf("HASH_ARRAY ");
{boolean_tag}   printf("BOOLEAN ");
{scan_input}  printf("SCAN_INPUT ");
{get_name}   printf("GET_NAME ");
{display}     printf("DISPLAY ");
{get_value}    printf("GET_VALUE ");
{get_function_name}    printf("GET_FUNCTION_NAME ");
{const_str}   printf("STR ");
{true}    printf("TRUE ");
{false}   printf("FALSE ");
{identifier} printf("IDENTIFIER ");
[ \n\t] printf("%s", yytext);
. ;
