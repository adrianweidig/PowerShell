# BEACHTE: Es werden mindestens lokale Administrator-Berechtigungen auf der Remote-Maschine 
# benötigt um via Remote verbinden zu können

##############################################
# Abschnitt 1: Voraussetzungen für Remoting
##############################################

Write-Host "=== Abschnitt 1: Voraussetzungen für Remoting ===`n"

# Prüfen, ob Remoting auf dem Remote-Computer aktiviert ist
$remoteComputer = "RemoteComputer"
$remotingEnabled = Test-WSMan -ComputerName $remoteComputer -ErrorAction SilentlyContinue

if (-not $remotingEnabled) {
    Write-Host "Remoting ist auf dem Remote-Computer nicht aktiviert. Bitte aktivieren Sie Remoting, um die folgenden Abschnitte ausführen zu können."
    exit
} else {
    Write-Host "Remoting ist auf dem Remote-Computer aktiviert. "
}

# Prüfen, ob Remoting auf dem lokalen Computer aktiviert ist
$localRemotingEnabled = Get-WSManInstance -ResourceURI "winrm/config/winrs" -Enumerate | Where-Object {$_.Value.Name -eq "AllowRemoteShellAccess"} | Select-Object -ExpandProperty Value

if (-not $localRemotingEnabled) {
    Write-Host "Remoting ist auf dem lokalen Computer nicht aktiviert. Bitte aktivieren Sie Remoting, um die folgenden Abschnitte ausführen zu können."
    exit
} else {
    Write-Host "Remoting ist auf dem lokalen Computer aktiviert."
}


##############################################
# Abschnitt 2: Remoting mit Invoke-Command
##############################################

Write-Host "`n=== Abschnitt 2: Remoting mit Invoke-Command ===`n"

# Remote-Computername festlegen
$remoteComputer = "RemoteComputer"

# Ausführung des Befehls auf dem Remote-Computer
Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    Get-Process
}


##############################################
# Abschnitt 3: Remoting mit New-PSSession und Invoke-Command
##############################################

Write-Host "`n=== Abschnitt 3: Remoting mit New-PSSession und Invoke-Command ===`n"

# Neue PSSession erstellen
$session = New-PSSession -ComputerName $remoteComputer

# Befehl auf dem Remote-Computer ausführen
Invoke-Command -Session $session -ScriptBlock {
    Get-Service
}

# PSSession beenden
Remove-PSSession -Session $session


##############################################
# Abschnitt 4: Interaktives Remoting mit Enter-PSSession
##############################################

Write-Host "`n=== Abschnitt 4: Interaktives Remoting mit Enter-PSSession ===`n"

# Neue PSSession erstellen
$session = New-PSSession -ComputerName $remoteComputer

# Interaktive Sitzung auf dem Remote-Computer starten
Enter-PSSession -Session $session

# Interaktive Sitzung beenden
Exit-PSSession

# PSSession beenden
Remove-PSSession -Session $session


##############################################
# Abschnitt 5: Remoting mit Credentials
##############################################

Write-Host "`n=== Abschnitt 5: Remoting mit Credentials ===`n"

# Benutzername und Passwort festlegen
$username = "Username"
$password = "Passwort" | ConvertTo-SecureString -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential($username, $password)

# Ausführung des Befehls auf dem Remote-Computer mit Credentials
# Alternativ kann man statt $credentials auch (Get-Credential) nutzen um
# ein Anmeldefenster anzeigen zu lassen. 

# $credentials = Get-Credential

Invoke-Command -ComputerName $remoteComputer -Credential $credentials -ScriptBlock {
    Get-Process
}


##############################################
# Abschnitt 6: Remote-Session verwalten
##############################################

Write-Host "`n=== Abschnitt 6:Remotesession verwalten ===`n"

# Neue PSSession erstellen und Session-Objekt speichern
$session = New-PSSession -ComputerName $remoteComputer

# Session-Objekt anzeigen
Write-Host "Session-Objekt erstellt: $($session.Id)"

# Aktive Sessions anzeigen
Get-PSSession

# PSSession beenden
Remove-PSSession -Session $session


##############################################
# Abschnitt 7: Dateien über Remoting übertragen
##############################################

Write-Host "`n=== Abschnitt 7: Dateien über Remoting übertragen ===`n"

# Remote-Computername und lokale Datei festlegen
$remoteComputer = "RemoteComputer"
$localFile = "C:\Pfad\Zur\Lokalen\Datei.txt"
$remotePath = "C:\Pfad\Auf\Dem\Remote-Computer\"

# Datei auf den Remote-Computer übertragen
Copy-Item -Path $localFile -Destination "\\$remoteComputer\$remotePath"


##############################################
# Abschnitt 8: Remoting mit Skriptblock und Parametern
##############################################

Write-Host "`n=== Abschnitt 8: Remoting mit Skriptblock und Parametern ===`n"

# Remote-Computername festlegen
$remoteComputer = "RemoteComputer"

# Skriptblock mit Parametern erstellen
$scriptBlock = {
    param($param1, $param2)
    Write-Host "Parameter 1: $param1"
    Write-Host "Parameter 2: $param2"
}

# Befehl mit Parametern auf dem Remote-Computer ausführen
Invoke-Command -ComputerName $remoteComputer -ScriptBlock $scriptBlock -ArgumentList "Wert1", "Wert2"


##############################################
# Abschnitt 9: Remote-Computerinformationen abrufen
##############################################

Write-Host "`n=== Abschnitt 9: Remote-Computerinformationen abrufen ===`n"

# Remote-Computername festlegen
$remoteComputer = "RemoteComputer"

# Informationen über den Remote-Computer abrufen
$computerInfo = Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $proc = Get-WmiObject -Class Win32_Processor
    $disk = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
    [PSCustomObject]@{
        "Betriebssystem" = $os.Caption
        "Prozessor" = $proc.Name
        "Festplattengröße" = $disk.Size
    }
}

# Computerinformationen anzeigen
$computerInfo


##############################################
# Abschnitt 10: Remote-Computer neustarten
##############################################

Write-Host "`n=== Abschnitt 10: Remote-Computer neustarten ===`n"

# Remote-Computername festlegen
$remoteComputer = "RemoteComputer"

# Remote-Computer neustarten
Restart-Computer -ComputerName $remoteComputer -Force

##############################################
# Abschnitt 11: Remoting über SSL
##############################################

Write-Host "=== Abschnitt 11: Remoting über SSL ===`n"

# Voraussetzungen für Remoting über SSL
# 1. Auf beiden Computern muss eine Zertifizierungsstelle (CA) installiert sein.
# 2. Auf dem Remotecomputer muss ein Zertifikat installiert sein, das von der CA ausgestellt wurde.
# 3. Auf beiden Computern muss der WinRM-Dienst konfiguriert sein, um SSL zu verwenden.
# 4. Die Firewall auf beiden Computern muss den eingehenden und ausgehenden Datenverkehr für den WinRM-Dienst über Port 5986 (standardmäßig) zulassen.

# Remote-Computername und Zertifikatpfad festlegen
$remoteComputer = "RemoteComputer"
$certificatePath = "C:\Pfad\Zum\Zertifikat.pfx"

# Zertifikat importieren
Import-PfxCertificate -FilePath $certificatePath -CertStoreLocation Cert:\LocalMachine\My

# WinRM-Dienst auf dem Remote-Computer konfigurieren ggf. Lokal nicht über Skript
Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    Set-Item -Path WSMan:\localhost\Service\Auth\Basic -Value $false
    Set-Item -Path WSMan:\localhost\Service\Auth\Digest -Value $false
    Set-Item -Path WSMan:\localhost\Service\Auth\Kerberos -Value $false
    Set-Item -Path WSMan:\localhost\Service\Auth\Negotiate -Value $false
    Set-Item -Path WSMan:\localhost\Service\Auth\Certificate -Value $true
    Set-Item -Path WSMan:\localhost\Service\AllowUnencrypted -Value $false
    Set-Item -Path WSMan:\localhost\Service\EnableCompatibilityHttpsListener -Value $false
    Set-Item -Path WSMan:\localhost\Service\EnableSsl -Value $true
}

# PSSession mit SSL erstellen
$session = New-PSSession -ComputerName $remoteComputer -UseSSL

# Befehl auf dem Remote-Computer mit SSL ausführen
Invoke-Command -Session $session -ScriptBlock {
    Get-Process
}

# PSSession beenden
Remove-PSSession -Session $session
