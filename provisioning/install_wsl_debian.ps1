#Requires -Version 5.0

$ErrorActionPreference = "Stop"

# Self elevate this scripts execution context.
$windowsIdentity = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent())
if (!$windowsIdentity.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

#
# This script installs the Windows Subsystem for
# Linux (WSL) and the official Debian App.
#
# https://docs.microsoft.com/en-us/windows/wsl/install

wsl.exe --install --distribution debian
