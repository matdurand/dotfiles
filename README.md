#Mathieu's dotfiles

![Preview](/dotfiles_screenshots/iterm2.png?raw=true)
(iTerm preview on OSX)

# Bare git repo

This is a repo to store my dotfiles. It's configured as a bare git repo.
*** DO NOT CLONE THIS DIRECTLY USING A STANDARD GIT CLONE ***

The creation of the bare repo was done as follow:

```zsh
mkdir $HOME/dotfiles
git init --bare $HOME/dotfiles
alias config='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```

On an existing system, to clone this, you would do
```zsh
git clone --bare git@github.com:matdurand/dotfiles.git ~/dotfiles
alias config='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
cd ~
config checkout
```

The alias is added to the .zshrc

## Basic usage, to add a dotfileto the repo and commit:

```
config add /path/to/file
config commit -m "A short message"
config push
```

Using the `config` alias is like using git, but it uses the bare git repo created earlier. The config command allows to add any file to the git repo for safe keeping. Since the repo is basically the home directory, you can edit in place and use the `config` command to add the changes to the git repo.


# The installation scripts

The `dotfiles_installer` folder contains some installation scripts.

* /dotfiles_installer/install-dependencies.sh: Install some dependencies using brew on OSX or APT on Ubuntu
* /dotfiles_installer/configure-git.sh: Set the username and email for git
* /dotfiles_installer/install-prezto.sh: Perform the installation and setup for prezto

# Cleanup

To clean, perform `rm -rf ~/.zplug`, which will remove the zplug dependencies.

You will have to remove the dependencies manually.

# OSX - iTerm2

If you are using iTerm2, you need to import the color theme. To do so, go to iTerm2 preferences > Profiles > Colors.
In the dropdown in the bottom right corner, import and select `iterm2/mathieu-iterm2-colors.itermcolors`.

You also need to change the font in iTerm2 preferences > Profiles > Text. Click on change font and select Menlo for Powerline

# Highlights

Here is a short list of the different plugins installed and how to use them.

## Search

- CTRL+R allows you to search in the command history ![Preview search history](/dotfiles_screenshots/searchhistory.png?raw=true)
- CTRL+T allows you to search for a file in the current directory (or sub-directories) ![Preview search history](/dotfiles_screenshots/searchfiles.png?raw=true)

## Navigation

- `bd [n]` allows you to go up a number of directory. This is equivalent to doing N times `cd ..`
- `cd ...` will show you a list of all the parent folder. If you select one, it will move you in this directory ![Preview cd back](/dotfiles_screenshots/cdback.png?raw=true)
- [folder name], instead of tying `cd folder` you can just type the folder name to navigate into it
- `bookmark [name]` will create a bookmark in the current folder
- `jump [name]` will move you to the folder matching the bookmark `name`

## Clipboard

- `copydir` will copy the path of the current directory in the clipboard
- `copyfile [file]` will copy the content of `file` into the clipboard
- `[command] | clipboard` will pipe the command result into the clipboard (osx only)

## Git

- `k` is an git enhanced version of `ls`
- many aliases:
  - `git addf`: add individual files to the index (use TAB to select the files) ![Preview git addf](/dotfiles_screenshots/gitaddf.png?raw=true)
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
  - `git lgp`: an interactive git history using fzf, with preview ![Preview git lgp](/dotfiles_screenshots/gitlog.png?raw=true)
- the default diff has been replaced with diff-so-fancy, providing a better experience

## Other

- `peco` is like grep but with interactive filtering capabilities
- `fzf` is a selection tool. You can pipe lines to it and it will allow you to select some
- `ncdu` is a better version of `du` to find out how big is a folder and sub-folder
- `htop` is a better version of top
- `bat` is a better version of `cat`. An alias is done to use `bat` when typing `cat`
- `direnv` is not a command, but an automatic process. If you enter a folder with a `.envrc` file, the variable in the file are automatically exposed. When you leave the folder, they are removed