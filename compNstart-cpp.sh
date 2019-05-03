#!/bin/bash
g++-7 -g -Wall -Wextra -Wshadow -std=c++11 -fms-extensions src/classes-end.cpp -o classes.out
printf "%s\n--------result--------- \n"
./classes.out
printf "%s--------result--------- \n"