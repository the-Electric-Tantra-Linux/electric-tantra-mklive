#!/bin/env bash
################################################################################
## .profile ####################################################################
################################################################################
## This file setsenvironmental variables available across the shells installed on
## the system. Edit with care
################################################################################
## Config Directory
################################################################################

## Dotfiles Location ###########################################################

for file in $(
    find "$HOME"/.xorg-configs -name '*.config.sh'
); do
    source "$file"
done

# shellcheck source=/dev/null
source "$HOME"/.aliases



# Because this comes up more often than is natural but will not clear any other way thanks to ccache
export CC="gcc"
export NO_AT_BRIDGE=1


