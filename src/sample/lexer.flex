package scanner;
import java_cup.runtime.Symbol;
%%
%cup
%public
%class Lexer
%line
%column
%type java_cup.runtime.Symbol

Number			= \d+

%%
"+"								{ imprimir("PLUS", yytext()); }
"-"								{ imprimir("MINUS", yytext()); }
"*"								{ imprimir("TIMES", yytext()); }
"/"								{ imprimir("DIV", yytext()); }
{Number}           				{ imprimir("NUMBER", yytext()); }
<<EOF>> 							{ imprimir(".EOF ", yytext()); }
[^] 								{ throw new Error("Illegal character: "+yytext()+" at line "+(yyline+1)+", column "+(yycolumn+1) ); }