#!/bin/zsh

# Uncomment for profiling
#zmodload zsh/zprof

# Key binds
bindkey '^A' beginning-of-line    # ctrl a
bindkey '^E' end-of-line          # ctrl e
bindkey '^[[1;5C' forward-word    # ctrl ->
bindkey '^[[1;5D' backward-word   # ctrl <-

autoload -U colors && colors

# Add custom paths
local LOCAL_SOFTWARE="$HOME/.local/software"
path=(
    "$LOCAL_SOFTWARE/bin"
    $path
)

local SCRIPTS="$HOME/.scripts"
fpath=(
    "$SCRIPTS"
    "$SCRIPTS/hooks"
    "$SCRIPTS/wrappers"
    "$SCRIPTS/yt-dlp"
    $fpath
)

# asdf config
source ${ASDF_DIR}/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

# Make sure path and fpath arrays are unique
typeset -U path fpath

# Auto-completions
autoload -Uz compinit promptinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*' menu select

zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -Uz cd edit extract

chpwd_functions=()     # Executes when the working directory changes.
periodic_functions=()  # Executes every $PERIOD seconds, just before a prompt.
precmd_functions=()    # Executes just before each prompt.
preexec_functions=()   # Executes after a cmd is read, but before it is executed.

# On sourcing .zshenv again:
# Without resourcing .zshenv `HISTFILE` gets set to "$ZDOTDIR/.zsh_history" instead
# of "$XDG_CACHE_HOME/.zsh/.zsh_history", as specified in ~/.config/zsh/.zshenv
source "$XDG_CONFIG_HOME/.zsh/.zshenv"
source "$XDG_CONFIG_HOME/.aliases/.aliases"
source "$XDG_CONFIG_HOME/.prompt"

# History options
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST  # Remove duplicate commands first
setopt HIST_FIND_NO_DUPS       # Ignore duplicate commands when searching
setopt HIST_IGNORE_DUPS        # Ignore duplicate commands
setopt HIST_IGNORE_SPACE       # Ignore commands starting with a space
setopt HIST_REDUCE_BLANKS      # Remove blank lines from history
setopt INC_APPEND_HISTORY      # Add commands in real time

# Colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Pretty terminal login info
neofetch
cal -3

# Enable zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  # Must be the last line

# Uncomment for profiling
#zprof
