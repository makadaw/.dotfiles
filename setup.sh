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

function zshItAll() {
    local MY_ZSH="$HOME/.oh-my-zsh"
    sed "s|{{MY_ZSH}}|$MY_ZSH|" .zshrc.tmpl  > "$HOME/.zshrc"
}

function doIt() {
    gsu;
    sync;
    fonts;
		zshItAll;
}

function usage() {
    echo " [-f|--force]"
}

while [ "$1" != "" ]; do
    case $1 in
        -f | --force )          FORCE=1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$FORCE" = "1" ]; then
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
unset zshItAll;
unset doIt;
