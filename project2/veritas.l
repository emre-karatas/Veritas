digit [0-9]
letter [a-zA-Z]
implication_op \-\>
double_implication_op \<\-\>
identifier_rest  ({digit}|{letter}|_)
line_comment \#\#(.)*\#\#
true true|{constant_true}
false false|{constant_false}
const_str  \"(.)*\"
boolean ({true}|{false})
data_type ({boolean}|{hash_array})
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

%option yylineno
%%

{line_comment}  return COMMENT;
{implication_op}            return IMPLICATION_OP;
{double_implication_op}          return DOUBLE_IMPLICATION_OP;
\;              return SC;
\,              return COMMA;
\:              return COLON;
\.              return DOT;
\=              return ASSIGN_OP;
\=\=            return EQUALITY_OP;
\!\!            return NOT_EQUAL_OP;
\!              return NOT_OP;
\&\&            return AND_OP;
\|\|            return OR_OP;
\[              return LEFT_BRACES;
\]              return RIGHT_BRACES;
\{              return LEFT_CURLY;
\}              return RIGHT_CURLY;
\(              return LEFT_PARENTHESIS;
\)              return RIGHT_PARENTHESIS;
start           return START;
finish          return FINISH;
return          return RETURN;
if              return IF;
else            return ELSE;
const           return CONST;
{foreach} return FOR_EACH  ;
{in}  return IN;
{while} return WHILE;
{do}    return DO;
{hash_array_tag}   return HASH_ARRAY_TAG;
{boolean_tag}   return BOOLEAN_TAG;
{void_tag}        return VOID_TAG;
{scan_input}           return SCAN_INPUT;
{display}              return DISPLAY;
{print_hash}           return PRINT_HASH;
{add_to_hash}          return ADD_TO_HASH;
{delete_all_false}     return DELETE_ALL_FALSE;
{delete_all_true}      return DELETE_ALL_TRUE;
{all_true_hash}        return ALL_TRUE_HASH;
{all_false_hash}       return ALL_FALSE_HASH;
{is_empty}             return IS_EMPTY;
{const_str}   return STR;
{true}    return TRUE;
{false}   return FALSE;
{identifier} return IDENTIFIER;

%%
int yywrap(void){
	return 1;
}
