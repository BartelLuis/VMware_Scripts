# Definition der Variablen
$vCenter = ""
$vCenterUser = ""
$vCenterPassword = ""

# Stelle eine Verbindung zum vCenter Server her
Connect-VIServer -Server $vCenter -User $vCenterUser -Password $vCenterPassword

# VMs abrufen und das CD-Laufwerk entfernen
$allVMs = Get-VM

foreach ($vm in $allVMs) {
    $cdDrive = Get-CDDrive -VM $vm

    if ($cdDrive) {
        # VM herunterfahren, bevor das CD-Laufwerk entfernt wird
        Write-Host "Herunterfahren der VM $($vm.Name)..."
        Stop-VM -VM $vm -Confirm:$false

        # Warte, bis die VM vollständig heruntergefahren ist (optional)
        # Start-Sleep -Seconds 30

        # CD-Laufwerk entfernen
        $cdDrive | Remove-CDDrive -Confirm:$false
        Write-Host "Das CD-Laufwerk wurde aus VM $($vm.Name) entfernt."

        # VM wieder starten
        Write-Host "Starten der VM $($vm.Name)..."
        Start-VM -VM $vm
    } else {
        Write-Host "Kein CD-Laufwerk in VM $($vm.Name) gefunden."
    }
}

# Verbindung zum vCenter Server trennen
Disconnect-VIServer -Confirm:$false
