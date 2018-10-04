# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# =============================================================================
#                                   Variables
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
# AWS
export DEFAULT_USER=`whoami`
export AWS_PROFILE=koordinator
export AWS_EB_PROFILE=koordinator

export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --color=dark,bg+:235,hl+:10,pointer:5'

# =============================================================================
#                                   Plugins
# =============================================================================

# Check if zplug is installed
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Spaceship theme
# zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

# Prezto framework
zplug "sorin-ionescu/prezto", \
  use:"init.zsh", \
  hook-build:"ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto ~/.zprezto"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#install https://github.com/belak/prezto-contrib#usage

# zsh directory history plugin (not installable with zplug)
source /Users/mathieudurand/sources/github.com/tymm/zsh-directory-history/directory-history.plugin.zsh
# Bind up/down arrow keys to navigate through your history
bindkey '\e[A' directory-history-search-backward
bindkey '\e[B' directory-history-search-forward

# Miscellaneous commands
# peco is grep on steriod
zplug "peco/peco",        as:command, from:gh-r

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, \
	use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh", as:plugin

# Enhanced cd
zplug "b4b4r07/enhancd", use:init.sh

# Bookmarks and jump
zplug "jocelynmallon/zshmarks"

# Enhanced dir list with git features
zplug "supercrabtree/k"

# Jump back to parent directory (using the bd {x} command, where x is the number of directory to go back)
zplug "tarrasch/zsh-bd"

# from oh-my-zsh
zplug "plugins/copydir",           from:oh-my-zsh
zplug "plugins/copyfile",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh
if [[ $OSTYPE = (darwin)* ]]; then
    zplug "lib/clipboard",         from:oh-my-zsh
fi

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
#zplug "zsh-users/zsh-history-substring-search", defer:3

# =============================================================================
#                                   Options
# =============================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Dont overwrite history
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt hist_ignore_space        # Ignore commands that start with space.

# =============================================================================
#                                Key Bindings
# =============================================================================

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
#bindkey "^R" history-incremental-pattern-search-backward
#bindkey "^F" history-incremental-pattern-search-forward

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# =============================================================================
#                                   Startup
# =============================================================================

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
	#the two escape sequences(a and b) are defined in iTerm keys as Shift+UP and Shift+DOWN
  bindkey "^[a" history-substring-search-up
	bindkey "^[b" history-substring-search-down
fi

if zplug check "b4b4r07/enhancd"; then
  ENHANCD_DOT_SHOW_FULLPATH=1
	ENHANCD_DISABLE_HOME=0
  ENHANCD_DOT_ARG=...
fi

# =============================================================================

# Then, source plugins and add commands to $PATH
zplug load

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
