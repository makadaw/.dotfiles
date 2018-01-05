#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# git pull origin master;

function sync() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "setup.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;
}

function gsu() {
    echo "Sync";
    git pull --rebase; 
    git submodule update --init --recursive 
}

function bashIt() {
    # (sed "s|{{BASH_IT}}|$BASH_IT|" "$BASH_IT/template/bash_profile.template.bash" | tail -n +2) >> "$HOME/$CONFIG_FILE"
    sed -i 's/{{BASH_IT}}/$HOME\/.bash_it.sh/g' .bashrc
    ~/.bash_it/install.sh --silent --no-modify-config
}

function doIt() {
    gsu;
    sync;
    bashIt;
	echo "Load bash profile";
	source ~/.bash_profile;
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
unset gsu;
unset doIt;
