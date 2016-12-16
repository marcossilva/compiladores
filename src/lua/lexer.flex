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

	private Symbol symbol(int type) {
		System.out.println(yytext());
		return new Symbol(type, yyline, yycolumn, type);
	}
	private Symbol symbol(int type, Object value) {
		System.out.println(type+" , "+value);
		return new Symbol(type, yyline, yycolumn, value.toString());
	}
%}

Name			= [\w_][\w]*
Integer			= \d+
Float 			= \d+(\.\d+){0,1}(e[+-]{0,1}\d+){0,1}
StringInit		= \"|\'
Ignore 			= \r|\n|\r\n|" "|\t|\f|\t\f
CommentLine 	= --.*\n
CommentBlockInit	= --\[\[\n

%%
<YYINITIAL>{
	{CommentBlockInit}				{ string.setLength(0); string.append("--[[\n"); yybegin(BLOCK_COMMENT); }
	{CommentLine}					{}
	{Ignore}						{}
	";"								{ return symbol(Sym.SEMICOLON); }
	"="								{ return symbol(Sym.EQUAL); }
	"do"							{ return symbol(Sym.DO); }
	"end"							{ return symbol(Sym.END); }
	"while"							{ return symbol(Sym.WHILE); }
	"repeat"						{ return symbol(Sym.REPEAT); }
	"until"							{ return symbol(Sym.UNTIL); }
	"if"							{ return symbol(Sym.IF); }
	"then"							{ return symbol(Sym.THEN); }
	"elseif"						{ return symbol(Sym.ELSEIF); }
	"else"							{ return symbol(Sym.ELSE); }
	"for"							{ return symbol(Sym.FOR); }
	","								{ return symbol(Sym.COMMA); }
	"in"							{ return symbol(Sym.IN); }
	"function"						{ return symbol(Sym.FUNCTION); }
	"local"							{ return symbol(Sym.LOCAL); }
	"return"						{ return symbol(Sym.RETURN); }
	"break"							{ return symbol(Sym.BREAK); }
	"."								{ return symbol(Sym.DOT); }
	":"								{ return symbol(Sym.COLON); }
	"nil"							{ return symbol(Sym.NIL); }
	"false"							{ return symbol(Sym.FALSE); }
	"true"							{ return symbol(Sym.TRUE); }

	"..."							{ return symbol(Sym.THREE_DOTS); }
	"("								{ return symbol(Sym.L_PARENTHESIS); }
	")"								{ return symbol(Sym.R_PARENTHESIS); }
	"{"								{ return symbol(Sym.L_BRACES); }
	"}"								{ return symbol(Sym.R_BRACES); }
	"["								{ return symbol(Sym.L_BRACKETS); }
	"]"								{ return symbol(Sym.R_BRACKETS); }
	"+"								{ return symbol(Sym.PLUS); }
	"-"								{ return symbol(Sym.MINUS); }
	"*"								{ return symbol(Sym.TIMES); }
	"/"								{ return symbol(Sym.DIV); }
	"^"								{ return symbol(Sym.EXP); }
	"%"								{ return symbol(Sym.MOD); }
	".."							{ return symbol(Sym.TWO_DOTS); }
	"<"								{ return symbol(Sym.SMALLER_THAN); }
	"<="							{ return symbol(Sym.SMALLER_THAN_OR_EQUAL); }
	">"								{ return symbol(Sym.GREATER_THAN); }
	">="							{ return symbol(Sym.GREATER_THAN_OR_EQUAL); }
	"=="							{ return symbol(Sym.EQUAL_EQUAL); }
	"~="							{ return symbol(Sym.APROX); }
	"and"							{ return symbol(Sym.AND); }
	"or"							{ return symbol(Sym.OR); }

	"not"							{ return symbol(Sym.NOT); }
	"#"								{ return symbol(Sym.HASHTAG); }
	{StringInit}					{ string.setLength(0); yybegin(STRING); }
	
	{Integer}						{ return symbol(Sym.NUMBER, Integer.valueOf(yytext())); }
	{Float}							{ return symbol(Sym.NUMBER, Float.valueOf(yytext())); }
	{Name}							{ return symbol(Sym.NAME, yytext()); }
}
<STRING> {
	{StringInit}				{ yybegin(YYINITIAL);
								System.out.println(string.toString() + "\t,STRING");
								return symbol(Sym.STRING,string.toString());}
	[^\n\r\"\\\']+				{ string.append( yytext() ); }
	\\t							{ string.append('\t'); }
	\\n							{ string.append('\n'); }
	\\r							{ string.append('\r'); }
	\\b							{ string.append('\b'); }
	\\f							{ string.append('\f'); }
	\\\"						{ string.append('\"'); }
	\\							{ string.append('\\'); }
	\\.                         { throw new RuntimeException("Malformed String: Unexpected escape symbol \""+yytext()+"\""); }
	[\r|\n|\r\n]				{ throw new RuntimeException("Malformed String: String doesn't end in one line."); }
}

<BLOCK_COMMENT> {
	\]\]						{ yybegin(YYINITIAL);
								string.append("]]");
								/*System.out.println(string.toString() + "\t,BLOCK_COMMENT");*/}
	[^\]]+						{ string.append(yytext()); }
}

<<EOF>> 							{ return symbol( Sym.EOF ); }
[^] 								{ throw new Error("Illegal character: "+yytext()+" at line "+(yyline+1)+", column "+(yycolumn+1) ); }