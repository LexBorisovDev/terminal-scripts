#!/bin/bash

# 1st parameter is the initial path
# each next parameter describes a directory to navigate to
navigate() {
	if [ $# -ge 1 ]; then
		local -r directoryPattern="\/"
		local -r singleLetter="^[A-Za-zА-Яа-я0-9_]$"
		local currentDir=$(pwd)

		if [[ $1 =~ $directoryPattern ]]; then
			cd "$1"
			shift

			valid=1
			foundDir=0
			for arg in $@; do
				if [ $valid -eq 1 ]; then
					if [[ $arg =~ $directoryPattern ]]; then
						cd "$arg"
					else
						directories=$(ls -d *)
						keepGoing=1
						foundDir=0

						for dir in $directories; do
							if [ $keepGoing -eq 1 ]; then
								if [[ $arg =~ $singleLetter ]]; then
									if [[ ${dir,,} =~ ^${arg,,} ]]; then
										cd "./$dir"
										keepGoing=0
										foundDir=1
									fi
								else
									if [[ ${dir,,} =~ ${arg,,}$ ]]; then
										cd "./$dir"
										keepGoing=0
										foundDir=1
									elif [[ ${dir,,} =~ ^${arg,,} ]]; then
										cd "./$dir"
										keepGoing=0
										foundDir=1
									elif [[ ${dir,,} =~ .+${arg,,}.+ ]]; then
										cd "./$dir"
										keepGoing=0
										foundDir=1
									fi
								fi
							fi
						done

						if [ $foundDir -eq 0 ]; then
							echo -e '\033[1;31m'"no directory: $arg"
							valid=0
						fi
					fi
				fi
			done
		else
			echo -e '\033[1;31m'"invalid initial directory"
		fi
	fi
}
