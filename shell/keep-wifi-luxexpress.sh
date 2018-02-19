#!/bin/bash

LOGIN_URL="http://192.168.88.1/login"
CHECK_INTERVAL=3
RESTART_URL_PTRN='http://.*&username=[^"]+'

DEBUG=0
[ "$1" = "-d" ] && DEBUG=1

[ $DEBUG -eq 1 ] && echo "debug enabled"

while [ 1 ]; do
	if ! ping www.ee -c 3 -W 3 > /dev/null 2>&1; then
		rv=$?
		if [ $rv -eq 2 ]; then
			[ $DEBUG -eq 1 ] && echo "Resolver error, will try again..."
			sleep 3
			continue
		fi

		restart_url=$(curl -s $LOGIN_URL | egrep -i "$RESTART_URL_PTRN" -o)
		if [ -z "$restart_url" ]; then
			[ $DEBUG -eq 1 ] && echo "could not get restart url using pattern \"$RESTART_URL_PTRN\" from \"$LOGIN_URL\""
			echo "Login page $LOGIN_URL seems to be invalid, please check"
			exit 1
		fi

		[ $DEBUG -eq 1 ] && echo "sleeping for $CHECK_INTERVAL..."
		links -dump "$restart_url" > /dev/null
	fi

	[ $DEBUG -eq 1 ] && echo "sleeping for $CHECK_INTERVAL..."
	sleep $CHECK_INTERVAL
done
