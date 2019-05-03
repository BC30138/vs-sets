SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

echo -n "Language of project: "
read lang
Lang=$(echo "$lang" | tr '[:lower:]' '[:upper:]')

if [ "$Lang" == "JAVA" ] || [ "$Lang" == "CPP" ] || [ "$Lang" == "PYTHON" ] || [ "$Lang" == "TEX" ]
    then
    echo -n "Project name: "
    read ProjectName

    if [ ! "$ProjectName" == "" ]
        then
        echo -n "Project subdirectory (if you are already here don't type anything): "
        read ProjectPath

        ProjectPath="$SCRIPTPATH/$ProjectPath"

        if [ "$ProjectPath" == "" ]
        then
            ProjectPath="$ProjectName"
        else
            if [ ! -d "$ProjectPath" ]
            then
                mkdir $ProjectPath
            fi
            ProjectPath="$ProjectPath/$ProjectName"
        fi

        if [ -d "$ProjectPath" ];
        then
            DirectoryExist=true
        else
            mkdir $ProjectPath
            DirectoryExist=false
        fi

        if [ "$DirectoryExist" = false ]
        then
            cp -R $SCRIPTPATH/VS-sets/$Lang/. $ProjectPath
            case "$Lang" in
            "CPP")
                echo -n "Name of file with main function (if empty it will be 'Main'): "
                read MainCpp
                if [ "$MainCpp" == "" ]
                then
                    MainCpp="Main"
                fi
                mkdir $ProjectPath/src
                mkdir $ProjectPath/data
                touch $ProjectPath/src/$MainCpp.cpp
                echo "#include <iostream>" >> $ProjectPath/src/$MainCpp.cpp
                echo "" >> $ProjectPath/src/$MainCpp.cpp
                echo "using namespace std;" >> $ProjectPath/src/$MainCpp.cpp
                echo "" >> $ProjectPath/src/$MainCpp.cpp
                echo "int main() {" >> $ProjectPath/src/$MainCpp.cpp
                echo -e "\treturn 0;" >> $ProjectPath/src/$MainCpp.cpp
                echo "}" >> $ProjectPath/src/$MainCpp.cpp
                sed -i '' "s/Program-Name/$ProjectName/g" $ProjectPath/.vscode/launch.json
                sed -i '' "s/Program-Name/$ProjectName/g" $ProjectPath/.vscode/tasks.json
                ;;
            "JAVA")
                echo -n "Company name (if empty it will be 'bc30138' :) ): "
                read Company
                if [ "$Company" == "" ]
                then
                    Company="bc30138"
                else
                    Company=$(echo "$Company" | tr '[:upper:]' '[:lower:]')
                fi
                echo -n "Main class name (if empty it will be 'MainClass'): "
                read ClassName
                if [ "$ClassName" == "" ]
                then
                    ClassName="MainClass"
                fi
                ProjectName=$(echo "$ProjectName" | tr '[:upper:]' '[:lower:]')
                mkdir $ProjectPath/data
                mkdir $ProjectPath/src
                mkdir $ProjectPath/src/com
                mkdir $ProjectPath/src/com/$Company
                mkdir $ProjectPath/src/com/$Company/$ProjectName
                touch $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                echo "package com.$Company.$ProjectName;" >> $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                echo "" >> $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                echo "public class $ClassName {" >> $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                echo -e "\tpublic static void main(String[] args){" >> $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                echo -e "\t}" >> $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                echo -e "}" >> $ProjectPath/src/com/$Company/$ProjectName/$ClassName.java
                sed -i '' "s/CompanyName/$Company/g" $ProjectPath/.vscode/tasks.json
                sed -i '' "s/ProjectName/$ProjectName/g" $ProjectPath/.vscode/tasks.json
                sed -i '' "s/MainClass/$ClassName/g" $ProjectPath/.vscode/tasks.json
                ;;
            "PYTHON")
                echo -n "Name of main (if empty it will be 'Main'): "
                read MainPy
                if [ "$MainPy" == "" ]
                then
                    MainPy="main"
                fi
                mkdir $ProjectPath/src
                mkdir $ProjectPath/data
                touch $ProjectPath/src/$MainPy.py
                sed -i '' "s/Program-Name/$MainPy/g" $ProjectPath/.vscode/launch.json
                sed -i '' "s/Program-Name/$MainPy/g" $ProjectPath/.vscode/tasks.json
                ;;
            "TEX")
                echo -n "Name of main (if empty it will be 'Main'): "
                read MainTex
                if [ "$MainTex" == "" ]
                then
                    MainTex="Main"
                fi
                touch $ProjectPath/$MainTex.tex
                ;;
            esac
        else
            echo "Such project alredy exist"
        fi
    else
        echo "Project name couldn't be empty"
    fi
else
    echo "Error language name, it can be only: CPP, JAVA, PYTHON or TEX"
fi

