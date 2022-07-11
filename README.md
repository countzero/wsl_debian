# WSL Debian

This project automates the installation and provisioning of the official Debian app for the Windows Subsystem for Linux.

## Automated tasks

The following tasks have been automated:

 * Installation of the Windows Subsystem for Linux
 * Installation of the official Debian app
 * Distribution upgrade of Debian
 * Installation of common packages
 * Configuration of all Debian users

## Installation

### 1. Clone this repository

Clone the *wsl_debian* repository to a nice place on your machine via:

```PowerShell
git clone git@github.com:countzero/wsl_debian.git C:\wsl_debian
```

### 2. Install the Windows Subsystem for Linux and Debian

Execute the [`provisioning/install_wsl_debian.ps1`](https://github.com/countzero/wsl_debian/blob/master/provisioning/install_wsl_debian.ps1) PowerShell script:

```PowerShell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\wsl_debian\provisioning\install_wsl_debian.ps1"
```

### 3. Set up UNIX username and password

Define a UNIX username and password upon the first start of the `debian` process.

**Hint:** The installation script has launched the `debian` process automatically for you.

### 4. Provision the Debian installation

Execute the [`provisioning/provision_wsl_debian.sh`](https://github.com/countzero/wsl_debian/blob/master/provisioning/provision_wsl_debian.sh) Bash script as the `root` user within the `debian` app:

```Bash
sudo su - -c /mnt/c/wsl_debian/provisioning/provision_wsl_debian.sh
```

## Uninstall (optional)

### Uninstall the Debian App

Execute the following in a PowerShell with elevated rights to remove the Debian App:

```PowerShell
Get-AppxPackage *TheDebianProject.DebianGNULinux* | Remove-AppxPackage
```

### Disable the Windows Subsystem for Linux

Execute the following in a PowerShell with elevated rights to disable the Windows Subsystem for Linux:

```PowerShell
dism.exe /online `
         /disable-feature `
         /featurename:Microsoft-Windows-Subsystem-Linux `
         /norestart
```
