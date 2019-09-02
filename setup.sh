#!/usr/bin/env bash

FORCE=0
TYPE=
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
    sed "s|{{BASH_IT}}|$BASH_IT|" .bashrc.tmpl  > "$HOME/.bashrc"
    ~/.bash_it/install.sh --silent --no-modify-config
 	echo "Load bash profile from $HOME/.bashrc";
	source "$HOME/.bashrc";
}

function zshItAll() {
    local MY_ZSH="$HOME/.oh-my-zsh"
    sed "s|{{MY_ZSH}}|$MY_ZSH|" .zshrc.tmpl  > "$HOME/.zshrc"
}

function doIt() {
    if [ -z "$1" ]; then
        echo "Please provide type"
        exit 1
    fi
    gsu;
    sync;
    fonts;
    case $1 in
        bash )      bashItAll
                    ;;
        zsh )       zshItAll
                    ;;
        * )         echo "Use only bash or zsh"
                    exit 1
    esac
}

function usage() {
    echo " [-f|--force] bash|zsh"
}

while [ "$1" != "" ]; do
    case $1 in
        -f | --force )          FORCE=1 
                                ;;
        bash )                  TYPE="bash"
                                ;;
        zsh )                   TYPE="zsh"
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$FORCE" = "1" ]; then
    doIt $TYPE;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt $TYPE;
	fi;
fi;

unset sync;
unset fonts;
unset gsu;
unset bashItAll;
unset doIt;
