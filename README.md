# Mathieu's dotfiles

![Preview](/screenshots/iterm2.png?raw=true)

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/matdurand/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

### Extend this repo

You have two way to extend this repo. The first is to fork it and change it to your own liking, but after forking, it will be difficult to apply new updates that I may provide.

The second way, if you are OK with the current setup but want to apply additional configuration, is to create extension files in your home folder.

If a `~/.zshrc-before` exists, it will be sourced at the beginning of the `.zshrc` file.
If a `~/.zshrc-after` exists, it will be sourced at the end of the `.zshrc` file.

### iTerm2

If you are using iTerm2, you need to import the color theme. To do so, go to iTerm2 preferences > Profiles > Colors.
In the dropdown in the bottom right corner, import and select `iterm2/mathieu-iterm2-colors.itermcolors`.

You also need to change the font in iTerm2 preferences > Profiles > Text. Click on change font and select Menlo for Powerline

## Highlights

Here is a short list of the different plugins installed and how to use them.

### Search

- CTRL+R allows you to search in the command history ![Preview search history](/screenshots/searchhistory.png?raw=true)
- CTRL+T allows you to search for a file in the current directory (or sub-directories) ![Preview search history](/screenshots/searchfiles.png?raw=true)

### Navigation

- `bd [n]` allows you to go up a number of directory. This is equivalent to doing N times `cd ..`
- `cd ...` will show you a list of all the parent folder. If you select one, it will move you in this directory ![Preview cd back](/screenshots/cdback.png?raw=true)
- [folder name], instead of tying `cd folder` you can just type the folder name to navigate into it
- `bookmark [name]` will create a bookmark in the current folder
- `jump [name]` will move you to the folder matching the bookmark `name`

### Clipboard

- `copydir` will copy the path of the current directory in the clipboard
- `copyfile [file]` will copy the content of `file` into the clipboard
- `[command] | clipboard` will pipe the command result into the clipboard

### Git

- `k` is an git enhanced version of `ls`
- many aliases:
  - `git addf`: add individual files to the index (use TAB to select the files) ![Preview git addf](/screenshots/gitaddf.png?raw=true)
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
  - `git lgp`: an interactive git history using fzf, with preview ![Preview git lgp](/screenshots/gitlog.png?raw=true)
- the default diff has been replaced with diff-so-fancy, providing a better experience

### Other

- `peco` is like grep but with interactive filtering capabilities
- `fzf` is a selection tool. You can pipe lines to it and it will allow you to select some
- `ncdu` is a better version of `du` to find out how big is a folder and sub-folder
- `htop` is a better version of top
- `bat` is a better version of `cat`. An alias is done to use `bat` when typing `cat`
- `direnv` is not a command, but an automatic process. If you enter a folder with a `.envrc` file, the variable in the file are automatically exposed. When you leave the folder, they are removed
