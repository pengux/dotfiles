#!/bin/bash

tmpfile=/home/peter/tmp/screenshot-`date +"%Y-%m-%dT%H-%M-%S"`.png
wl-paste -t image/png > $tmpfile
echo $tmpfile
