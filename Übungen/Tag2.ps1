# 1. Berechnen Sie die Zeit in Tagen, die Sie schon leben.
$geburtstag = Get-Date -Year 1995 -Month 3 -Day 28
$heute = Get-Date
$lebenszeitInTagen = ($heute - $geburtstag).Days
Write-Output "Sie leben seit $lebenszeitInTagen Tagen."

# 2. Berechnen Sie die verbleibenden Tage bis Heiligabend.
$heiligabend = Get-Date -Month 12 -Day 24
$verbleibendeTageBisHeiligabend = ($heiligabend - $heute).Days
Write-Output "Es sind noch $verbleibendeTageBisHeiligabend Tage bis Heiligabend."

# 3. Berechnen Sie die Zeitspanne zwischen Heiligabend 2013 und 1. Mai 2016.
$heiligabend2013 = Get-Date -Year 2013 -Month 12 -Day 24
$ersterMai2016 = Get-Date -Year 2016 -Month 5 -Day 1
$zeitspanne = New-TimeSpan -Start $heiligabend2013 -End $ersterMai2016
Write-Output "Die Zeitspanne zwischen Heiligabend 2013 und 1. Mai 2016 beträgt $zeitspanne."

# 4. Sie wollen würfeln. Wie generieren Sie zufällige Zahlen zwischen 1 und 6?
$random = Get-Random -Minimum 1 -Maximum 7
Write-Output "Die gewürfelte Zahl ist $random."

# 5. Finden Sie heraus, wie Sie einen gestarteten Prozess (notepad) beenden.
Stop-Process -Name "notepad"
Write-Output "Der Prozess 'notepad' wurde beendet."

# 6. Finden Sie mithilfe von „get-help“ heraus, welche Parameter das cmdlet „write-host“ unterstützt.
Get-Help -Name "Write-Host" -Parameter *

# 7. Geben Sie den Text „Hallo Admin“ mit grüner Schrift auf schwarzen Hintergrund aus.
Write-Host -ForegroundColor Green -BackgroundColor Black "Hallo Admin"

# 8. Wie kann man Hilfe zu Platzhalterzeichen abrufen?
Get-Help about_Wildcards

# 9. Finden Sie heraus, wie ein Cmdlet ihnen sämtliche Ausprägungen des Ereignisprotokolls verrät, die es gibt.
Get-EventLog -List

# 10. Sorgen Sie dafür, dass Ihnen das Cmdlet sämtliche Einträge des Systemprotokolls auflistet, ohne nach dem Namen des Logs zu fragen.
Get-EventLog -LogName System

# 11. Listen Sie nur Fehler im Systemlog auf.
Get-EventLog -LogName System -EntryType Error

# 12. Ausgehend von Frage 11 listen Sie nur die letzten 2 Fehler auf.
Get-EventLog -LogName System -EntryType Error -Newest 2

# 13. Ausgehend von Frage 11 listen Sie die Fehler der letzten 48 Stunden auf.
Get-EventLog -LogName System -EntryType Error -After (Get-Date).AddHours(-48)
Get-EventLog -LogName System -EntryType Error -After ((Get-Date)-(New-TimeSpan -Hours 48))

# 14. Sorgen Sie dafür, dass beim Aufruf des Befehls „edit“ das Programm „write.exe“ gestartet wird.
New-Alias -Name "edit" -Value "write.exe"
Write-Output "Der Befehl 'edit' startet das Programm 'write.exe'."

# 15. Ändern Sie das Farbschema Ihrer PowerShell-Konsole in „grüne“ Schrift auf „weißem“ Hintergrund.
$host.UI.RawUI.ForegroundColor = "Green"
$host.UI.RawUI.BackgroundColor = "White"
Clear-Host
Write-Output "Das Farbschema wurde geändert."
