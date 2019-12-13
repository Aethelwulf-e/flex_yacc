%{
    #include <stdio.h>
    #include <stdlib.h>
    #include "fun.h"
    int yylex(void);
    void yyerror(char *);
    treeNode* newTreeNode();
    int getListPos(treeNode*);
    int getListVal(treeNode*);
    void setListPos(treeNode*, int);
    void setListVal(treeNode*, int);
    int my_exp(int, int);
%}

%union {
    int iValue;
    treeNode *nPtr;
};

%token ONE ZERO

%type <nPtr> list
%type <iValue> id ZERO ONE

%%
    init:
        list    {printf("%d\n", getListVal($1));}
        ;
    list:
        id list {$$ = newTreeNode(); setListPos($$, getListPos($2) + 1);
                    setListVal($$, my_exp(2, getListPos($$)) * $1 + getListVal($2));}
        | id    {$$ = newTreeNode(); setListVal($$, $1); setListPos($$, 0);}
        ;
    id:
        ZERO    {$$ = $1;}
        | ONE   {$$ = $1;}
        ;
%%

void yyerror(char *err) {
    fprintf(stderr, "%s\n", err);
}

treeNode* newTreeNode() {
    treeNode *nl = (treeNode*)malloc(sizeof(treeNode));
    nl->pos = -1;
    nl->val = -1;
    return nl;
}

int getListPos(treeNode *nl) {
    return nl->pos;
}

int getListVal(treeNode *nl) {
    return nl->val;
}

void setListPos(treeNode *nl, int pos_) {
    nl->pos = pos_;
}

void setListVal(treeNode *nl, int val_) {
    nl->val = val_;
}

int my_exp(int b, int e) {
    int count = 1;
    for(int i = 0; i < e; i++) {
        count *= b;
    }
    return count;
}

int main() {
    while(1)
        yyparse();
    return 0;
}
