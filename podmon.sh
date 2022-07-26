# ----------------------------------
# utitlities to monitor podman/docker
# 2022/07/21 - first draft
# 2022/07/26 - kill container
# ----------------------------------

MDATELEN=10
COMMANDLEN=25
MESSLEN=6

monstep() {
    if ! find $CHECKDIR/check*.sh -type f >>$LOGFILE;  then    
       logfail "There is no check scripts in $CHECKDIR directory"
    fi
    OK=1

    for filename in $CHECKDIR/check*.sh ; do
       if ! [[ -x "$filename" ]]; then logfail "File $filename is not executable"; fi
       BEG=`getdate`
       log "Execute $filename"
       $filename
       RES=$?
       if [ $RES -eq 0 ]; then MESS="OK"; else MESS="FAILED"; OK=0; fi
       printreportline $REPORTILE "$BEG" $MDATELEN $filename $COMMANDLEN "$MESS" $MESSLEN "`getdate`" $MDATELEN
    done

    if [ $OK -eq 0 ]; then 
      BEG=`getdate`
      log "Healthcheck failed, restart container"
      COMMAND="$PODMAN kill $CONTAINER"
      $COMMAND >>$LOGFILE 2>>$LOGFILE
      COMMAND="$PODMAN start $CONTAINER"
      $COMMAND >>$LOGFILE 2>>$LOGFILE
      RES=$?
      if [ $RES -eq 0 ]; then MESS="OK"; else MESS="FAILED"; OK=0; fi
      printreportline $REPORTILE "$BEG" $MDATELEN "$COMMAND" $COMMANDLEN "$MESS" $MESSLEN "`getdate`" $MDATELEN
    fi
}

monrun() {
  touchlogfile
  usetemp
  required_listofvars "CONTAINER REPORTILE CHECKDIR PODMAN"
  monstep
}
