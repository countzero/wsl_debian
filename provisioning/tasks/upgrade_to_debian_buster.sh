#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Make sure this script is executed by a superuser account.
if [[ $(id -u) -ne 0 ]] ; then
    echo "This script must be executed by a superuser account (UID=0), aborting!"

    exit 1
fi

#
# Automatically upgrades the current distribution.
#
# https://debian-handbook.info/browse/stable/sect.automatic-upgrades.html
#
upgrade_current_distribution () {
    echo "Upgrading Debian $(cat /etc/debian_version)..."

    export DEBIAN_FRONTEND=noninteractive

    apt-get update --allow-releaseinfo-change

    apt-get --yes \
            --option Dpkg::Options::="--force-confdef" \
            --option Dpkg::Options::="--force-confold" \
            dist-upgrade

    apt-get --yes autoremove
}

upgrade_current_distribution

echo "Switching '/etc/apt/sources.list' to Debian Buster..."

# https://wiki.debian.org/SourcesList#Example_sources.list
cat << EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian buster main
deb-src http://deb.debian.org/debian buster main
deb http://security.debian.org/debian-security buster/updates main
deb-src http://security.debian.org/debian-security buster/updates main
deb http://deb.debian.org/debian buster-updates main
deb-src http://deb.debian.org/debian buster-updates main
EOF

upgrade_current_distribution
