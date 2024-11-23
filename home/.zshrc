#zmodload zsh/zprof

# =============================================================================
#                                   Variables
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export CLICOLOR=1

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# load cargo because we use a bunch of tools from cargo in this config
if [[ -s "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light babarot/enhancd
zinit light Aloxaf/fzf-tab

# Generate autocompletions once every 24h only
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

zinit cdreplay -q

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi


# ---- FZF -----
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

#export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --color=dark,fg+:214,bg+:235,hl+:10,pointer:214'

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

#source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ---- For GIT -----

export FORGIT_NO_ALIASES=true
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS='--sort=-committerdate'

# ---- Enhanced CD -----

export ENHANCD_ARG_DOUBLE_DOT=...

# =============================================================================
#                                   Options
# =============================================================================

# History
HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=$HISTSIZE
HISTDUP=erase

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
zstyle ':completion:*' menu no  # Disable completion menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use LS_COLORS for completion colors
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# =============================================================================
#                                Key Bindings
# =============================================================================

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^d" end-of-line
bindkey "^s" backward-kill-line
bindkey "^w" backward-kill-word
bindkey '\e[A' history-substring-search-up
bindkey '\e[B' history-substring-search-down
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

# adding flags to default commands
alias ls="eza --long -bF --group-directories-first"
alias ll="eza --long -a --group-directories-first"
alias lmod="eza --long --modified --sort=modified -r"
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias kc='kubectl'

# ---- Zoxide (better cd) ----
_ZO_RESOLVE_SYMLINKS=1
eval "$(zoxide init zsh)"

# =============================================================================

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

eval "$(atuin init zsh --disable-up-arrow)"

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

atuin_delete(){
  local toDelete=$1
  atuin search --search-mode fulltext $toDelete
  if read -q "choice?Press Y/y to delete all these: "; then
    atuin search --delete --search-mode fulltext $toDelete
  fi
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
# PATHs
# =============================================================================
if [[ -s "$HOME/go" ]]; then
  #source ~/.gvm/scripts/gvm
  export GOPATH="$HOME/go"
  export PATH="$HOME/go/bin:$PATH"
fi

#if [[ -s "$HOME/.sdkman" ]]; then
#  export SDKMAN_DIR="$HOME/.sdkman"
#  # this needs to be at the end otherwise it re-generation autocompletions a second time, which is slow
#  source "$HOME/.sdkman/bin/sdkman-init.sh"
#fi

# Everything in zshrc-after is machine specific and is not in dotfiles source control
if [[ -s "$HOME/.zshrc-after" ]]; then
  source "$HOME/.zshrc-after"
fi

#For zsh profiling
#zprof > ~/.zprof.log 