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

# Add configuration for every user to their specific home directory.
user_directories="/root/ /home/*/"

for user_directory in $user_directories ;
do

    user=$(basename "${user_directory}")

    echo "Adding configuration for the user '${user}'..."

    echo "Adding ls configuration..."
    runuser "${user}" -c "yes | cp -f -v \"${DIR}/../files/.dircolors\" \"${user_directory}.dircolors\""

    echo "Adding ssh configuration..."
    runuser "${user}" -c "mkdir -p -v \"${user_directory}.ssh\""
    runuser "${user}" -c "yes | cp -f -v \"${DIR}/../files/ssh.config\" \"${user_directory}.ssh/config\""

    echo "Adding bash configuration..."
    runuser "${user}" -c "yes | cp -f -v \"${DIR}/../files/.bashrc\" \"${user_directory}.bashrc\""

    echo "Adding htop configuration..."
    runuser "${user}" -c "mkdir -p -v \"${user_directory}.config/htop\""
    runuser "${user}" -c "yes | cp -f -v \"${DIR}/../files/htoprc\" \"${user_directory}.config/htop/htoprc\""

done
