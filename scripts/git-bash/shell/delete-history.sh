#!/bin/bash

function delete-history() {
	history -c
	echo "" > ~/.bash_history
}
