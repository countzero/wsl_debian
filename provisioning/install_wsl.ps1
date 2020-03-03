
# https://docs.microsoft.com/en-us/windows/wsl/wsl2-install

dism.exe /online `
         /enable-feature `
         /featurename:Microsoft-Windows-Subsystem-Linux `
         /all `
         /norestart

dism.exe /online `
         /enable-feature `
         /featurename:VirtualMachinePlatform `
         /all `
         /norestart

# https://docs.microsoft.com/en-us/windows/wsl/install-manual

curl.exe -L -o "${env:TEMP}\Debian.appx" https://aka.ms/wsl-debian-gnulinux

Add-AppxPackage "${env:TEMP}\Debian.appx"
