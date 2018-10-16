#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function clean() {
  [[ -d ~/.zplug ]] && rm -rf ~/.zplug
}

function setup() {
  #Copy files
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "*.sh" \
    --exclude "scripts" \
		--exclude "prezto" \
    --exclude "README.md" \
		--exclude "LICENSE" \
		-avh --no-perms . ~;
  source ./scripts/brew.sh
  
  #Change shell
  echo "Changing your shell to ZSH"
  chsh -s /bin/zsh

  zsh -c "source ~/.zshrc && echo Zplug Installed" &
  wait $!

  source ./scripts/prezto-install.sh
  source ./scripts/gitsetup.sh
  source ./scripts/variables.sh
}

function readVariables() {
  read -p 'Enter your git user name:' GIT_USER_NAME
  read -p 'Enter your git user email:' GIT_USER_EMAIL
}

read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
echo "";
if [[ $REPLY =~ ^[Yy]$ ]]; then
  readVariables;
  clean;
	setup;
fi;

unset setup;