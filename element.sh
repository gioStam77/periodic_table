#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
ELEMENT=$1
if [[ -z $ELEMENT ]]
then echo "Please provide an element as an argument."
else
#if input is not a number
if [[ ! $ELEMENT =~ ^[0-9]+$ ]]
then 
  # if input is more than 2 letters
    if [[ ! $ELEMENT =~ ^[A-Z]$|^[A-Z][a-z]$ ]]
    then 
        # get data by full name
        DATA=$($PSQL "SELECT * FROM elements WHERE name='$ELEMENT'")
        if [[ -z $DATA ]]
        then
          echo "I could not find that element in the database."
          else
      #display data
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ELEMENT'");
      ATOMIC_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$ELEMENT'");
      TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name='$ELEMENT'");
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT ($ATOMIC_SYMBOL). It's a $TYPE, with a mass of $MASS amu. $ELEMENT has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        fi
     else 
         # get data by atomic symbol
           DATA=$($PSQL "SELECT * FROM elements WHERE symbol='$ELEMENT'")
       if [[ -z $DATA ]]
      then
          echo "I could not find that element in the database."
        else
      #display data
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ELEMENT'");
      ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$ELEMENT'");
      TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$ELEMENT'");
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ATOMIC_NAME ($ELEMENT). It's a $TYPE, with a mass of $MASS amu. $ATOMIC_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        fi
    fi
  else
   # get data by atomic number
    DATA=$($PSQL "SELECT * FROM elements WHERE atomic_number='$ELEMENT'")
        if [[ -z $DATA ]]
        then
          echo "I could not find that element in the database."
          else
      #display data
      ATOMIC_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number='$ELEMENT'");
      ATOMIC_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number='$ELEMENT'");
      TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE atomic_number='$ELEMENT'");
      MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ELEMENT")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ELEMENT")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ELEMENT")
      echo -e "The element with atomic number $ELEMENT is $ATOMIC_NAME ($ATOMIC_SYMBOL). It's a $TYPE, with a mass of $MASS amu. $ATOMIC_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
        fi
fi
  
fi

#bravo
#bravo gio
