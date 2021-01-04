#!/bin/bash

function isBrokenLink() {
	FILE=$1
	[ -h $FILE -a ! -e $FILE ] 
}

function alreadyLinked() {
	FILE=$1
	[ -h $FILE -a -e $FILE ]
}

function pathTaken() {
	FILE=$1
	[ -f $FILE -a ! -h $FILE ]
}

# NOTE: does not check permissions
function linkDotfiles() {
	TARGET_DIR=$1
	DOTFILES=$2

	CURRENT_DIR=$(pwd)
	echo "-----  $TARGET_DIR  -----"

	for f in $DOTFILES ; do
		FILE="$TARGET_DIR/$f"

		# first remove broken link
		if isBrokenLink $FILE; then
			rm "$f"
		fi

		if alreadyLinked $FILE ; then
			echo "$f is already linked";
		elif pathTaken $FILE ; then
			echo "$FILE already exists, cannot link $f";
		else 
			echo "$f -> $FILE";
			ln -s "$CURRENT_DIR/$f" "$FILE";
		fi
	done
}


# -----
# main functionality

TARGET_DIR="$HOME"
DOTFILES=".bashrc .bash_aliases .profile .vimrc"
linkDotfiles "$TARGET_DIR" "$DOTFILES"


TARGET_DIR="$HOME/.config"
DOTFILES="herbstluftwm i3 plank polybar Xmodmap"
linkDotfiles "$TARGET_DIR" "$DOTFILES"
