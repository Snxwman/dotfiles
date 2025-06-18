#!/usr/bin/env zsh
# vim: set filetype=bash:

man() {
    local -A less_termcap
    local -a environment
    local k v

    colors
    
    # bold & blinking mode
    less_termcap[mb]="${fg_bold[red]}"
    less_termcap[md]="${fg_bold[green]}"
    less_termcap[me]="${reset_color}"
    # standout mode
    less_termcap[so]="${fg[black]}${bg_bold[cyan]}"
    less_termcap[se]="${reset_color}"
    # underlining
    less_termcap[us]="${fg_bold[blue]}"
    less_termcap[ue]="${reset_color}"

    # Convert associative array to plain array of NAME=VALUE items.
    for k v in "${(@kv)less_termcap}"; do
        environment+=( "LESS_TERMCAP_${k}=${v}" )
    done

    environment+=( "GROFF_NO_SGR=1" )
    # Prefer `less` whenever available
    [[ "$PAGER" != "less" && -n $(less --version) ]] \
        && environment+=( "PAGER=less" )

    command env $environment man "$@"
}
