#!/usr/bin/env bash

# CD to script folder
cd "$(dirname "${BASH_SOURCE}")" || exit 1;

# git pull origin master;

function sync() {
	rsync --exclude ".git/" \
        --exclude "fonts/" \
        --exclude ".gitmodules" \
		--exclude ".DS_Store" \
		--exclude "setup.sh" \
		--exclude "README.md" \
        --exclude ".bash_it_init" \
		--exclude ".bashrc.tmpl" \
        --exclude ".zshrc.tmpl" \
		-avh --no-perms . ~;
}

function fonts() {
    cd fonts || exit
    ./install.sh
    cd .. || exit
}

function gsu() {
    echo "Sync";
    git pull --rebase; 
    git submodule update --init --recursive 
}

function bashItAll() {
    local BASH_IT="$HOME/.bash_it"
    local MY_ZSH="$HOME/.oh-my-zsh"
    sed "s|{{BASH_IT}}|$BASH_IT|" .bashrc.tmpl  > "$HOME/.bashrc"
    sed "s|{{MY_ZSH}}|$MY_ZSH|" .zshrc.tmpl  > "$HOME/.zshrc"
    ~/.bash_it/install.sh --silent --no-modify-config
    # Install default parts
}

function doIt() {
    gsu;
    sync;
    fonts;
    bashItAll;
	echo "Load bash profile from $HOME/.bashrc";
	source "$HOME/.bashrc";
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset sync;
unset fonts;
unset gsu;
unset bashItAll;
unset doIt;
