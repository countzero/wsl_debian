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
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367

export DEBIAN_FRONTEND=noninteractive

apt-get update --allow-releaseinfo-change

apt-get --yes \
        install curl \
                openssh-client \
                htop \
                mongo-tools \
                software-properties-common \
                ansible
