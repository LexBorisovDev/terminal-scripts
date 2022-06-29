#!/bin/bash

show-items() {
	initial=$(pwd)
	if [ $# -gt 0 ]; then
		navigate $initial $@
		currentDir=$(pwd)
		echo -e '\033[1;36m'"in" '\033[2;37m'$currentDir'\033[00m'
	fi

	items=$(ls -A | wc -l)
	if [ $items -gt 0 ]; then
		echo ""
		ls -Al
	else
		echo -e '\033[1;31m'"empty"'\033[00m'
	fi
	cd $initial
}
