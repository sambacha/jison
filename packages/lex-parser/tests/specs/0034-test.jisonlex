//
// title: test lex grammar bootstrap
// specfile: lex/lex_grammar.jisonlex
// reffile: lex/lex_grammar.lex.json
// 


%%
\n+     {yy.freshLine = true;}
\s+     {yy.freshLine = false;}
"y{"[^}]*"}"      {yytext = yytext.substr(2, yyleng-3);return 'ACTION';}
[a-zA-Z_][a-zA-Z0-9_]*      {return 'NAME';}
'"'([^"]|'\"')*'"'      {return 'STRING_LIT';}
"'"([^']|"\'")*"'"      {return 'STRING_LIT';}
"|"     {return '|';}
"["("\]"|[^\]])*"]"     {return 'ANY_GROUP_REGEX';}
"("     {return '(';}
")"     {return ')';}
"+"     {return '+';}
"*"     {return '*';}
"?"     {return '?';}
"^"     {return '^';}
"/"     {return '/';}
"\\"[a-zA-Z0]     {return 'ESCAPE_CHAR';}
"$"     {return '$';}
"<<EOF>>"     {return '$';}
"."     {return '.';}
"%%"      {return '%%';}
"{"\d+(","\s?\d+|",")?"}"     {return 'RANGE_REGEX';}
/"{"      %{if(yy.freshLine){this.input('{');return '{';} else this.unput('y');%}
"}"     %{return '}';%}
"%{"(.|\n)*?"}%"      {yytext = yytext.substr(2, yyleng-4);return 'ACTION';}
.     {/* ignore bad characters */}
<<EOF>>     {return 'EOF';}

