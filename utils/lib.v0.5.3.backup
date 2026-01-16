#!/usr/bin/env bash
# shellcheck disable=SC2034

# Find repo name and script name from
# shinokada/gitstart
# raylee/tldr-sh-client tldr
# https://github.com/raylee/tldr-sh-client.git tldr
# https://github.com/raylee/tldr-sh-client tldr
repo_script() {
    local link_arg script_arg
    link_arg=$1
    script_arg=$2
    slash_num=$(echo "$link_arg" | grep -o "/" | wc -l)
    if [[ $link_arg =~ "@" ]]; then
        # if link_arg has @ it is like git@github.com:shinokada/cleanit.git
        echo "Please use URL or https, not ssh." >&2
        exit 1
    fi
    if [[ -z $script_arg ]]; then
        # check if it has a / if not exit
        if ((slash_num < 1)); then
            echo "Not valid parameter." >&2
            exit 1
        fi
        # no $2 so it must be the form of
        # shinokada/gitstart has the same repo_name and script_name
        # or https://github.com/shinokada/cleanit
        # or https://github.com/shinokada/cleanit.git
        git_user=$(basename "${link_arg%/*}")
        repo_name=$(basename "${link_arg##*/}" .git)
        # repo_name="${link_arg##*/}"
        script_name=$(basename "${link_arg##*/}" .git)
        # script_name="${link_arg##*/}"
        if [[ $link_arg =~ https://github.com/ ]]; then
            repo_link="$link_arg"
        else
            repo_link="https://github.com/${link_arg}"
        fi
    else
        if (("$slash_num" == 1)); then
            # one / so it must be raylee/tldr-sh-client tldr
            git_user="${link_arg%/*}"
            repo_name="${link_arg##*/}"
            script_name="$script_arg"
            repo_link="https://github.com/${link_arg}"
        else
            # it must be https://github.com/raylee/tldr-sh-client.git tldr
            git_user=$(basename "${link_arg%/*}")
            repo_name=$(basename "$link_arg" .git)
            script_name="$script_arg"
            repo_link="$link_arg"
        fi
    fi
}

# Create a awesome dir if it doesn't, exit 1.
checkOrmkdir() {
    if [[ -z $1 ]]; then
        echo "Specify the directory." >&2
        exit 1
    fi
    if [[ ! -d $1 ]]; then
        mkdir "$1"
        echo "$1 directory is created." >&1
        return 0
    else
        return 0
    fi
}

# Return 0 or 1 depending a dir exists or not
checkDir() {
    if [[ -d $1 ]]; then
        # since 1 is true return 1
        echo 1
    else
        # 0 is false return 0
        # echo "$1 doesn't exist." >&2
        echo 0
    fi
}

# Return 0 or 1 depending a file exists or not
# Use: checkDir /path/to/file
checkFile() {
    if [[ -f $1 ]]; then
        # return 0 because there is a file
        return 0
    else
        # return 1 because there is no file
        return 1
    fi
}

# fn_list list installed symlinks from bin dir
symlink_names() {
    # ls "$awesome_dir"
    find "$1" -type l -exec basename -a {} +
    # find "$1" -type l
    exit
}

# this check a symlink in a bin dir
check_link() {
    if [[ -L "$2/$1" ]]; then
        # echo "It's a link!"
        return 0
    else
        echo "There is no $1 link in $2 dir."
        exit 1
    fi
}

# Outputs the path to the src
src_path() {
    src_path=$1
    echo "${src_path%/*}"
}

# Return 0 or 1 depending a command exists or not
check_cmd() {
    if [ ! "$(command -v "$1")" ]; then
        echo "Please install $1" >&2
        exit 1
    fi
}

# ###### No test yet

# check if $1 is in the alias_names or symlink_names
alias_check() {
    if type "$1"; then
        # echo "You already have that command." >&2
        return 1
    else
        # echo "Good. Because there is no similar command"
        return 0
    fi
}

# "${awesome_dir}" "${repo_name}" "${script_name}" "${bin_dir}"
# Create a symlink in bin. repo_name and file_name can be different
create_symlink() {
    # add a symlink
    ln -sf "$1/$2/$3" "$4/$3"
    echo "Created a symlink."
    return 0
}

# "${awesome_dir}" "${repo_name}" "${script_name}" "${bin_dir}" "alias_name"
create_alias() {
    # add a symlink
    ln -sf "$1/$2/$3" "$4/$5"
    echo "Created a symlink."
    return 0
}

same_src_path() {
    src_path=$1
    bin_dir=$2
    find "$bin_dir" -type l -ilname "*${src_path}*" | wc -l
}

open_url() {
    python -m webbrowser https://github.com/shinokada/awesome
}

show_symlinks() {
    ls -l "$HOME"/bin
}

first() {
    item=$1
    echo "${item%/*}"
}

second() {
    item=$1
    echo "${item##*/}"
}

# Checks a symlink in a bin dir
# Use: no_symlink "my-link" "$bin_dir"
no_symlink() {
    if [[ -L "$2/$1" ]]; then
        # return 1 because there is a symlink
        return 1
    else
        # return 0 because there is no symlink
        return 0
    fi
}

# return the number of slashes
# Use: slashes /path/name
slashes() {
    echo "$1" | grep -o "/" | wc -l | tr -d '[:space:]'
}

# Fonts
ESC=$(printf '\033')
RESET="${ESC}[0m"

BOLD="${ESC}[1m"
FAINT="${ESC}[2m"
ITALIC="${ESC}[3m"
UNDERLINE="${ESC}[4m"
BLINK="${ESC}[5m"
FAST_BLINK="${ESC}[6m"
REVERSE="${ESC}[7m"
CONCEAL="${ESC}[8m"
STRIKE="${ESC}[9m"

GOTHIC="${ESC}[20m"
DOUBLE_UNDERLINE="${ESC}[21m"
NORMAL="${ESC}[22m"
NO_ITALIC="${ESC}[23m"
NO_UNDERLINE="${ESC}[24m"
NO_BLINK="${ESC}[25m"
NO_REVERSE="${ESC}[27m"
NO_CONCEAL="${ESC}[28m"
NO_STRIKE="${ESC}[29m"

BLACK="${ESC}[30m"
RED="${ESC}[31m"
GREEN="${ESC}[32m"
YELLOW="${ESC}[33m"
BLUE="${ESC}[34m"
MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m"
WHITE="${ESC}[37m"
DEFAULT="${ESC}[39m"

BG_BLACK="${ESC}[40m"
BG_RED="${ESC}[41m"
BG_GREEN="${ESC}[42m"
BG_YELLOW="${ESC}[43m"
BG_BLUE="${ESC}[44m"
BG_MAGENTA="${ESC}[45m"
BG_CYAN="${ESC}[46m"
BG_WHITE="${ESC}[47m"
BG_DEFAULT="${ESC}[49m"

# how to use it
# printf "${BOLD}%s${RESET}\n" 'BOLD'
# printf "${UNDERLINE}%s${RESET}\n" 'UNDERLINE'
# printf "${ITALIC}%s${RESET}\n" 'ITALIC'
# printf "${UNDERLINE}${ITALIC}%s${RESET}\n" 'Underline ITALIC'

# Usage: bannerColor "my title" "red" "*"
function bannerColor() {
    case ${2} in
    black)
        color=0
        ;;
    red)
        color=1
        ;;
    green)
        color=2
        ;;
    yellow)
        color=3
        ;;
    blue)
        color=4
        ;;
    magenta)
        color=5
        ;;
    cyan)
        color=6
        ;;
    white)
        color=7
        ;;
    *)
        echo "color is not set"
        exit 1
        ;;
    esac

    local msg="${3} ${1} ${3}"
    local edge=$(echo "${msg}" | sed "s/./${3}/g")
    tput setaf ${color}
    tput bold
    echo "${edge}"
    echo "${msg}"
    echo "${edge}"
    tput sgr 0
    echo
}