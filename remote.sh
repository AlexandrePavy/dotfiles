#!/usr/bin/env bash

declare -r DOTFILES_TARBALL_URL="https://github.com/AlexandrePavy/dotfiles/tarball/master"

declare dotfilesDirectory="$HOME/dotfiles"

[[ -x `command -v wget` ]] && CMD="wget --no-check-certificate -qO -"

if [ -z "$CMD" ]; then
    echo "No wget available. Aborting."
    exit 1
fi

echo "Installing dotfiles : ${dotfilesDirectory}"

if [ -e "${dotfilesDirectory}" ]; then
    read -p "This folder already exist, Are you sure to remove and continue ? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf ${dotfilesDirectory}
    else
        exit 0
    fi
fi

mkdir -p "$dotfilesDirectory"

eval "${CMD} ${DOTFILES_TARBALL_URL} | tar -xz -C ${dotfilesDirectory} --strip-components=1 &> /dev/null"

echo "Starting dotfiles"
source "$HOME/dotfiles/bootstrap.sh"
