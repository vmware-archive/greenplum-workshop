#!/bin/bash -l

LOGFILE=gpload.log
rm -f $LOGFILE
gpload -v -f gpload.yaml -l $LOGFILE
