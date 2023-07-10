$domainController = "dc2016.spielwiese.intern"

# Alle Computer in der Domäne abrufen (Aktiviere die gewünschte Credentialform)
$computers = Get-ADComputer -Filter * -SearchBase "DC=spielwiese,DC=intern" -Server $domainController

#$username = "Benutzername"
#$password = "Passwort" | ConvertTo-SecureString -AsPlainText -Force
#$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password


# WMI auf jedem Computer aktivieren
foreach ($computer in $computers) {
    $computerName = $computer.Name

    # Remote-Verbindung zum Computer herstellen
    $session = New-PSSession -ComputerName $computerName -Credential (Get-Credential)
    #$session = New-PSSession -ComputerName $computerName -Credential ($credential)

    # WMI aktivieren
    Invoke-Command -Session $session -ScriptBlock {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1
        Enable-PSRemoting -Force
        Enable-NetFirewallRule -DisplayGroup "Windows-Verwaltungsinstrumentation (WMI)"
        Set-Service -Name "winrm" -StartupType Automatic
        Start-Service -Name "winrm"
    }

    # Remote-Sitzung beenden
    Remove-PSSession -Session $session

    Write-Output "WMI wurde auf dem Computer $computerName aktiviert."
}

Write-Output "Die Aktivierung von WMI auf allen Geräten wurde abgeschlossen."
