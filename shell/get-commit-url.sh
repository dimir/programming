#!/bin/bash

set -o errexit

commit=$1

if [ -z "$commit" ]; then
	echo "usage $0 <commit>"
	exit
fi

echo '['$commit'|https://git.zabbix.com/projects/ZBX/repos/zabbix/commits/'$commit']'
