#!/bin/sh
echo "$@" >> ~/tmp/pv_cleaner.log
killall swayimg 2> /dev/null
