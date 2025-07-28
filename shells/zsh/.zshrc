#!/usr/bin/env zsh
# vim: set filetype=bash:

# User defined vars (must unset in user_init_last or they will persist)
SCRIPTS="$HOME/.scripts"

PLUGINS_DIR="$ZDOTDIR/plugins"
PLUGINS=( p10k asdf wakatime ssh zoxide )
ZSH_PLUGINS_DIR="/usr/share/zsh/plugins"
ZSH_PLUGINS=( autosuggestions history-substring-search syntax-highlighting )

USER_PATH_FIRST=()
USER_FPATH_FIRST=()
USER_PATH=( $SCRIPTS $SCRIPTS/{cron,hooks,wrappers} "$HOME/.local/bin" "/opt")
USER_FPATH=( $SCRIPTS $SCRIPTS/{completions,hooks,wrappers} $ZDOTDIR/plugins )

AUTOLOAD_DIR="$ZDOTDIR/autoload"
AUTOLOAD_ALL_DIRS=()
AUTOLOAD=( colors colorize-man )

SSH_KEYS_DIR="$HOME/.ssh/keys/private"
SSH_KEYS=( dev.snxwman.github )

# Zshrc behavior options
ENABLE_PROFILING=false
UNLOAD_AFTER_INIT=true

[[ $ENABLE_PROFILING == true ]] && zmodload zsh/zprof

user_init_first() {
    setopt APPEND_HISTORY
    setopt EXTENDED_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST  # Remove duplicate commands first
    setopt HIST_FIND_NO_DUPS       # Ignore duplicate commands when searching
    setopt HIST_IGNORE_DUPS        # Ignore duplicate commands
    setopt HIST_IGNORE_SPACE       # Ignore commands starting with a space
    setopt HIST_REDUCE_BLANKS      # Remove blank lines from history
    setopt INC_APPEND_HISTORY      # Add commands in real time
}

user_init_last() {
    source "$XDG_CONFIG_HOME/.aliases/.aliases"

    # term_title -user -title
    neofetch
    cal -3

    [[ -n $(go version) ]] && go telemetry off

    unset SCRIPTS
}

init_keybinds() {
    bindkey '^A' beginning-of-line    # ctrl a
    bindkey '^E' end-of-line          # ctrl e
    bindkey '^[[1;5C' forward-word    # ctrl ->
    bindkey '^[[1;5D' backward-word   # ctrl <-
    bindkey '^R' history-search-backward 
}

init_hooks() {
    # Chpwd: Executes when the working directory changes.
    # Periodic: Executes every $PERIOD seconds, just before a prompt.
    # Precmd: Executes just before each prompt.
    # Preexec: Executes after a cmd is read, but before it is executed. 
    chpwd_functions=( asdf_tools auto_venv )
    periodic_functions=()
    precmd_functions=( term_title )
    preexec_functions=( term_title )
}

init_compinit() {
    autoload -Uz compinit promptinit
    compinit -d ~/.cache/zcompdump
    zmodload zsh/complist
    zstyle ':completion:*' menu select
    _comp_options+=(globdots)
}

init_ssh_agent() {
    eval $(ssh-agent) &> /dev/null
    for key in $SSH_KEYS; do
        ssh-add "$SSH_KEYS_DIR/$key" &> /dev/null
    done
}

init_autoloads() {
    local autoload_funcs=()

    [[ -n "$AUTOLOAD_DIR" ]] && autoload_funcs=( "$AUTOLOAD_DIR"/*(ND) $autoload_funcs )
    [[ ${#AUTOLOAD} -gt 0 ]] && autoload_funcs=( $AUTOLOAD $autoload_funcs )

    if (( ${#AUTOLOAD_ALL_DIRS} > 0 )); then
        for dir in $AUTOLOAD_ALL_DIRS; do
            autoload_funcs=( "$AUTOLOAD_ALL_DIRS"/*(ND) $autoload_funcs )
        done
    fi

    [[ ${#autoload_funcs} -gt 0 ]] && autoload -Uz $autoload_funcs
}

cleanup() {
    unset PLUGINS_DIR PLUGINS ZSH_PLUGINS_DIR ZSH_PLUGINS plugin_path plugin_fpath
    unset USER_PATH_FIRST USER_FPATH_FIRST USER_PATH USER_FPATH
    unset AUTOLOAD_DIR AUTOLOAD_ALL_DIRS AUTOLOAD autoload_funcs
    unset SSH_KEYS_DIR SSH_KEYS
    unset UNLOAD_AFTER_INIT
    unfunction user_init_first user_init_last
    unfunction init_keybinds init_hooks init_compinit 
    unfunction init_ssh_agent
    unfunction zshrc
    unfunction cleanup
}

zshrc() {
    readonly sys_path=( $path )
    readonly sys_fpath=( $fpath )
    export plugin_path=()
    export plugin_fpath=()

    user_init_first
    init_compinit

    for plugin in $PLUGINS; do
        source "$PLUGINS_DIR/.init/$plugin" init
    done

    init_keybinds

    path=( $USER_PATH_FIRST $plugin_path $USER_PATH $sys_path )
    fpath=( $USER_FPATH_FIRST $plugin_fpath $USER_FPATH $sys_fpath )

    init_autoloads
    init_hooks
    init_ssh_agent

    for plugin in $PLUGINS; do
        source "$PLUGINS_DIR/.init/$plugin" setup
    done

    for plugin in $ZSH_PLUGINS; do
        source "$ZSH_PLUGINS_DIR/zsh-$plugin/zsh-$plugin.zsh"
    done

    user_init_last
}

zshrc
typeset -U PATH path

[[ $UNLOAD_AFTER_INIT == true ]] && cleanup
[[ $ENABLE_PROFILING == true ]] && zprof
unset ENABLE_PROFILING
