# .bash_profile

# Load the shell dotfiles, and then some:
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

