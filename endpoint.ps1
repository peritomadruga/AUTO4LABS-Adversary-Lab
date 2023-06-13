# Enable verbose output
$VerbosePreference = "Continue"

# Download Sysmon.zip
Write-Verbose "Downloading Sysmon.zip..."
Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Sysmon.zip" -OutFile "C:\Sysmon.zip"

# Extract Sysmon
Write-Verbose "Extracting Sysmon..."
Expand-Archive -Path 'C:\Sysmon.zip' -DestinationPath 'C:\Sysmon' -Force

# Delete Sysmon.zip
Write-Verbose "Deleting Sysmon.zip..."
Remove-Item -Path 'C:\Sysmon.zip' -Force

# Download sysmonconfig-export.xml
Write-Verbose "Downloading sysmonconfig-export.xml..."
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile "C:\sysmonconfig-export.xml"

# Execute Sysmon with sysmonconfig-export.xml
Write-Verbose "Executing Sysmon with sysmonconfig-export.xml..."
Start-Process -FilePath 'C:\Sysmon\sysmon64.exe' -ArgumentList '-accepteula', '-i', 'C:\sysmonconfig-export.xml' -Wait

# Update existing Sysmon configuration
Write-Verbose "Updating existing Sysmon configuration..."
Start-Process -FilePath 'C:\Sysmon\sysmon64.exe' -ArgumentList '-c', 'C:\sysmonconfig-export.xml' -Wait

# Disable Microsoft Defender Real-Time Protection
Write-Verbose "Disabling Microsoft Defender Real-Time Protection..."
Set-MpPreference -DisableRealtimeMonitoring $true

# Install AtomicRedTeam - Invoke-Atomic
Write-Verbose "Installing AtomicRedTeam..."
IEX (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicredteam.ps1' -UseBasicParsing).Content
Install-AtomicRedTeam -getAtomics

# Import the Module - Invoke-Atomic
Write-Verbose "Importing AtomicRedTeam module..."
Import-Module -Name 'C:\AtomicRedTeam\invoke-atomicredteam\Invoke-AtomicRedTeam.psd1' -Force

# Download Wazuh Agent for Windows
Write-Verbose "Downloading Wazuh Agent for Windows..."
Invoke-WebRequest -Uri 'https://packages.wazuh.com/4.x/windows/wazuh-agent-4.4.3-1.msi' -OutFile 'C:\wazuh-agent-4.4.3-1.msi'

# Execute Wazuh Agent installer
Write-Verbose "Executing Wazuh Agent installer..."
Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i', 'C:\wazuh-agent-4.4.3-1.msi', '/qn', 'WAZUH_MANAGER=192.168.56.200' -Wait
Start-Service -Name 'WazuhSvc'

# Print message
Write-Host "WINDOWS SERVER 2019 IS READY!"






# # Enable verbose output
# $VerbosePreference = "Continue"

# # Download Sysmon.zip
# Write-Verbose "Downloading Sysmon.zip..."
# Invoke-WebRequest -Uri "https://download.sysinternals.com/files/Sysmon.zip" -OutFile "C:/Sysmon.zip"

# # Extract Sysmon
# Write-Verbose "Extracting Sysmon..."
# Expand-Archive -Path 'C:/Sysmon.zip' -DestinationPath 'C:/Sysmon'

# # Delete Sysmon.zip
# Write-Verbose "Deleting Sysmon.zip..."
# Remove-Item -Path 'C:/Sysmon.zip' -Force

# # Download sysmonconfig-export.xml
# Write-Verbose "Downloading sysmonconfig-export.xml..."
# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SwiftOnSecurity/sysmon-config/master/sysmonconfig-export.xml" -OutFile "C:/sysmonconfig-export.xml"

# # Execute Sysmon with sysmonconfig-export.xml
# Write-Verbose "Executing Sysmon with sysmonconfig-export.xml..."
# & 'C:/Sysmon/sysmon64.exe' -accepteula -i 'C:/sysmonconfig-export.xml'

# # Update existing Sysmon configuration
# Write-Verbose "Updating existing Sysmon configuration..."
# & 'C:/Sysmon/sysmon64.exe' -c 'C:/sysmonconfig-export.xml'

# # Disable Microsoft Defender Real-Time Protection
# Set-MpPreference -DisableRealtimeMonitoring $true

# # Install AtomicRedTeam - Invoke-Atomic
# IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicredteam.ps1' -UseBasicParsing);
# Install-AtomicRedTeam -getAtomics

# # Import the Module - Invoke-Atomic
# Import-Module "C:\AtomicRedTeam\invoke-atomicredteam\Invoke-AtomicRedTeam.psd1" -Force

# # Download and execute the Go installer
# Write-Verbose "Downloading Go and Installing..."
# Invoke-WebRequest -Uri "https://go.dev/dl/go1.20.5.windows-amd64.msi" -OutFile "C:\go1.20.5.windows-amd64.msi"; 
# Start-Process -FilePath "C:\go1.20.5.windows-amd64.msi" -NoNewWindow -Wait

# # Download Wazuh Agent for Windows
# Write-Verbose "Downloading Wazuh Agent for Windows..."
# Invoke-WebRequest -Uri "https://packages.wazuh.com/4.x/windows/wazuh-agent-4.4.3-1.msi" -OutFile "C:/wazuh-agent-4.4.3-1.msi"

# # Move Wazuh Agent MSI to C:/
# Write-Verbose "Moving Wazuh Agent MSI to C:/..."
# Move-Item -Path "C:/wazuh-agent-4.4.3-1.msi" -Destination "C:/"

# # Execute Wazuh Agent installer
# Write-Verbose "Executing Wazuh Agent installer..."
# Start-Process -FilePath "wazuh-agent-4.4.3-1.msi" -ArgumentList "/q", "WAZUH_MANAGER=192.168.56.200" -Wait
# NET START WazuhSvc

# # Print message
# Write-Host "WINDOWS SERVER 2019 IS READY!"
# Write-Host "Sysmon - Installed"
# Write-Host "sysmonconfig-export - Installed"
# Write-Host "Caldera - Installed"
# Write-Host "invoke-atomicredteam - Installed"
# Write-Host "Wazuh Agent - Installed"


