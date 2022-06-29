#!/bin/bash

go-back() {
	local pattern="^[0-9]+$"
	if [[ $1 =~ $pattern ]] && [ $# -eq 1 ]; then
		if [ $1 -ge 1 ]; then
			for ((i = 1; i <= $1; i++)); do
				cd ..
			done
		fi
	else
		cd ..
	fi
}
