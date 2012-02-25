#!/bin/bash

# Configuration
backup='/Volumes/Gringotts/'
flashDir='Backup/Flashdrive/lol/'

function hdBackup() {
	echo Local Harddrive Backup Commencing...
	hdDir='OS X'
	dirs=( "/Users/Davis" )
	for dir in ${dirs[@]}; do
		#rsync -hurl --progress --exclude-from="$backup$hdDir/exclude.txt" "$dir" "$backup$hdDir"
		rsync -ahHE --progress --delete-after --exclude-from="$backup$hdDir/exclude.txt" "$dir" "$backup$hdDir"
	done
}

function flashBackup() {
	echo Flashdrive Backup Commencing...
	flash='/Volumes/lol'
	if [ -d "$flash" ]; then
		echo Flashdrive found, starting backup..
		flashDir='Backup/Flashdrive/'
		#rsync -hurl --progress "$flash" "$backup$flashDir"
		rsync -avhH "$flash" "$backup$flashDir"
	else
		echo Flashdrive not mounted - $flash
	fi
}

if [ -d "$backup" ]; then
	echo Starting backup..
	hdBackup
	flashBackup
else
	echo Error: External Harddrive Not Mounted - $backup
fi
