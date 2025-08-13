#!/bin/bash

set -o errexit

issue=$1

if [ -z "$issue" ]; then
	echo 'Fixed in [development branch|https://git.zabbix.com/projects/ZBX/repos/zabbix/browse?at=refs/heads/'$(git rev-parse --abbrev-ref HEAD)']'
	exit
fi

if [ ! -d ../master ]; then
	echo "please enter directory of master branch"
	exit
fi

pushd .. > /dev/null

for i in release/* master; do
	pushd $i > /dev/null
	commit=$(git log --first-parent --oneline | grep ' \[.*'$issue'.*\] ' | cut -f1 -d' ' | head -1)
	version=$(git show $commit:ChangeLog | head -1 | cut -f3 -d' ')
	popd > /dev/null
	if [ -z "$commit" ]; then
		continue
	fi
	echo '* *'$version'* ['$commit'|https://git.zabbix.com/projects/ZBX/repos/zabbix/commits/'$commit']'
done

popd > /dev/null
