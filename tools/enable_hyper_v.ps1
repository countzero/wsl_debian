#Requires -Version 5.0

$ErrorActionPreference = "Stop"

# Self elevate this scripts execution context.
$windowsIdentity = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent())
if (!$windowsIdentity.IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit
}

#
# We are enabling the Hyper V feature.
#
# https://stackoverflow.com/a/35812945

bcdedit /set hypervisorlaunchtype auto

Restart-Computer
