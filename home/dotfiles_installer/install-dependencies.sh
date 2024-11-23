#!/usr/bin/env bash

#Installing Rust-Cargo
curl https://sh.rustup.rs -sSf | sh
source "$HOME/.cargo/env"

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
  brew install --cask font-fira-code
  brew install --cask font-fira-code-nerd-font
  brew install --cask font-hack-nerd-font
  brew install --cask font-menlo-for-powerline

  brew install jandedobbeleer/oh-my-posh/oh-my-posh

  brew install htop
  brew install ncdu
  brew install httpie
  brew install tree
  brew install fzf
  brew install forgit
  brew install stow

  brew install fd
  brew install ripgrep

  brew install kubectl
  brew install protobuf

  brew install go
  brew install zsh

  brew install gnupg
  brew install --cask gpg-suite

else

  sudo apt-get install zsh fonts-firacode htop ripgrep fd-find libz-dev bashtop vim emacs rename ulauncher httpie ncdu xclip xsel
  sudo apt-get install build-essential curl file git ttf-mscorefonts-installer libaio1 jq fzf

  #Installing auto-cpufreq for power management
  sudo snap install auto-cpufreq
  sudo auto-cpufreq --install

  curl -s https://ohmyposh.dev/install.sh | bash -s

fi

##Rust packages
cargo install eza
cargo install git-delta
cargo install bat
cargo install zoxide
cargo install atuin