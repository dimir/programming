#!/bin/bash

if [ $# -lt 1 ]; then
    echo "usage: $0 <file> [file] ..."
    exit
fi

while [ "$1" != "" ]; do
    f="$1"
    shift

    if [ ! -f "$f" ]; then
	echo "$f: no such file"
	continue
    fi

    rename -v 's/\ -\ /--/g;s/\ /-/g;s/([A-Z])/\L$1/g' "$f"
done
