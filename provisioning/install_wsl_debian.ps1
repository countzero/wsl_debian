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
# https://docs.microsoft.com/en-us/windows/wsl/wsl2-install
# https://docs.microsoft.com/en-us/windows/wsl/install-manual
# https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6
#

dism.exe /online `
         /enable-feature `
         /featurename:Microsoft-Windows-Subsystem-Linux `
         /all `
         /norestart

curl.exe --location `
         --progress-bar `
         --output "${env:TEMP}\Debian.appx" `
         https://aka.ms/wsl-debian-gnulinux

Add-AppxPackage "${env:TEMP}\Debian.appx"

Start-Process debian
