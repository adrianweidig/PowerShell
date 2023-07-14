##############################################
# Abschnitt 1: Virtuelle Maschinen auflisten
##############################################

Write-Output "`n### Abschnitt 1: Virtuelle Maschinen auflisten ###`n"

# Alle virtuellen Maschinen abrufen
$vms = Get-VM

# Informationen für jede virtuelle Maschine anzeigen
foreach ($vm in $vms) {
    Write-Output "Name: $($vm.Name)"
    Write-Output "Status: $($vm.State)"
    Write-Output "Speicher: $($vm.MemoryAssigned)"
    Write-Output "Prozessoren: $($vm.NumberOfProcessors)"
    Write-Output "------------------------"
}


##############################################
# Abschnitt 2: Neue virtuelle Maschine erstellen
##############################################

Write-Output "`n### Abschnitt 2: Neue virtuelle Maschine erstellen ###`n"

# Neuen virtuellen Maschinen erstellen
New-VM -Name "MeineVM" -MemoryStartupBytes 2GB -NewVHDPath "C:\Pfad\Zur\VHD.vhdx" -NewVHDSizeBytes 100GB

# Überprüfen, ob die virtuelle Maschine erfolgreich erstellt wurde
if (Get-VM -Name "MeineVM") {
    Write-Output "Die virtuelle Maschine 'MeineVM' wurde erfolgreich erstellt."
} else {
    Write-Output "Fehler beim Erstellen der virtuellen Maschine 'MeineVM'."
}

##############################################
# Abschnitt 3: Einzelne VM-Einstellungen ändern
##############################################

Write-Output "`n### Abschnitt 3: Einzelne VM-Einstellungen ändern ###`n"

# Virtuelle Maschine auswählen
$vm = Get-VM -Name "MeineVM"

# CPU-Anzahl ändern
Set-VMProcessor -VM $vm -Count 4

# Speicher ändern
Set-VMMemory -VM $vm -StartupBytes 4GB

# Netzwerkadapter ändern
Set-VMNetworkAdapter -VM $vm -Name "Ethernet" -SwitchName "ExternalSwitch"

# Überprüfen der aktualisierten Einstellungen
$updatedVM = Get-VM -Name "MeineVM"
Write-Output "Aktualisierte Einstellungen für 'MeineVM':"
Write-Output "Prozessoren: $($updatedVM.ProcessorCount)"
Write-Output "Speicher: $($updatedVM.MemoryAssigned)"
Write-Output "Netzwerkadapter: $($updatedVM.NetworkAdapters.Name)"

##############################################
# Abschnitt 4: Virtuelle Maschine starten
##############################################

Write-Output "`n### Abschnitt 4: Virtuelle Maschine starten ###`n"

# Virtuelle Maschine starten
Start-VM -Name "MeineVM"

# Überprüfen, ob die virtuelle Maschine erfolgreich gestartet wurde
if ((Get-VM -Name "MeineVM").State -eq "Running") {
    Write-Output "Die virtuelle Maschine 'MeineVM' wurde erfolgreich gestartet."
} else {
    Write-Output "Fehler beim Starten der virtuellen Maschine 'MeineVM'."
}


##############################################
# Abschnitt 5: Virtuelle Maschine herunterfahren
##############################################

Write-Output "`n### Abschnitt 5: Virtuelle Maschine herunterfahren ###`n"

# Virtuelle Maschine herunterfahren
Stop-VM -Name "MeineVM"

# Überprüfen, ob die virtuelle Maschine erfolgreich heruntergefahren wurde
if ((Get-VM -Name "MeineVM").State -eq "Off") {
    Write-Output "Die virtuelle Maschine 'MeineVM' wurde erfolgreich heruntergefahren."
} else {
    Write-Output "Fehler beim Herunterfahren der virtuellen Maschine 'MeineVM'."
}


##############################################
# Abschnitt 6: Virtuelle Maschine löschen
##############################################

Write-Output "`n### Abschnitt 6: Virtuelle Maschine löschen ###`n"

# Virtuelle Maschine löschen
Remove-VM -Name "MeineVM" -Force

# Überprüfen, ob die virtuelle Maschine erfolgreich gelöscht wurde
if (-not (Get-VM -Name "MeineVM")) {
    Write-Output "Die virtuelle Maschine 'MeineVM' wurde erfolgreich gelöscht."
} else {
    Write-Output "Fehler beim Löschen der virtuellen Maschine 'MeineVM'."
}


##############################################
# Abschnitt 7: Virtuelle Maschine konfigurieren
##############################################

Write-Output "`n### Abschnitt 7: Virtuelle Maschine konfigurieren ###`n"

# Virtuelle Maschine auswählen
$vm = Get-VM -Name "MeineVM"

# Speicher und Prozessoren konfigurieren
Set-VM -VM $vm -MemoryStartupBytes 4GB -ProcessorCount 2

# Überprüfen der Konfiguration
$updatedVM = Get-VM -Name "MeineVM"
Write-Output "Aktualisierte Konfiguration für 'MeineVM':"
Write-Output "Speicher: $($updatedVM.MemoryAssigned)"
Write-Output "Prozessoren: $($updatedVM.NumberOfProcessors)"


##############################################
# Abschnitt 8: Virtuelle Maschine Snapshot erstellen
##############################################

Write-Output "`n### Abschnitt 8: Virtuelle Maschine Snapshot erstellen ###`n"

# Virtuelle Maschine auswählen
$vm = Get-VM -Name "MeineVM"

# Snapshot erstellen
New-Snapshot -VM $vm -Name "Snapshot1" -Description "Erster Snapshot"

# Überprüfen, ob der Snapshot erfolgreich erstellt wurde
if (Get-Snapshot -VM $vm -Name "Snapshot1") {
    Write-Output "Der Snapshot 'Snapshot1' wurde erfolgreich erstellt."
} else {
    Write-Output "Fehler beim Erstellen des Snapshots 'Snapshot1'."
}


##############################################
# Abschnitt 9: Virtuelle Maschine Snapshot wiederherstellen
##############################################

Write-Output "`n### Abschnitt 9: Virtuelle Maschine Snapshot wiederherstellen ###`n"

# Virtuelle Maschine auswählen
$vm = Get-VM -Name "MeineVM"

# Snapshot wiederherstellen
Restore-VMSnapshot -VM $vm -Name "Snapshot1"

# Überprüfen, ob der Snapshot erfolgreich wiederhergestellt wurde
if ((Get-VM -Name "MeineVM").State -eq "Running") {
    Write-Output "Der Snapshot 'Snapshot1' wurde erfolgreich wiederhergestellt."
} else {
    Write-Output "Fehler beim Wiederherstellen des Snapshots 'Snapshot1'."
}


##############################################
# Abschnitt 10: Virtuelle Maschine Snapshot entfernen
##############################################

Write-Output "`n### Abschnitt 10: Virtuelle Maschine Snapshot entfernen ###`n"

# Virtuelle Maschine auswählen
$vm = Get-VM -Name "MeineVM"

# Snapshot entfernen
Remove-VMSnapshot -VM $vm -Name "Snapshot1"

# Überprüfen, ob der Snapshot erfolgreich entfernt wurde
if (-not (Get-Snapshot -VM $vm -Name "Snapshot1")) {
    Write-Output "Der Snapshot 'Snapshot1' wurde erfolgreich entfernt."
} else {
    Write-Output "Fehler beim Entfernen des Snapshots 'Snapshot1'."
}
