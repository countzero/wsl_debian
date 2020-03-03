#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Make sure this script is executed by a superuser account.
if [[ $(id -u) -ne 0 ]] ; then
    echo "This script must be executed by a superuser account (UID=0), aborting!"

    exit 1
fi

echo "Installing common packages..."

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get --yes \
        install curl \
                ssh-client \
                htop \
                software-properties-common
