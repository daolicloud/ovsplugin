#!/bin/sh

exec 2>&1
GUNICORN=/usr/bin/gunicorn
ROOT=$PWD
PID=/var/run/gunicorn.pid
APP=driver:app
PLUGIN=/run/docker/plugins

if [ -f $PID ]; then rm $PID; fi
if [ ! -d "$PLUGIN" ]; then mkdir $PLUGIN; fi

$GUNICORN -u root --chdir $ROOT --pid=$PID \
-b unix://$PLUGIN/daolinet.sock $APP \
--timeout=5 \
--log-level=debug \
--workers 1 \
