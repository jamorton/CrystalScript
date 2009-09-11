

grammar CrystalScript;

options {
	language=Java;
	output=AST;
}


/*
fragment UnicodeEscape:
    HexDigit HexDigit HexDigit HexDigit;

fragment HexEscape:
    HexDigit HexDigit;

fragment EscapeSequence:
    'u' UnicodeEscape |
    'x' HexEscape     |
    'n' | 'r' | 'v' | 'b' | 't' | '\\';
    

fragment StringItem : ('\\' EscapeSequence |
                       '\u0000'..'\u005B'  |
                       '\u005D'..'\uFFFF');

String : ('"' StringItem '"' | '\'' StringItem '\'')  { greedy=false; };
*/


//============================ LEXER RULES ============================


WS : (' '|'\t'|'\f')+{ skip(); };


NEWLINE: ('\r'? '\n')+ {skip();};

SINGLE_COMMENT: '//' ~('\r' | '\n')* NEWLINE { skip(); };

MULTI_COMMENT options { greedy = false; }
  : '###' .* '###' NEWLINE? { skip(); };



fragment Letter   : 'A'..'Z' | 'a'..'z';
fragment Digit    : '0'..'9';
fragment HexDigit : Digit | 'A'..'F' | 'a'..'f';

fragment NumberExponent : ('e' | 'E') ('+' | '-')? Digit+;
fragment DecimalNumber  : ('+' | '-')? Digit+ ('.' Digit+)? NumberExponent?;
fragment HexNumber      : ('+' | '-')? '0x' HexDigit+;

Number : DecimalNumber | HexNumber;



fragment IdStart : (Letter | '_' | '$');
Identifier       : (IdStart) (IdStart | Digit)*;







//============================ PARSER RULES ============================

functionCall      : Identifier '(' expression? (',' expression)* ')';

expression            : comparisonExpression;
comparisonExpression  : andExpression (('==' | '<=' | '>=' | '<' | '>' | '!=') andExpression)*;
andExpression         : orExpression  ('and' orExpression)*;
orExpression          : addvExpression ('or'  addvExpression)*;
addvExpression        : multExpression (('+' | '-') multExpression)*;
multExpression        : postfixExpression (('/' | '*' | '%') postfixExpression)*;
postfixExpression     : prefixExpression ('++' | '--')*;
prefixExpression      : ('++' | '--')* unaryExpression;
unaryExpression       : ('!' | '-' | '+')* atom;
atom                  : Identifier | functionCall | '(' expression ')';


block          : statement+;
last_statement : 'return' expression? | 'break';

statement
	: assignStmt
	| functionCall
	| loopStmt
	| ifStmt
	| breakStmt
	| continueStmt
	| returnStmt
	;

breakStmt    : 'break';
continueStmt : 'continue';
returnStmt   : 'return';

assignStmt : Identifier '=' expression;
ifStmt: 'if' expression block 'end';
loopStmt: 'loop' ('while' expression)? block 'end';








