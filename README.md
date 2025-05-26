# Mathieu's dotfiles

## How to install

This is a repo to store my dotfiles. To install, checkout this in ~/dotfiles, cd into it and run `stow .`.
If you don't have GNU stow, install it using your package manager first (brew on mac)

Once stow is available, from this repo checkout folder, run
```bash
stow nvim
stow ohmyposh
stow home
stow atuin
stow wezterm
```

## The installation scripts

The `dotfiles_installer` folder contains some installation scripts.

* /dotfiles_installer/install-dependencies.sh: Install some dependencies using brew on OSX or APT on Ubuntu
* /dotfiles_installer/configure-git.sh: Set the username and email for git

## Highlights

Here is a short list of the different plugins installed and how to use them.

### Search

- CTRL+R allows you to search in the command history with Atuin database
- CTRL+T allows you to search for a file in the current directory (or sub-directories)

### Navigation

- `cd ...` will show you a list of all the parent folder. If you select one, it will move you in this directory
- [folder name], instead of tying `cd folder` you can just type the folder name to navigate into it
- `z [folder]` is using Zoxide to do fuzzy jump across folders

### Clipboard

- `copydir` will copy the path of the current directory in the clipboard
- `copyfile [file]` will copy the content of `file` into the clipboard
- `[command] | clipboard` will pipe the command result into the clipboard (osx only)

### Git

- `k` is an git enhanced version of `ls`
- many aliases:
  - `git addf`: add individual files to the index (use TAB to select the files)
  - `git switch`: show the list of recent branches to switch to
  - `git publish`: push the current branch to a branch with the same name on origin
  - `git fpush`: like `publish` but as force push
  - `git wip`: Commit everything with a message 'WIP'
  - `git undo-commit`: Undo last commit
  - `git nb [branch-name]`: Create a branch and checkout it immediately (nb = new branch)
  - `git s`: status
  - `git a`: add
  - `git co`: checkout
  - `git cm`: commit and amend
  - `git rea`: abort rebase
  - `git rec`: continue rebase
  - `git delete-merged-branches`: Delete merged branches. **THIS IS POTENTIALLY DANGEROUS. BRANCHES MERGED BUT WITH LATER COMMIT MIGHT BE DELETED**
  - `git lgp`: an interactive git history using fzf, with preview 
- the default diff has been replaced with diff-so-fancy, providing a better experience

### Other

- `peco` is like grep but with interactive filtering capabilities
- `fzf` is a selection tool. You can pipe lines to it and it will allow you to select some
- `ncdu` is a better version of `du` to find out how big is a folder and sub-folder
- `htop` is a better version of top
- `bat` is a better version of `cat`. An alias is done to use `bat` when typing `cat`
- `direnv` is not a command, but an automatic process. If you enter a folder with a `.envrc` file, the variable in the file are automatically exposed. When you leave the folder, they are removed