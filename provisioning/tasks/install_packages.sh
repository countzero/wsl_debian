#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Make sure this script is executed by a superuser account.
if [[ $(id -u) -ne 0 ]] ; then
    echo "This script must be executed by a superuser account (UID=0), aborting!"

    exit 1
fi

echo "Installing packages..."

# We are using the official MongoDB repository to get the latest version of monogsh.
wget -qO- "https://www.mongodb.org/static/pgp/server-5.0.asc" | \
gpg --batch --yes --dearmor -o /usr/share/keyrings/mongodb-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/mongodb-archive-keyring.gpg] http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" > /etc/apt/sources.list.d/mongodb.list

export DEBIAN_FRONTEND=noninteractive

apt-get update --allow-releaseinfo-change

apt-get --yes \
        install python3 \
                python3-pip \
                curl \
                htop \
                mongodb-mongosh \
                openssh-client \
                postgresql-client \
                software-properties-common

pip3 install ansible
