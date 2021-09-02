# bashcommon

That's a simple library of very common bash procedures which can be embedded.<br>

Configuration.<br>

It requires as a minimum setting LOGFILE environment variable with path to log file. After LOGFILE is set, execute *touchlogfile*

Usage example:
```bash

LOGFILE=/tmp/log/mylog.txt

source ./commonproc.sh

touchlogfile
usetemp
```
