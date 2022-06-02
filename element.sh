#! /bin/bash

# if no arguments are provided:
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  case $1 in
    # search by Symbol
    [A-Z] | [A-Z][a-z])
      echo "buscar por simbolo"
    ;;
    # search by atomic number
    [0-9]*)
      echo "buscar por numero atomico"
    ;;
    # search by name
    [A-Z][a-z]*)
      echo "buscar por nombre"
    ;;
    # if no matches exist:
    *)
      echo "Please provide an element as an argument."
    ;;
  esac
fi
