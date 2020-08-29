#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Install command-line tools using Homebrew.

  # Make sure we’re using the latest Homebrew.
  brew update

  # Save Homebrew’s installed location.
  BREW_PREFIX=$(brew --prefix)

  #There is a bug with tab autocompletion in zsh 5.3 and 5.3.1, installing head release instead
  brew install zsh
  brew install zsh-history-substring-search

  brew tap homebrew/cask-fonts
  brew cask install font-fira-code
  brew cask install font-hack-nerd-font
  brew cask install font-menlo-for-powerline

  brew install htop
  brew install diff-so-fancy
  brew install ncdu
  brew install httpie
  brew install tree

  brew install fd
  brew install ripgrep
  brew install exa
  brew install awscli
  brew install nvm
else

  sudo apt-get install zsh fonts-firacode htop ripgrep fd-find libz-dev bashtop vim emacs rename ulauncher httpie ncdu xclip xsel
  sudo apt-get install build-essential curl file git ttf-mscorefonts-installer libaio1 jq

  #Installing Rust-Cargo
  curl https://sh.rustup.rs -sSf | sh
  ##Rust packages
  cargo install exa
  cargo install starship

  #Node modules (via NVM)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  nvm install 10
  npm install -g diff-so-fancy
  npm install -g spaceship-prompt
fi