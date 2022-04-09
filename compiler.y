%{
   #include <bits/stdc++.h>
   #include <ctype.h>
   #include <stdio.h>
   #include "scanner.h"
   #include "lex.yy.c"
    using namespace std;
    extern int yylex();

    vector<pair<string,string>> components;
    std::string class_name, window_size, layout, title;

    /**
     * Loads template code from JavaCode.temp.java
     * Modifies the template file according to the inputs.
     */
    void create_window_file()
    {
        std::ifstream inFile;
        inFile.open("JavaCode.temp.java"); //open the input file

        std::stringstream strStream;
        strStream << inFile.rdbuf(); //read the file
        std::string str = strStream.str(); //str holds the content of the file

        std::cout << str << "\n"; //you can do anything with the string!!!

        std::cout << "class_name:"  << class_name << "\n";
        std::cout << "window_size:" << window_size << "\n";
        std::cout << "layout:"      << layout << "\n";
        std::cout << "title:"       << title << "\n";

        class_name = class_name.substr(1, class_name.size() - 2);
        window_size = window_size.substr(1, window_size.size() - 2);

        // replace {{class_name}} in string.
        str = std::regex_replace(str, std::regex("\\{\\{class_name\\}\\}"), class_name);

        // replace {{size}} in string.
        str = std::regex_replace(str, std::regex("\\{\\{size\\}\\}"), window_size);

        // replace {{layout}} in string.
        str = std::regex_replace(str, std::regex("\\{\\{layout\\}\\}"), "new " + layout + "()");

        // replace {{title}} in string.
        str = std::regex_replace(str, std::regex("\\{\\{title\\}\\}"), title);




        std::string component_list = "";
        
        int cnt = 1;
        for(auto pr : components) {
            if(pr.first == "label") {
                component_list += "Label l"+to_string(cnt)+ " = new Label(" + pr.second + ");\n";
            } else if(pr.first == "button") {
                component_list += "Button b"+to_string(cnt)+ " = new Button(" + pr.second + ");\n";
            }
            cnt  ++;
        }

        str = std::regex_replace(str, std::regex("\\{\\{component_list\\}\\}"), component_list);


        std::string component_add = "";

        cnt = 1;
        for(auto pr : components) {
            if(pr.first == "label") {
                component_add += "add(l"+to_string(cnt)+ ");\n";
            } else if(pr.first == "button") {
                component_add += "add(b"+to_string(cnt)+ ");\n";
            }
            cnt  ++;
        }

        str = std::regex_replace(str, std::regex("\\{\\{component_add\\}\\}"), component_add);

        str += "\n";
        std::cout << str << "\n";

        std::ofstream out(class_name + ".java");
        out << str;
        out.close();
    }
%}


%token WINDOW
%token END

%token BORDERLAYOUT
%token FLOWLAYOUT
%token GRIDLAYOUT

%token LABEL
%token BUTTON
%token TEXTFIELD
%token CHECKBOX
%token RADIOBUTTON
%token CHOICE
%token LIST
%token TEXTAREA
%token SCROLLPANE

%token MENUBAR
%token MENU
%token MENUITEM
%token MENUSEPARATOR

%token PANEL

%token NORTHPANE
%token SOUTHPANE
%token EASTPANE
%token WESTPANE
%token CENTERPANE

%token INT_PAIR
%token STRING
%token VARIABLE

%token GRAPHICS

%token COLOR
%token FONT
%token RECTANGLE
%token LINE
%token OVAL

%token FILL

%token ONCLICK

%token JAVACODE

%token IMAGE

%union {
    char *str;    
};

%type<str> string variable window end flow_layout label button int_pair 
%start program
%%
    window : WINDOW {  };
    end : END {  };
    flow_layout : FLOWLAYOUT { $$ = "FlowLayout";  };
    label : LABEL {  };
    button : BUTTON {  };

    int_pair : INT_PAIR { strcpy($$, yyval.str); };
    string : STRING { strcpy($$, yyval.str); };
    variable : VARIABLE { strcpy($$, yyval.str); };

    label_def: label string end { components.push_back({"label", std::string($2)}); } ;
    button_def: button string end { components.push_back({"button", std::string($2)}); };
    component: label_def | button_def;
    components_list : component  components_list
                    |;

    window_def: window string int_pair flow_layout variable components_list end { class_name = std::string($5); window_size = std::string($3); layout = std::string($4); title = std::string($2); cout << "Test" << endl;create_window_file(); }; 

    program : window_def;
%%

  




int main() 
{
    yyparse();
    return 0;
}