# bashcommon

That's simply library of very common bash procs which can be embedded. Usage

It requires as a minimum to set LOGFILE environment variable with path to log file. After LOGFILE is set, execute *touchlogfile*

Usage example:
```bash

LOGFILE=/tmp/log/mylog.txr

source ./commonproc.sh

touchlogfile
```
