package lua;
import java_cup.runtime.Symbol;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
%%
%public
%class Lexer
%cup
%char
%line
%column

%state STRING
%state BLOCK_COMMENT

%{
	StringBuffer string = new StringBuffer();
%}

Name			= [\w_][\w]*
Integer			= \d+
Float 			= \d+(\.\d+){0,1}(e[+-]{0,1}\d+){0,1}
StringInit		= \"|\'
Ignore 			= [\n|\s|\t\r]
CommentLine 	= --.*\n
CommentBlockInit	= --\[\[\n
Function 		= print|type

%%
<YYINITIAL>{
	{CommentBlockInit}				{ string.setLength(0); string.append("--[[\n"); yybegin(BLOCK_COMMENT); }
	{CommentLine}					{ System.out.println(yytext() + "\t,COMMENT"); }
	";"								{ System.out.println(yytext() + "\t,SEMICOLON"); return new Symbol(Sym.SEMICOLON); }
	"="								{ System.out.println(yytext() + "\t,EQUAL"); return new Symbol(Sym.EQUAL); }
	"do"							{ System.out.println(yytext() + "\t,DO"); return new Symbol(Sym.DO); }
	"end"							{ System.out.println(yytext() + "\t,END"); return new Symbol(Sym.END); }
	"while"							{ System.out.println(yytext() + "\t,WHILE"); return new Symbol(Sym.WHILE); }
	"repeat"						{ System.out.println(yytext() + "\t,REPEAT"); return new Symbol(Sym.REPEAT); }
	"until"							{ System.out.println(yytext() + "\t,UNTIL"); return new Symbol(Sym.UNTIL); }
	"if"							{ System.out.println(yytext() + "\t,IF"); return new Symbol(Sym.IF); }
	"then"							{ System.out.println(yytext() + "\t,THEN"); return new Symbol(Sym.THEN); }
	"elseif"						{ System.out.println(yytext() + "\t,ELSEIF"); return new Symbol(Sym.ELSEIF); }
	"else"							{ System.out.println(yytext() + "\t,ELSE"); return new Symbol(Sym.ELSE); }
	"for"							{ System.out.println(yytext() + "\t,FOR"); return new Symbol(Sym.FOR); }
	","								{ System.out.println(yytext() + "\t,COMMA"); return new Symbol(Sym.COMMA); }
	"in"							{ System.out.println(yytext() + "\t,IN"); return new Symbol(Sym.IN); }
	{Function}						{ System.out.println(yytext() + "\t,FUNCTION"); return new Symbol(Sym.FUNCTION); }
	"local"							{ System.out.println(yytext() + "\t,LOCAL"); return new Symbol(Sym.LOCAL); }
	"return"						{ System.out.println(yytext() + "\t,RETURN"); return new Symbol(Sym.RETURN); }
	"break"							{ System.out.println(yytext() + "\t,BREAK"); return new Symbol(Sym.BREAK); }
	"."								{ System.out.println(yytext() + "\t,DOT"); return new Symbol(Sym.DOT); }
	":"								{ System.out.println(yytext() + "\t,COLON"); return new Symbol(Sym.COLON); }
	"nil"							{ System.out.println(yytext() + "\t,NIL"); return new Symbol(Sym.NIL); }
	"false"							{ System.out.println(yytext() + "\t,FALSE"); return new Symbol(Sym.FALSE); }
	"true"							{ System.out.println(yytext() + "\t,TRUE"); return new Symbol(Sym.TRUE); }

	"..."							{ System.out.println(yytext() + "\t,THREE_DOTS"); return new Symbol(Sym.THREE_DOTS); }
	"("								{ System.out.println(yytext() + "\t,L_PARENTHESIS"); return new Symbol(Sym.L_PARENTHESIS); }
	")"								{ System.out.println(yytext() + "\t,R_PARENTHESIS"); return new Symbol(Sym.R_PARENTHESIS); }
	"{"								{ System.out.println(yytext() + "\t,L_BRACES"); return new Symbol(Sym.L_BRACES); }
	"}"								{ System.out.println(yytext() + "\t,R_BRACES"); return new Symbol(Sym.R_BRACES); }
	"["								{ System.out.println(yytext() + "\t,L_BRACKETS"); return new Symbol(Sym.L_BRACKETS); }
	"]"								{ System.out.println(yytext() + "\t,R_BRACKETS"); return new Symbol(Sym.R_BRACKETS); }
	"+"								{ System.out.println(yytext() + "\t,PLUS"); return new Symbol(Sym.PLUS); }
	"-"								{ System.out.println(yytext() + "\t,MINUS"); return new Symbol(Sym.MINUS); }
	"*"								{ System.out.println(yytext() + "\t,TIMES"); return new Symbol(Sym.TIMES); }
	"/"								{ System.out.println(yytext() + "\t,DIV"); return new Symbol(Sym.DIV); }
	"^"								{ System.out.println(yytext() + "\t,EXP"); return new Symbol(Sym.EXP); }
	"%"								{ System.out.println(yytext() + "\t,MOD"); return new Symbol(Sym.MOD); }
	".."							{ System.out.println(yytext() + "\t,TWO_DOTS"); return new Symbol(Sym.TWO_DOTS); }
	"<"								{ System.out.println(yytext() + "\t,SMALLER_THAN"); return new Symbol(Sym.SMALLER_THAN); }
	"<="							{ System.out.println(yytext() + "\t,SMALLER_THAN_OR_EQUAL"); return new Symbol(Sym.SMALLER_THAN_OR_EQUAL); }
	">"								{ System.out.println(yytext() + "\t,GREATER_THAN"); return new Symbol(Sym.GREATER_THAN); }
	">="							{ System.out.println(yytext() + "\t,GREATER_THAN_OR_EQUAL"); return new Symbol(Sym.GREATER_THAN_OR_EQUAL); }
	"=="							{ System.out.println(yytext() + "\t,EQUAL_EQUAL"); return new Symbol(Sym.EQUAL_EQUAL); }
	"~="							{ System.out.println(yytext() + "\t,APROX"); return new Symbol(Sym.APROX); }
	"and"							{ System.out.println(yytext() + "\t,AND"); return new Symbol(Sym.AND); }
	"or"							{ System.out.println(yytext() + "\t,OR"); return new Symbol(Sym.OR); }

	"not"							{ System.out.println(yytext() + "\t,NOT"); return new Symbol(Sym.NOT); }
	"#"								{ System.out.println(yytext() + "\t,HASHTAG"); return new Symbol(Sym.HASHTAG); }
	{StringInit}					{ string.setLength(0); yybegin(STRING); }
	
	{Integer}						{ System.out.println(yytext() + "\t,INTEGER"); return new Symbol(Sym.INTEGER); }
	{Float}							{ System.out.println(yytext() + "\t,FLOAT"); return new Symbol(Sym.FLOAT); }
	{Name}							{ System.out.println(yytext() + "\t,NAME"); return new Symbol(Sym.NAME); }
	{Ignore}						{}
}
<STRING> {
	{StringInit}				{ yybegin(YYINITIAL);
								System.out.println(string.toString() + "\t,STRING");
								return new Symbol(Sym.STRING,string.toString());}
	[^\n\r\"\\\']+				{ string.append( yytext() ); }
	\\t							{ string.append('\t'); }
	\\n							{ string.append('\n'); }
	\\r							{ string.append('\r'); }
	\\\"						{ string.append('\"'); }
	\\							{ string.append('\\'); }
}

<BLOCK_COMMENT> {
	\]\]						{ yybegin(YYINITIAL);
								string.append("]]");
								System.out.println(string.toString() + "\t,BLOCK_COMMENT");}
	[^\]]+						{ string.append(yytext()); }
}

<<EOF>> 							{ System.out.println(yytext() + "\t,EOF"); return new Symbol( Sym.EOF ); }
[^] 								{ throw new Error("Illegal character: "+yytext()+" at line "+(yyline+1)+", column "+(yycolumn+1) ); }