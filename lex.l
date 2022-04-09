%{
#include "y.tab.h"
/* #include "scanner.h" */
%}

%%
"Window"                { return WINDOW; }
"End"                   { return END; }
"BorderLayout"          { return BORDERLAYOUT; }

"NORTH"                 { return NORTHPANE; }
"EAST"                  { return EASTPANE; }
"WEST"                  { return WESTPANE; }
"SOUTH"                 { return SOUTHPANE; }
"CENTER"                { return CENTERPANE; }

"FlowLayout"            { return FLOWLAYOUT; }
"GridLayout"            { return GRIDLAYOUT; }

"Label"                 { return LABEL; }
"Button"                { return BUTTON; }
"TextField"             { return TEXTFIELD; }
"TextArea"              { return TEXTAREA; }
"Checkbox"              { return CHECKBOX; }
"Choice"                { return CHOICE; }
"List"                  { return LIST; }
"Panel"                 { return PANEL; }

"MenuBar"               { return MENUBAR; }
"MenuItem"              { return MENUITEM; }
"MenuSeparator"         { return MENUSEPARATOR; }
"Menu"                  { return MENU; }

"Graphics"              { return GRAPHICS; }
"Color"                 { return COLOR; }
"Font"                  { return FONT; }
"Image"                 { return IMAGE; }
"Rectangle"             { return RECTANGLE; }
"Line"                  { return LINE; }
"Oval"                  { return OVAL; }
"Fill"                  { return FILL; }
"OnClick"               { return ONCLICK; }

\{([^}]|[.|\n])*\}         {
    yylval.str = (char*) malloc(strlen(yytext) * sizeof(char));
    strcpy(yylval.str,yytext);
     return JAVACODE; }
\<[a-zA-Z][a-zA-Z0-9]+\>   {yylval.str = (char*) malloc(strlen(yytext) * sizeof(char));strcpy(yylval.str,yytext); return VARIABLE; }
\([0-9]+\,[0-9]+\)         {yylval.str = (char*) malloc(strlen(yytext) * sizeof(char));strcpy(yylval.str,yytext); return INT_PAIR; }
["]([^"\\\n]|\\(.|\n))*["] {yylval.str = (char*) malloc(strlen(yytext) * sizeof(char));strcpy(yylval.str,yytext); return STRING; }
[ \t\n]                 ;;

. {  printf("ERROR: --%s--\n", yytext);}
%%

int yywrap() {
    return 0;
}

void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
}