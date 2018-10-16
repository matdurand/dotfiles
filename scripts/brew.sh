#!/usr/bin/env bash

echo ""
echo "Installing packages using Homebrew..."
echo ""

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

#There is a bug with tab autocompletion in zsh 5.3 and 5.3.1, installing head release instead
brew install zsh
brew install zsh-history-substring-search

brew tap caskroom/fonts
brew cask install font-fira-code
brew cask install font-hack-nerd-font

brew tap homebrew/cask-fonts 
brew cask install font-menlo-for-powerline