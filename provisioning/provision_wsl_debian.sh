#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Resolve absolute path to parent directory of this script file.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "Provisioning WSL Debian App..."

. "${DIR}/tasks/upgrade_to_debian_buster.sh"
. "${DIR}/tasks/install_packages.sh"
. "${DIR}/tasks/add_configuration.sh"
