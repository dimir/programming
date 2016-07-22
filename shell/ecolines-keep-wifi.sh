#!/bin/bash

LOGIN_URL="http://192.168.88.1/login"

while [ 1 ]; do
	if ! ping www.ee -c 3 > /dev/null 2>&1; then
		restart_url=$(curl -s $LOGIN_URL | egrep -i 'http://.*&username=[^"]+' -o)
		if [ -z "$restart_url" ]; then
		    echo "Login page $LOGIN_URL seems to be invalid, please check"
		    exit 1
		fi
		links "$restart_url" -dump > /dev/null
	fi

	sleep 3
done
