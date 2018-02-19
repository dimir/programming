#!/bin/bash

username="pacients"
password="pacients"
form_url="https://wireless.colubris.com:8090/goform/HtmlLoginRequest"

while [ 1 ]; do
	if ! ping -q -W1 -c2 www.ee; then
		curl -s -k --data "username=$username&password=$password" $form_url -O /dev/null
	fi
	sleep 5
done
