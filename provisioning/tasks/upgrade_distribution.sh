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
upgrade_current_distribution () {

    echo "Upgrading current Debian distribition $(cat /etc/debian_version)..."

    export DEBIAN_FRONTEND=noninteractive

    apt-get --allow-releaseinfo-change update

    apt-get --yes full-upgrade

    apt-get --yes autoremove
}

STABLE_CODENAME=$(curl -s https://ftp.debian.org/debian/dists/stable/Release | grep -oP '(?<=Codename:\s)\S+')
STABLE_VERSION=$(curl -s https://ftp.debian.org/debian/dists/stable/Release | grep -oP '(?<=Version:\s)\S+')

echo "Upgrading Debian to the latest stable ${STABLE_VERSION} (${STABLE_CODENAME})."

upgrade_current_distribution

echo "Switching '/etc/apt/sources.list' to Debian $STABLE_CODENAME..."

cat << EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian $STABLE_CODENAME main
deb http://deb.debian.org/debian $STABLE_CODENAME-updates main
deb http://security.debian.org/debian-security $STABLE_CODENAME-security main
deb http://ftp.debian.org/debian $STABLE_CODENAME-backports main
EOF

upgrade_current_distribution

echo "Sucessfully upgraded to the latest stable Debian $(. /etc/os-release; echo $VERSION) distribution."
