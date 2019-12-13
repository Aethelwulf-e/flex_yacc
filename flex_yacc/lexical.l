%{
    #include "fun.h"
    #include "y.tab.h"
    void yyerror(char *);
%}

%%
1   {yylval.iValue = 1; return ONE;}
0   {yylval.iValue = 0; return ZERO;}
\n  return 0;
%%

int yywrap(void) {
    return 1;
}
