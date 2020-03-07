#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Make sure this script is executed by a superuser account.
if [[ $(id -u) -ne 0 ]] ; then
    echo "This script must be executed by a superuser account (UID=0), aborting!"

    exit 1
fi

# Resolve absolute path to parent directory of this script file.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Adding ls configuration..."
yes | cp --force --verbose "${DIR}/../files/.dircolors" /root/.dircolors

echo "Adding ssh configuration..."
mkdir --parents --verbose /root/.ssh

echo "Adding bash configuration..."
yes | cp --force --verbose "${DIR}/../files/.bashrc" /root/.bashrc

echo "Adding htop configuration..."
mkdir --parents --verbose /root/.config
yes | cp --force --verbose "${DIR}/../files/htoprc" /root/.config/htoprc
