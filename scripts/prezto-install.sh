#!/usr/bin/env bash

echo "Creating symlink for prezto"
ln -sf ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -sf ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -sf ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -sf ~/.zprezto/runcoms/zshenv ~/.zshenv
rm -f ~/.zpreztorc
cp -f ./prezto/zpreztorc ~/.zpreztorc

zsh -c "$(curl -fsSL https://raw.githubusercontent.com/el1t/statusline/master/prezto/install)"