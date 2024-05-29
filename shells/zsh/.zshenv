export HOST=${HOST}

# XDG Directories
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DESKTOP_DIR="$HOME/desktop"
export XDG_DOCUMENTS_DIR="$HOME/documents"
export XDG_DOWNLOAD_DIR="$HOME/downloads"

export XDG_MUSIC_DIR="$HOME/media/audio/music"
export XDG_PICTURES_DIR="$HOME/media/pictures"
export XDG_VIDEOS_DIR="$HOME/media/videos"

#export XDG_PUBLICSHARE_DIR="$HOME/cloud/public"
#export XDG_TEMPLATES_DIR="$HOME/documents/templates"

# Short Hands
local APP_CONFIG="$XDG_CONFIG_HOME/.app"
local HISTORY_DIR="$XDG_CACHE_HOME/history"
local LOCAL_GIT="$HOME/.local/software/git"

# Xorg
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# ZSH
export ZDOTDIR="$XDG_CONFIG_HOME/.zsh"

# System Environment
export NETRC="$XDG_CONFIG_HOME/.netrc"
export WGETRC="$XDG_CONFIG_HOME/.wgetrc"

# Default apps
export BROWSER="brave"
export EDITOR="nvim"
#export PAGER=""
export READER="zathura"
export SHELL="zsh"
# This gets set by the terminal app itself so it will adapt to using different terminals.
# The line is left here only for documentation on where it is actually set.
#export TERMINAL=""
#export VISUAL="code-oss"

# History files and options
export HISTFILE="$HISTORY_DIR/zsh"
export HISTSIZE="1000000000"
export SAVEHIST=$HISTSIZE

export LESSHISTFILE="$HISTORY_DIR/less"

export NODE_REPL_HISTORY="$HISTORY_DIR/node"
export NODE_REPL_HISTORY_SIZE="1000000"
export NODE_REPL_MODE="sloppy"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/js/npm/"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"

# Non-default config locations

export GNUPGHOME="$XDG_CONFIG_HOME/gnupg/"

# App specific environment variables
#export ASDF_CONFIG_FILE=""
export ASDF_DEFAULT_TOOL_VERSIONS_FILENAME=".config/asdf/tool-versions.global"
export ASDF_DIR="$LOCAL_GIT/asdf"
export ASDF_DATA_DIR="$LOCAL_GIT/asdf"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

export GH_NO_UPDATE_NOTIFIER="1"

export GIT_EDITOR="$EDITOR"

export GOPATH="$HOME/.local/"

export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
