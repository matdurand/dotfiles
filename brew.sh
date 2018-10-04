#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

brew install zsh
brew install zsh-history-substring-search
brew install git
brew install awscli
brew install gradle
brew install nvm

brew tap caskroom/fonts
brew cask install font-fira-code
brew cask install font-hack-nerd-font

brew tap homebrew/cask-fonts 
brew cask install font-menlo-for-powerline