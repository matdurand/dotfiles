#zmodload zsh/zprof

# =============================================================================
# Provide extension point to run BEFORE the template zshrc
# =============================================================================
if [[ -s "$HOME/.zshrc-before" ]]; then
  source "$HOME/.zshrc-before"
fi

# =============================================================================
#                                   Variables
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export CLICOLOR=1
export TERM=xterm-256color
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --color=dark,fg+:214,bg+:235,hl+:10,pointer:214'

# =============================================================================
#                                   Plugins
# =============================================================================

# Check if zplug is installed
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Spaceship theme
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

# Prezto framework
zplug "sorin-ionescu/prezto", \
  use:"init.zsh", \
  hook-build:"ln -s $ZPLUG_HOME/repos/sorin-ionescu/prezto ~/.zprezto"

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Miscellaneous commands
# peco is grep on steriod
zplug "peco/peco",        as:command, from:gh-r

# Enhanced cd
zplug "babarot/enhancd", use:init.sh

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
zplug "b4b4r07/cli-finder", as:command, use:"bin/finder"
zplug "agkozak/zsh-z"

#export NVM_AUTO_USE=true
#export NVM_COMPLETION=true
#export NVM_LAZY_LOAD=true
#zplug "lukechilds/zsh-nvm"

# Starship prompt
if (( $+commands[starship] )); then eval "$(starship init zsh)"; fi

# https://github.com/wfxr/forgit
zplug 'wfxr/forgit'
export FORGIT_NO_ALIASES=true
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS='--sort=-committerdate'

# =============================================================================
#                                   Options
# =============================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=20000
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
unsetopt CORRECT                # Disable prezto utility module auto correct feature

# =============================================================================
#                                Key Bindings
# =============================================================================

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^d" end-of-line
bindkey "^s" backward-kill-line
bindkey "^w" backward-kill-word
if [[ $OSTYPE = (darwin)* ]]; then
  bindkey "^[[1;5C" forward-word
  bindkey "^[[1;5D" backward-word
fi

# =============================================================================
#                                   Aliases
# =============================================================================
if (( $+commands[htop] )); then alias top='htop'; fi
if (( $+commands[bashtop] )); then alias btop='bashtop'; fi
if (( $+commands[ncdu] )); then alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"; fi
if (( $+commands[direnv] )); then eval "$(direnv hook zsh)"; fi
if [ "$(uname 2> /dev/null)" = "Linux" ]; then
    alias open='xdg-open'
    alias clipboard="xclip -selection c"
fi

if (( $+commands[exa] )); then
  # Changing "ls" to "exa"
  alias ls='exa -al --color=always --group-directories-first' # list all by default
  alias lt='exa -aT --color=always --group-directories-first' # tree listing
  alias lm='exa -lm --color=always --sort=modified'           # sorted by date
  alias lz='exa -lm --color=always --sort=size'               # sorted by size
  alias l='exa'
  alias ll='ls'
fi

# adding flags to default commands
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias kc='kubectl'
alias cat='bat'

# bare git repo alias for dotfiles
alias config="git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias config-diff="git --git-dir=$HOME/dotfiles --work-tree=$HOME diff --cached"

# =============================================================================
#                                   Startup
# =============================================================================

# Install plugins if there are plugins that have not been installed
if [[ ! -d ~/.zplug/repos/sorin-ionescu/prezto ]]; then
  zplug install
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
  bindkey '\e[A' history-substring-search-up
  bindkey '\e[B' history-substring-search-down
fi

if zplug check "babarot/enhancd"; then
  ENHANCD_DOT_SHOW_FULLPATH=1
	ENHANCD_DISABLE_HOME=0
  ENHANCD_DOT_ARG=...
fi

# =============================================================================

# Then, source plugins and add commands to $PATH
zplug load

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# NVM
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Generic find function to locate the first match going up in the folder hierarchy
function upfind() {
  dir=`pwd`
  while [ "$dir" != "/" ]; do
    p=`find "$dir" -maxdepth 1 -name $1`
    if [ ! -z $p ]; then
      echo "$p"
      return
    fi
    dir=`dirname "$dir"`
  done
}

# Invoke Gradle wrapper
function gw() {
  GW="$(upfind gradlew)"
  if [ -z "$GW" ]; then
    echo "Gradle wrapper not found."
  else
    $GW $@
  fi
}

# Open a pull request on the current branch
gpr() {
  if [ $? -eq 0 ]; then
    github_url=`git remote -v | awk '/fetch/{print $2}' | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%'`;
    branch_name=`git symbolic-ref --short HEAD`;
    pr_url=$github_url"/compare/master..."$branch_name
    open $pr_url;
  else
    echo 'failed to open a pull request.';
  fi
}

decode_base64_url() {
  local len=$((${#1} % 4))
  local result="$1"
  if [ $len -eq 2 ]; then result="$1"'=='
  elif [ $len -eq 3 ]; then result="$1"'=' 
  fi
  echo "$result" | tr '_-' '/+' | openssl enc -d -base64
}

decode_jwt(){
   decode_base64_url $(echo -n $2 | cut -d "." -f $1) | jq .
}

# Decode JWT header
alias jwth="decode_jwt 1"

# Decode JWT Payload
alias jwtp="decode_jwt 2"

if [[ $OSTYPE != (darwin)* ]]; then
  export PATH="/home/matdurand/.linuxbrew/opt/openssl@1.1/bin:$PATH"
  fpath=($fpath "/home/matdurand/.zfunctions")
  $(brew --prefix)/opt/fzf/install
fi

# =============================================================================
# Prompt config
# =============================================================================

# Prompt config
SPACESHIP_TIME_SHOW=true
SPACESHIP_KUBECTL_SHOW=true
SPACESHIP_NODE_PREFIX="node="
SPACESHIP_NODE_SYMBOL=""
SPACESHIP_KUBECTL_PREFIX="k8s="
SPACESHIP_KUBECTL_SYMBOL=""
SPACESHIP_KUBECTL_VERSION_SHOW=false
SPACESHIP_PROMPT_ORDER=(dir git node kubectl time line_sep exit_code char)
SPACESHIP_RPROMPT_ORDER=
SPACESHIP_DIR_TRUNC=0
SPACESHIP_DIR_TRUNC_REPO=false

autoload -Uz compinit && compinit

if [[ -v KITTY_WINDOW_ID ]]; then
  # Completion for kitty
  kitty + complete setup zsh | source /dev/stdin
fi

. $(pack completion --shell zsh)

if [[ -s "$HOME/go" ]]; then
  #source ~/.gvm/scripts/gvm
  export GOPATH="$HOME/go"
  export PATH="$HOME/go/bin:$PATH"
fi

if [[ -s "$HOME/.sdkman" ]]; then
  export SDKMAN_DIR="$HOME/.sdkman"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

if [[ -s "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

if [[ -s "$HOME/.zshrc-after" ]]; then
  source "$HOME/.zshrc-after"
fi

