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

# We are importing the current Debian version details.
. /etc/os-release

echo "Switching '/etc/apt/sources.list' to Debian $VERSION_CODENAME..."

cat << EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian $VERSION_CODENAME main
deb http://deb.debian.org/debian $VERSION_CODENAME-updates main
deb http://security.debian.org/debian-security $VERSION_CODENAME-security main
deb http://ftp.debian.org/debian $VERSION_CODENAME-backports main
EOF

upgrade_current_distribution
