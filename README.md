# Mathieu's dotfiles

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

### Set additional variables

There is two way to add new variables. The first one is before launching bootstrap.sh. Create a file named `.additional-variables`
and add some `EXPORT var=value`. Each line will be added to the `.zprofile` file.

If you want to add variables after the installation, just add them manually to `.zprofile` file. Be sure to copy them to the `.additional-variables` file to make sure they are not overwritten on your next install.

## iTerm2

If you are using iTerm2, you need to import the color theme. To do so, go to iTerm2 preferences > Profiles > Colors.
In the dropdown in the bottom right corner, import and select `iterm2/mathieu-iterm2-colors.itermcolors`.

You also need to change the font in iTerm2 preferences > Profiles > Text. Click on change font and select Menlo for Powerline
