#!/bin/bash

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
#                                Print Statement                               #
# ---------------------------------------------------------------------------- #
# Assign Terminal Color Variables
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"
# --------------------------------------------------- #
# Statement providing color to the stdout
print() {
    case "$1" in
    t | title)
        shift
        printf "%s\n" "${sb}${cg}[###]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    s | step)
        shift
        printf "%s\n" "${sb}${cm}[===]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    e | error)
        shift
        printf "%s\n" "${sb}${cr}[!!!]$*${sn}" | tee -a /tmp/install-log.txt
        exit 1
        ;;
    w | warning)
        shift
        printf "%s\n" "${sb}${cy}[:::]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    *)
        printf '%s\n' "$*" | tee -a /tmp/install-log.txt
        ;;
    esac
}
# --------------------------------------------------- #
ask() {
    local prompt default reply

    if [[ ${2:-} = 'Y' ]]; then
        prompt='Y/n'
        default='Y'
    elif [[ ${2:-} = 'N' ]]; then
        prompt='y/N'
        default='N'
    else
        prompt='y/n'
        default=''
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read -r reply </dev/tty

        # Default?
        if [[ -z $reply ]]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
        Y* | y*) return 0 ;;
        N* | n*) return 1 ;;
        esac

    done
}

# --------------------------------------------------- #
echo ""
print t "This script per default builds a customized Electric Tantra Linux ISO preset with the Electric Tantra Linux configurations. You can change some aspects of it, if you edit the package list(s) and/or provide your own dotfiles."
print t "This script utilizes electric-tantra-mklive, which is the official tool the Electric Tantra Linux Team provides ISOs"
if ask "Do you want to continue?"; then
    echo "continuing."
else
    exit
fi

CMD=""
# --------------------------------------------------- #
#Architecture
CMD="${CMD} -a x86_64"

# --------------------------------------------------- #
#Dotfiles
CMD="${CMD} -I ./includeDir"

#keymap
CMD="${CMD} -k us"

# --------------------------------------------------- #
#repositories
CMD="${CMD} -r https://repo-us.voidlinux.org/current/nonfree -r https://repo-us.voidlinux.org/current/multilib -r https://repo-us.voidlinux.org/current/multilib/nonfree -r $HOME/void-packages/hostdir/binpkgs"

package_list_final=$(<packages-include)
CMD="sudo ./mklive.sh ${CMD} -p '${package_list_final}'"
# --------------------------------------------------- #
echo ""
print t "this is the final command:"
echo "${CMD}"
if ask "Are you sure everything is correct?"; then
    print w "building the live image"
    cd electric-tantra-mklive
    eval $CMD
else
    echo "Aborted"
fi
# --------------------------------------------------- #
