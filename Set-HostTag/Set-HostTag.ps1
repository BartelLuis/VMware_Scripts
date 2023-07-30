# Definition der Variablen
$vCenter = ""
$vCenterUser = ""
$vCenterPassword = ""

# PowerCLI-Verbindung zum vCenter Server herstellen
Connect-VIServer -Server $vCenter -User $vCenterUser -Password $vCenterPassword

# Alle virtuellen Maschinen abrufen
$vmList = Get-VM

# Über jede virtuelle Maschine iterieren und den Tag mit dem Host-Namen füllen
foreach ($vm in $vmList) {
    $vmHost = $vm.VMHost.Name
    $tagName = $vmHost
    $categoryName = "VMHost"

    # Überprüfen, ob die Kategorie bereits existiert
    if (-Not (Get-TagCategory -Name $categoryName)) {
        # Wenn die Kategorie nicht existiert, erstellen wir sie
        New-TagCategory -Name $categoryName -Description "VM Host Tags"
    }

    # Überprüfen, ob der Tag bereits existiert
    if (-Not (Get-Tag -Name $tagName -Category $categoryName)) {
        # Wenn der Tag nicht existiert, erstellen wir ihn
        New-Tag -Name $tagName -Category $categoryName -Description "Tag for VMs hosted on $vmHost"
    }

    # Den Tag auf der virtuellen Maschine festlegen
    New-TagAssignment -Tag $tagName -Entity $vm -Confirm:$false
}

# PowerCLI-Verbindung trennen
Disconnect-VIServer -Confirm:$false
