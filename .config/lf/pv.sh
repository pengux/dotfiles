#!/bin/sh
file=$1
w=$2
h=$3
x=$4
y=$5
# echo "$@" >> ~/tmp/pv.log
# echo "$x","$y","$w","$h" "$1" >> ~/tmp/pv.log
case "$1" in
	*.tar*) tar tf "$1";;
	*.zip) unzip -l "$1";;
	*.rar) unrar l "$1";;
	*.7z) 7z l "$1";;
	*.pdf) pdftotext "$1" -;;
	*.png) swayimg -s fit -g "$x","$y","$w","$h" "$1";;
	*) bat --theme="Enki-Tokyo-Night" --paging=never --style=numbers --terminal-width $(($2-5)) -f "$1" || true;;
	# *) highlight -O ansi "$1";;
	# *) clp "$1";;
esac
