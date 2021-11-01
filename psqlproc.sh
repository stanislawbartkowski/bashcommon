
#set -x
#w

psqlcommand() {
  local -r command="$1"
  local PORT=""
  [ -n "$DBPORT" ] && PORT="-p $DBPORT"
  export PGPASSWORD=$DBPASSWORD; psql -h $DBHOST $PORT -U $DBUSER -d $DB -t -v "ON_ERROR_STOP=true" -c "$command"
}

psqlscript() {
  local PORT=""
  [ -n "$DBPORT" ] && PORT="-p $DBPORT"

  export PGPASSWORD=$DBPASSWORD; psql -h $DBHOST $PORT -U $DBUSER -d $DB -t -v "ON_ERROR_STOP=true" <$1 
}

required_command psql
