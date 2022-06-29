#!/bin/bash

go-forward() {
	local currentDir=$(pwd)
	navigate $currentDir $@
}
