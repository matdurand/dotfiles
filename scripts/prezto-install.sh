#!/usr/bin/env bash

echo "Creating symlink for prezto"
ln -sf ~/.zprezto/runcoms/zprofile ~/.zprofile
ln -sf ~/.zprezto/runcoms/zlogin ~/.zlogin
ln -sf ~/.zprezto/runcoms/zlogout ~/.zlogout
ln -sf ~/.zprezto/runcoms/zshenv ~/.zshenv
rm -f ~/.zpreztorc
cp -f ./prezto/zpreztorc ~/.zpreztorc

(cd ~/.zprezto && git clone --recurse-submodules https://github.com/belak/prezto-contrib contrib)

#zsh -c "$(curl -fsSL https://raw.githubusercontent.com/el1t/statusline/master/prezto/install)"