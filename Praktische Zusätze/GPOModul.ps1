##############################################
# Abschnitt 1: Modulimport und Verbindung zur Domäne
##############################################

Write-Host "=== Abschnitt 1: Modulimport und Verbindung zur Domäne ===`n"

# Import des GroupPolicy-Moduls
Import-Module GroupPolicy

# Verbindung zur Domäne herstellen
Connect-GPODomain -Server "meinServer.meineDomäne.com"


##############################################
# Abschnitt 2: GPO-Informationen abrufen
##############################################

Write-Host "`n=== Abschnitt 2: GPO-Informationen abrufen ===`n"

# Abrufen aller GPOs in der Domäne
$allGPOs = Get-GPO -All

# Anzeigen der GPO-Informationen
foreach ($gpo in $allGPOs) {
    Write-Host "GPO-Name: $($gpo.DisplayName)"
    Write-Host "GPO-ID: $($gpo.Id)"
    Write-Host "GPO-Beschreibung: $($gpo.Description)"
    Write-Host "GPO-Erstellt von: $($gpo.CreatedBy)"
    Write-Host "GPO-Erstellt am: $($gpo.CreationTime)"
    Write-Host "--------------------"
}


##############################################
# Abschnitt 3: GPO-Einstellungen ändern
##############################################

Write-Host "`n=== Abschnitt 3: GPO-Einstellungen ändern ===`n"

# GPO für Änderungen öffnen
$gpoToModify = Get-GPO -Name "MeineGPO"
$gpoToModify | Set-GPPermissions -TargetName "DOMÄNE\Benutzer" -TargetType User -PermissionLevel GpoEdit -Replace

# Änderungen an der GPO vornehmen
$gpoToModify.DisplayName = "Neuer GPO-Name"
$gpoToModify.Description = "Neue GPO-Beschreibung"
$gpoToModify | Save-GPO

# Überprüfen, ob die Änderungen übernommen wurden
$modifiedGPO = Get-GPO -Name "MeineGPO"
Write-Host "Geänderter GPO-Name: $($modifiedGPO.DisplayName)"
Write-Host "Geänderte GPO-Beschreibung: $($modifiedGPO.Description)"


##############################################
# Abschnitt 4: GPO anwenden
##############################################

Write-Host "`n=== Abschnitt 4: GPO anwenden ===`n"

# GPO auf einen bestimmten Organizational Unit (OU) anwenden
$targetOU = "OU=MeineOU,DC=meineDomäne,DC=com"
Invoke-GPUpdate -Computer "MeinComputer" -Target $targetOU -Force


##############################################
# Abschnitt 5: GPO sichern und wiederherstellen
##############################################

Write-Host "`n=== Abschnitt 5: GPO sichern und wiederherstellen ===`n"

# Sicherung einer GPO in eine Datei
$gpoName = "MeineGPO"
$backupFilePath = "C:\Pfad\Zur\BackupDatei.zip"
Backup-GPO -Name $gpoName -Path $backupFilePath

# Wiederherstellen einer GPO aus einer Sicherungsdatei
Restore-GPO -Path $backupFilePath



##############################################
# Abschnitt 6: GPO löschen
##############################################

Write-Host "`n=== Abschnitt 6: GPO löschen ===`n"

# GPO löschen
$gpoToDelete = Get-GPO -Name "ZuLöschendeGPO"
$gpoToDelete | Remove-GPO -Confirm:$false

# Überprüfen, ob die GPO gelöscht wurde
$deletedGPO = Get-GPO -Name "ZuLöschendeGPO"
if ($null -eq $deletedGPO) {
    Write-Host "Die GPO wurde erfolgreich gelöscht."
} else {
    Write-Host "Fehler beim Löschen der GPO."
}


##############################################
# Abschnitt 7: GPO-Bericht erstellen
##############################################

Write-Host "`n=== Abschnitt 7: GPO-Bericht erstellen ===`n"

# GPO-Bericht erstellen
$gpoName = "MeineGPO"
$reportFilePath = "C:\Pfad\Zur\GPOBericht.html"
Get-GPOReport -Name $gpoName -ReportType Html -Path $reportFilePath

# Ausgabe des Berichtspfads
Write-Host "Der GPO-Bericht wurde unter folgendem Pfad gespeichert: $reportFilePath"



##############################################
# Abschnitt 8: Modul wieder entfernen und Domänenverbindung trennen
##############################################

Write-Host "`n=== Abschnitt 8: Modul wieder entfernen und Domänenverbindung trennen ===`n"

# Modul entfernen
Remove-Module GroupPolicy

# Domänenverbindung trennen
Disconnect-GPODomain
