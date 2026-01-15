#!/usr/bin/env bash
# Bash completion script for awesome package manager
# Source this file or copy to your completion directory

_awesome_completion() {
    local cur prev commands
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Main commands
    commands="install rm update ls link unlink links alias push doctor info stats export import url --help --version -h -v"
    
    # Handle command-specific completions
    case "${prev}" in
        install)
            # No completion for install (requires GitHub URL)
            return 0
            ;;
        rm|info|unlink)
            # Complete with installed package names
            local packages
            packages=$(awesome ls 2>/dev/null)
            COMPREPLY=( $(compgen -W "${packages}" -- ${cur}) )
            return 0
            ;;
        update)
            # Add --all flag for update
            COMPREPLY=( $(compgen -W "--all $(awesome ls 2>/dev/null)" -- ${cur}) )
            return 0
            ;;
        export|import)
            # Complete with filenames
            COMPREPLY=( $(compgen -f -- ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac
    
    # Default: complete with commands
    COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
    return 0
}

# Register the completion function
complete -F _awesome_completion awesome
