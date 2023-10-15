<powershell>
# Ensure the Windows instance is set up for WinRM (Windows Remote Management) which is required for Ansible.
# The commands below set up HTTPS listeners for WinRM. Ensure that the security group for the instance allows traffic on the configured port.

# Enable WinRM
Enable-PSRemoting -Force

# Set up HTTPS listener
New-SelfSignedCertificate -DnsName $env:COMPUTERNAME -CertStoreLocation Cert:\LocalMachine\My
winrm create winrm/config/Listener?Address=*+Transport=HTTPS `@`{Hostname=`"$env:COMPUTERNAME`"`; CertificateThumbprint=`"(Get-ChildItem -Path Cert:\LocalMachine\My | Where-Object {$_.Subject -match $env:COMPUTERNAME}).Thumbprint`"}

# Configure WinRM
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/winrs '@{AllowRemoteShellAccess="true"}'

# Set execution policy to allow script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Ansible using Chocolatey
choco install ansible -y

# Complete
Write-Output "Ansible Installation Complete"
</powershell>