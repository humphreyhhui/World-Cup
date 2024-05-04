#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

TRUNCATE=$($PSQL "TRUNCATE TABLE games,teams;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WINNERGOALS OPPGOALS
do
  if [[ $YEAR != "year" ]]
  then
    WINNER_ID1=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    if [[ -z $WINNER_ID1 ]]
    then
      INSERT_WINNER_INTO_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
    fi
    OPP_ID1=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")
    if [[ -z $OPP_ID1 ]]
    then
      INSERT_OPP_INTO_TEAMS=$($PSQL "INSERT INTO teams(name) VALUES('$OPP')")
    fi
  fi
done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPP WINNERGOALS OPPGOALS
do
  if [[ $YEAR != "year" ]]
  WINNER_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  OPP_ID2=$($PSQL "SELECT team_id FROM teams WHERE name='$OPP'")
  then
    INSERT_DATA_INTO_GAMES=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID2,$OPP_ID2,$WINNERGOALS,$OPPGOALS)")
  fi
done