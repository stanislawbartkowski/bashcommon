mysqlscript() {
    local -r script=$1
    log "Host: $DBHOST User: $DBUSER Database: $DB"
    mysql -h $DBHOST -u $DBUSER -p$DBPASSWORD  $DB <$script
}

mysqlcommand() {
    local -r sql="$1"
    local -r params="$2"
# do not use any echo or log command here    
    mysql -h $DBHOST -u $DBUSER -p$DBPASSWORD $params $DB -e "$sql"
}

mysqlexporttable() {
    local -r table=$1
    local -r etable=$2
    mysqlcommand "select t.* from $table as t" "--skip-column-names -t" | tail -n +2 | head -n -1 | awk -f proc/mysqlreplace.awk >$etable
}

required_listofcommands mysql
required_listofvars DBHOST DBUSER DBPASSWORD DB
