#! /bin/bash

# set postgres connection:
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only --no-align -c"

# if no arguments are provided:
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  # let's get all tables data
  TABLES="SELECT e.atomic_number, e.name, e.symbol, t.type, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius FROM elements e INNER JOIN properties p USING(atomic_number) INNER JOIN types t USING(type_id)"
  QUERY=""
  case $1 in
    # search by Symbol
    [A-Z] | [A-Z][a-z])
      QUERY="$($PSQL "$TABLES WHERE e.symbol = '$1'")" 
    ;;
    # search by atomic number
    [0-9]*)
      QUERY="$($PSQL "$TABLES WHERE e.atomic_number = $1")"
    ;;
    # search by name
    [A-Za-z]*)
      QUERY="$($PSQL "$TABLES WHERE e.name = '$1'")"
    ;;
    # if no matches exist:
    *)
      echo "Please provide an element as an argument."
    ;;
  esac
  # check if QUERY is not empty:
  if [[ ! -z $QUERY ]]
  then 
    QUERY=$(echo $QUERY | sed 's/|/ /g')
    echo $QUERY | (read NUMBER NAME SYMBOL TYPE MASS MELTING BOILING; echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius.")
  else
    echo "I could not find that element in the database."
  fi
fi
