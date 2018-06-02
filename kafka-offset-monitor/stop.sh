#!/bin/bash
PID=$(cat ./.pid)
kill -9 $PID
echo "app is stopped!"
