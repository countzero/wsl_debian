#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Make sure this script is executed by a superuser account.
if [[ $(id -u) -ne 0 ]] ; then
    echo "This script must be executed by a superuser account (UID=0), aborting!"

    exit 1
fi

echo "Installing packages..."

# We are using the Ubuntu PPA to get the latest version of Ansible.
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" > /etc/apt/sources.list.d/ansible.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

# We are using the official MongoDB repository to get the latest version of monogsh.
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" > /etc/apt/sources.list.d/mongodb.list
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add -

export DEBIAN_FRONTEND=noninteractive

apt-get update --allow-releaseinfo-change

apt-get --yes \
        install ansible \
                curl \
                htop \
                mongo-tools \
                mongodb-mongosh \
                openssh-client \
                postgresql-client \
                software-properties-common
