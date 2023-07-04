##############################################
# Dateiname: "Microsoft.PowerShell_profile.ps1"
# Speicherort: C:\Users\NUTZERNAME\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
# Wenn die Datei unter dem genannten Speicherort abgelegt ist,
# wird dieses Skript automatisch beim Start der PowerShell ausgef�hrt.
##############################################

# Farben anpassen
$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "Green"

# Begr��ung - aktueller Computer, Benutzer, L�ndercode
$computerName = $env:COMPUTERNAME
$benutzerName = $env:USERNAME
$laenderCode = (Get-Culture).Name
Write-Host "Willkommen, " -NoNewline
Write-Host $benutzerName -ForegroundColor Red -NoNewline
Write-Host "! Du bist auf dem Computer " -NoNewline
Write-Host $computerName -ForegroundColor Red -NoNewline
Write-Host " angemeldet. L�ndercode: " -NoNewline
Write-Host $laenderCode -ForegroundColor Red


# Aliase anlegen
Set-Alias -Name edit -Value write.exe

# Eigene Funktionen
function Get-AnzahlOffenePowershells {
    # Funktion, um die Anzahl der ge�ffneten PowerShell-Fenster zu z�hlen
    $prozessName = "powershell"
    $anzahlFenster = (Get-Process -Name $prozessName).Count
    $anzahlFenster
}

# Promptzeichen �ndern
function prompt {
    "$env:USERNAME - $(Get-Date -Format 'dd.MM.yyyy HH:mm:ss') >> "
}


# Protokollierung / Transcript starten
Write-Host "`n##### Protokollierung / Transcript gestartet #####`n"
$transcriptPfad = "C:\Logs\PowerShellTranscript.txt"
try {
    Start-Transcript -Path $transcriptPfad -Force
} catch {
    Write-Host "Fehler beim erneuten Starten des Transkripts. Bereits gestartet? Pr�fe ggf. unter $transcriptPfad"
}

# Tagez�hler (Noch X Tage bis zu ...)
Write-Host "`n##### Tagez�hler #####`n"
$zielDatum = Get-Date "31.12.2026"
$verbleibendeTage = ($zielDatum - (Get-Date)).Days
Write-Host "Noch $verbleibendeTage Tage bis zum $(Get-Date -Format 'dd.MM.yyyy' -Date $zielDatum)"

# Wichtige IPs �berpr�fen und erfolgreiches Pingen anzeigen
Write-Host "`n##### �berpr�fung wichtiger IPs #####`n"
$ips = @("127.0.0.1", "8.8.8.8")

foreach ($ip in $ips) {
    $result = Test-Connection -ComputerName $ip -Count 1 -Quiet
    if ($result) {
        Write-Host "Ping zu $ip erfolgreich"
    }
}

Write-Host ""

##############################################
