#!/bin/bash

create-react-app() {
	if [ $# -eq 0 ]; then
		echo -e '\033[1;31m''provide a React directory name'
	elif [ $# -eq 1 ]; then
		npx create-react-app $1
	else
		echo -e '\033[1;31m''provide 1 React directory name'
	fi
}
