# WSL Debian

This project automates the installation and provisioning of the official Debian App for the Windows Subsystem for Linux.

## Automated tasks

The following tasks have been automated:

 * Installation of the Windows Subsystem for Linux
 * Installation of the official Debian App
 * Distribution Upgrade from Debian 9 (Jessie) to Debian 10 (Buster)
 * Installation of common packages
 * Configuration for all Debian users

## Installation

### 1. Clone this repository

Clone the *wsl_debian* repository to a nice place on your machine via:

```PowerShell
git clone git@github.com:countzero/wsl_debian.git
```

### 2. Execute the installation script

Execute the [`provisioning/install_wsl_debian.ps1`](https://github.com/countzero/wsl_debian/blob/master/provisioning/install_wsl_debian.ps1) PowerShell script with elevated rights.

This will install the Windows Subsystem for Linux and the official Debian App.

### 3. Set up Debian user and password

Define a Debian user and password upon the first start of the `debian` process.

**Hint:** The installation script should have launched the `debian` process automatically for you. You can always start it manually with the following:

```PowerShell
Start-Process debian
```

### 4. Excecute the provisioning script within Debian

Become the root user by executing the following within the Debian WSL context:

```Bash
sudo su -
```

Then execute the [`provisioning/provision_wsl_debian.sh`](https://github.com/countzero/wsl_debian/blob/master/provisioning/provision_wsl_debian.sh) Bash script to provision the Debian installation:

```Bash
bash /mnt/c/wsl_debian/provisioning/provision_wsl_debian.sh
```

## Uninstall

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
