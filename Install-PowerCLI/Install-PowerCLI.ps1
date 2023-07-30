# Überprüfe, ob das Skript mit Administratorrechten ausgeführt wird
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Das Skript muss mit Administratorrechten ausgeführt werden. Bitte starte PowerShell als Administrator und führe das Skript erneut aus."
    Exit 1
}

# Überprüfe, ob PowerShellGet installiert ist (ab Windows Management Framework 5.1)
if (-not (Get-Module -ListAvailable -Name PowerShellGet)) {
    Write-Host "PowerShellGet ist nicht installiert. Installiere das Windows Management Framework 5.1 oder eine neuere Version, um fortzufahren."
    Exit 1
}

# Überprüfe, ob NuGet installiert ist
if (-not (Get-Module -ListAvailable -Name NuGet)) {
    Write-Host "NuGet ist nicht installiert. Installiere NuGet, um fortzufahren."
    Exit 1
}

# Installiere PowerCLI
Write-Host "Installiere PowerCLI..."
Install-Module -Name VMware.PowerCLI -Force -Scope AllUsers

# Überprüfe, ob die Installation erfolgreich war
if (-not (Get-Module -ListAvailable -Name VMware.PowerCLI)) {
    Write-Host "PowerCLI konnte nicht erfolgreich installiert werden. Überprüfe deine Internetverbindung und versuche es erneut."
    Exit 1
}

Write-Host "PowerCLI wurde erfolgreich installiert."
