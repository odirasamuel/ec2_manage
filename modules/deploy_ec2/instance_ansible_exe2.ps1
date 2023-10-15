<powershell>
# PowerShell Script to Install Python, pip, OpenSSH, and Ansible on Windows

# Ensure the script continues even if errors occur
$ErrorActionPreference = "Continue"

# Allow script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Ensure to use TLS1.2 as security protocol for web requests
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Install Chocolatey Package Manager
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Python and pip using Chocolatey
choco install python -y

# Refresh environment variables during this session
$env:Path += ";C:\Python39\Scripts"

# Install OpenSSH using Chocolatey
choco install openssh -y

# Use pip to Install Ansible
pip install ansible

# Confirm Installations
Write-Output "Installation Complete. Confirming installations:"

# Confirm Python installation
python --version

# Confirm pip installation
pip --version

# Confirm Ansible installation
ansible --version

# Complete
Write-Output "Script Completed"
</powershell>