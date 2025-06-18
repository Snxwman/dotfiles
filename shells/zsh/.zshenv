#!/usr/bin/env zsh
# vim: set filetype=bash:

export HOST=${HOST}
export HISTORY_DIR="$XDG_CACHE_HOME/history"
export ZDOTDIR="$HOME/.config/.zsh/"

# The xdg, zsh, and user env files need to be loaded first, in that order.
source "$ZDOTDIR/env/xdg.env"   # Sets the XDG_{CONFIG,CACHE,DATA}_HOME vars
source "$ZDOTDIR/env/zsh.env"   # Sets the ZDOTDIR var
source "$ZDOTDIR/env/user.env"  # Sets the EDITOR var

local GEN_ENV_FILE="$ZDOTDIR/gen.env"

cat "$ZDOTDIR/env/"*.env > "$GEN_ENV_FILE"

cat "$GEN_ENV_FILE" \
    | sort \
    | uniq \
    | grep -E '^#* *export' \
    > "$GEN_ENV_FILE"

source "$GEN_ENV_FILE"
