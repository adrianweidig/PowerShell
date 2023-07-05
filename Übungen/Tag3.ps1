# 1. Finden Sie heraus, was der folgende Befehl bewirkt: "New-PSDrive myHome FileSystem C:\Windows"
<#
Get-Help New-PSDrive -Detailed

Erstellt neues TEMPORÄRES Laufwerk mit dem Namen "myHome", welches auf C:\Windows zeigt

Get-PSDrive myHome 

zum Testen
#>

# 2. Wandeln Sie die drei positionalen Parameter des Befehls aus 1.) in benannte Parameter um.
New-PSDrive -Name myHome -PSProvider FileSystem -Root C:\Windows

# 3. Listen Sie alle Protokolldateien (*.log) aus dem Windows-Ordner und seinen Unterordnern auf.
Get-ChildItem -Path C:\Windows -Filter *.log -Recurse

# 4. Stellen Sie die Maximalgröße des Ereignisprotokolls „Windows PowerShell“ auf 20 MB ein.
Set-EventLog -LogName "Windows PowerShell" -MaximumSize 20MB

# 5. Erstellen Sie einen Schlüssel und einen Eintrag in der Registry. Schlüssel: „HKCU\Software\Test“ Wert: „Testwert“ = 7AFF (DWORD)
New-Item -Path "HKCU:\Software" -Name "Test" | New-ItemProperty -Name "Testwert" -Value 0x7AFF -PropertyType DWORD

# 6. Starten Sie den Windows-Editor „notepad.exe“ in einem maximierten Fenster und sorgen Sie dafür, dass die PS so lange wartet, bis der Editor wieder geschlossen wurde.
Start-Process -FilePath notepad.exe -Wait -WindowStyle Maximized

# 7. Finden Sie heraus, ob bereits eine Instanz des Programms „Notepad“ ausgeführt wird.
Get-Process -Name notepad

# 8. Legen Sie einen neuen Alias „ie“ an, der den Internet Explorer startet.
Set-Alias -Name ie -Value "C:\Program Files\Internet Explorer\iexplore.exe"

# 9. Sie wollen eine Testdatei mit einer Größe von 1MB erstellen. Fällt Ihnen mit der PowerShell ein Weg ein?
# Mgl 1
$null | Out-File -FilePath "C:\Test\Test.txt"; (Get-Item -Path "C:\Test\Test.txt").OpenWrite().SetLength(1MB)

# Mgl 2
Set-content C:\Test\Test2.txt (" " * 1MB)

# 10. Was ist „Date“ für ein Befehl?
# Alias für Get-Date um das aktuelle Datum anzuzeigen

# 11. Erzeugen Sie eine Befehlspipeline, um alle Dienste, welche mit „P“ beginnen, zu beenden.
Get-Service | Where-Object { $_.Name -like 'P*' } | Stop-Service

# 12. Entwickeln Sie eine Befehlspipeline, die den Client-DNS-Dienst prüft und bei Bedarf neu startet.
Get-Service -Name "Dnscache" | Restart-Service # ggf. mit -verbose

# 13. Erzeugen Sie eine Pipeline, die die Anzahl der Warnungen im Ereignisprotokoll „system“ der letzten 3 Tage ermittelt.
$tagevorher = (Get-Date).AddDays(-3)
Get-WinEvent -LogName "System" | Where-Object { $_.LevelDisplayName -eq "Warning" -and $_.TimeCreated -gt $tagevorher } | Measure-Object | Select-Object -ExpandProperty Count

# 14. Erzeugen Sie eine Befehlspipeline, die ermittelt, ob der Security-Patch „KB2729452“ installiert ist.
Get-HotFix -Id "KB2729452" # Wenn leer dann gibt es ihn nicht?

# 15. Zeigen Sie alle Patches an, die vor dem 01.01.2018 installiert wurden.
Get-HotFix | Where-Object { $_.InstalledOn -lt "01/01/2018" }
