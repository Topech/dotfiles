# My dotfiles

## Why?
Allows me to update all dotfiles when changes are made easily. All my dotfiles
are under the 'myDotFiles' folder.

## LinkDots
This program automatically makes soft links in the right place for each dotfile.
This is done by keeping the correct file heirachy in 'myDotFiles' folder, with
everything in that folder put into ~/

running linkDots -f will remove all conflicting files and replace them with soft 
links to those in the git repo

## future plans
- store all dotfiles in 1 directory, have another dotfile to say where each one goes
- automatically add new dotfile to repo 
- checks before file deletion
	- check if already linked, if so dont delete
	- check if same as repo, if so, replace with link
	- chcek if different to repo, if so ask to overwrite
 


