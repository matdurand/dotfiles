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

brew install htop
brew install diff-so-fancy
brew install ncdu
brew install direnv
brew install httpie
brew install tree

#https://dev.to/_darrenburns/10-tools-to-power-up-your-command-line-4id4?utm_source=Newsletter+Subscribers&utm_campaign=d83390372e-EMAIL_CAMPAIGN_2019_01_07_06_59&utm_medium=email&utm_term=0_d8f11d5d1e-d83390372e-154749685
brew install fd
brew install ripgrep
brew install exa