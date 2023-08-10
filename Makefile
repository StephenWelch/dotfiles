all:
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */

install:
	sudo apt install stow neovim curl build-essential
	git config --global user.email "stephenwelchva@vt.edu"
	git config --global user.name "Stephen Welch"
	
	make
