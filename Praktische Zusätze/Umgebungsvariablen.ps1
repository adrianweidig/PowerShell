# Ausgabe aller Umgebungsvariablen
Write-Host "### Liste der Umgebungsvariablen ###"
Get-ChildItem Env:

# Abschnitt 1: Home-Verzeichnis
Write-Host "`n### Abschnitt 1: Home-Verzeichnis ###`n"
#$HOME = [Environment]::GetFolderPath("UserProfile")
Write-Host "Home-Verzeichnis: $HOME"

# Abschnitt 2: Temporäre Verzeichnisse
Write-Host "`n### Abschnitt 2: Temporäre Verzeichnisse ###`n"
$TEMP = [Environment]::GetEnvironmentVariable("TEMP")
$TMP = [Environment]::GetEnvironmentVariable("TMP")
Write-Host "Temporäres Verzeichnis (TEMP): $TEMP"
Write-Host "Temporäres Verzeichnis (TMP): $TMP"

# Abschnitt 3: Benutzerinformationen
Write-Host "`n### Abschnitt 3: Benutzerinformationen ###`n"
$USERNAME = [Environment]::UserName
$USERDOMAIN = [Environment]::UserDomainName
Write-Host "Benutzername: $USERNAME"
Write-Host "Benutzerdomäne: $USERDOMAIN"

# Abschnitt 4: Systeminformationen
Write-Host "`n### Abschnitt 4: Systeminformationen ###`n"
$COMPUTERNAME = [Environment]::MachineName
$OS = [Environment]::OSVersion.VersionString
$PROCESSOR = [Environment]::GetEnvironmentVariable("PROCESSOR_IDENTIFIER")
Write-Host "Computernamen: $COMPUTERNAME"
Write-Host "Betriebssystem: $OS"
Write-Host "Prozessor: $PROCESSOR"

# Dies funktioniert mit allen Umgebungsvariablen gem. obiger Anzeige via Get-ChildItem