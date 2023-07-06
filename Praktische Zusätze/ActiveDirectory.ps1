##############################################
# Abschnitt 1: Benutzer erstellen
##############################################

Write-Output "=== Abschnitt 1: Benutzer erstellen ===`n"

# Benutzerinformationen festlegen
$givenName = "John"
$surname = "Doe"
$username = "johndoe"
$password = ConvertTo-SecureString "Passw0rd" -AsPlainText -Force
$ou = "OU=Users,DC=example,DC=com"

# Neuen Benutzer erstellen
New-ADUser -GivenName $givenName -Surname $surname -SamAccountName $username -UserPrincipalName "$username@example.com" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ou


##############################################
# Abschnitt 2: Benutzer abrufen
##############################################

Write-Output "`n=== Abschnitt 2: Benutzer abrufen ===`n"

# Alle Benutzer abrufen
$allUsers = Get-ADUser -Filter *

# Benutzerinformationen anzeigen
foreach ($user in $allUsers) {
    Write-Output "Benutzername: $($user.SamAccountName)"
    Write-Output "Vorname: $($user.GivenName)"
    Write-Output "Nachname: $($user.Surname)"
    Write-Output "E-Mail: $($user.UserPrincipalName)"
    Write-Output "------------------------"
}


##############################################
# Abschnitt 3: Benutzer filtern
##############################################

Write-Output "`n=== Abschnitt 3: Benutzer filtern ===`n"

# Benutzer anhand eines Filters abrufen
$filteredUsers = Get-ADUser -Filter {Enabled -eq $true -and Surname -like "Doe*"}

# Benutzerinformationen anzeigen
foreach ($user in $filteredUsers) {
    Write-Output "Benutzername: $($user.SamAccountName)"
    Write-Output "Vorname: $($user.GivenName)"
    Write-Output "Nachname: $($user.Surname)"
    Write-Output "E-Mail: $($user.UserPrincipalName)"
    Write-Output "------------------------"
}


##############################################
# Abschnitt 4: Benutzer suchen
##############################################

Write-Output "`n=== Abschnitt 4: Benutzer suchen ===`n"

# Benutzer anhand eines Suchbegriffs abrufen
$searchTerm = "Doe"
$foundUsers = Get-ADUser -Filter {SamAccountName -like "*$searchTerm*"}

# Benutzerinformationen anzeigen
foreach ($user in $foundUsers) {
    Write-Output "Benutzername: $($user.SamAccountName)"
    Write-Output "Vorname: $($user.GivenName)"
    Write-Output "Nachname: $($user.Surname)"
    Write-Output "E-Mail: $($user.UserPrincipalName)"
    Write-Output "------------------------"
}


##############################################
# Abschnitt 5: Benutzer in CSV speichern
##############################################

Write-Output "`n=== Abschnitt 5: Benutzer in CSV speichern und ausgeben ===`n"

# CSV-Dateipfad festlegen
$csvFilePath = "C:\Pfad\Zur\Benutzer.csv"

# Benutzerdaten in CSV-Datei speichern
$allUsers | Export-Csv -Path $csvFilePath -NoTypeInformation

##############################################
# Abschnitt 6: Benutzer in JSON speichern
##############################################

Write-Output "`n=== Abschnitt 6: Benutzer in JSON speichern ===`n"

# JSON-Dateipfad festlegen
$jsonFilePath = "C:\Pfad\Zur\Benutzer.json"

# Benutzerdaten in JSON-Datei speichern
$allUsers | ConvertTo-Json | Out-File -FilePath $jsonFilePath

##############################################
# Abschnitt 7: Benutzer in XML speichern
##############################################

Write-Output "`n=== Abschnitt 7: Benutzer in XML speichern ===`n"

# XML-Dateipfad festlegen
$xmlFilePath = "C:\Pfad\Zur\Benutzer.xml"

# Benutzerdaten in XML-Datei speichern
$allUsers | ConvertTo-Xml | Out-File -FilePath $xmlFilePath

##############################################
# Abschnitt 8: Benutzer aus JSON lesen und erstellen
##############################################

Write-Output "`n=== Abschnitt 8: Benutzer aus JSON lesen und erstellen ===`n"

# JSON-Datei einlesen
$jsonData = Get-Content -Path $jsonFilePath | ConvertFrom-Json

# Benutzer aus JSON-Daten erstellen
foreach ($user in $jsonData) {
    $givenName = $user.GivenName
    $surname = $user.Surname
    $username = $user.SamAccountName
    $password = ConvertTo-SecureString $user.Password -AsPlainText -Force
    $ou = "OU=Users,DC=example,DC=com"

    New-ADUser -GivenName $givenName -Surname $surname -SamAccountName $username -UserPrincipalName "$username@example.com" -Enabled $true -PasswordNeverExpires $true -AccountPassword $password -Path $ou
}

##############################################
# Abschnitt X: Löschen der erzeugten Dateien
##############################################

Write-Output "`n=== Abschnitt X: Löschen der erzeugten Dateien ===`n"

# CSV-Datei löschen
Remove-Item -Path $csvFilePath -Force

# JSON-Datei löschen
Remove-Item -Path $jsonFilePath -Force

# XML-Datei löschen
Remove-Item -Path $xmlFilePath -Force
