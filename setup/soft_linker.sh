#!/bin/bash

function is_broken_link() {
	FILE=$1
	[ -h "$FILE" ] && [ ! -e "$FILE" ] 
}

function already_linked() {
	FILE=$1
	[ -h "$FILE" ] && [ -e "$FILE" ]
}

function path_taken() {
	FILE=$1
	[ -f "$FILE" ] || [ -d "$FILE" ] && [ ! -h "$FILE" ]
}

# NOTE: does not check permissions
function link_dotfiles() {
	TARGET_DIR=$1
	DOTFILES=$2

	CURRENT_DIR=$(pwd)
	echo "-----  $TARGET_DIR  -----"

	for f in $DOTFILES ; do
		FILE="$TARGET_DIR/$f"

		# first remove broken link
		if is_broken_link "$FILE"; then
			rm "$FILE"
		fi

		if already_linked "$FILE" ; then
			echo "$f is already linked";
		elif path_taken "$FILE" ; then
			echo "$FILE already exists, cannot link $f";
		else 
			echo "$f -> $FILE;"
			ln -s "$CURRENT_DIR/$f" "$FILE";
		fi
	done
}


# -----
# main functionality

