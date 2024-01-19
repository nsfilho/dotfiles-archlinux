#!/bin/bash

if [ -z "$DOTFILES_DIR" ]; then
	DOTFILES_DIR=$(pwd -P)
fi

function removeOld() {
	path=$1

	# if is a link
	if [ -L "$HOME/$path" ]; then
		echo "📦 Removing old link $HOME/$path"
		rm "$HOME/$path"
	fi

	# if is a file
	if [ -f "$HOME/$path" ]; then
		echo "📦 Removing old file $HOME/$path"
		rm "$HOME/$path"
	fi

	# if is a directory
	if [ -d "$HOME/$path" ]; then
		echo "📦 Removing old directory $HOME/$path"
		rm -rf "$HOME/$path"
	fi
}

function linkPath() {
	pathFrom=$1
	pathTo=$2
	removeOld "$pathTo"
	echo "📦 Creating link $DOTFILES_DIR/$pathFrom -> $HOME/$pathTo"
	ln -s "$DOTFILES_DIR/$pathFrom" "$HOME/$pathTo"
}
