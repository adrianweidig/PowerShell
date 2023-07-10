# PowerShell zeigt meine Ausgaben in der falschen Reihenfolge an?
# https://stackoverflow.com/questions/54344622/why-my-powershell-script-is-not-respecting-the-steps-order
# Deshalb immer Write-Output statt Host

##############################################
# Abschnitt 1: Zeichen zählen
##############################################

Write-Output "=== Abschnitt 1: Zeichen zählen ===`n"

$strText1 = Read-Host "Gib einen Text ein"
$anzahlZeichen = $strText1.Length
Write-Output "Die Anzahl der Zeichen im Text beträgt: $anzahlZeichen"


##############################################
# Abschnitt 2: In Großbuchstaben umwandeln
##############################################

Write-Output "`n=== Abschnitt 2: In Großbuchstaben umwandeln ===`n"

$strText2 = Read-Host "Gib einen Text ein"
$strGroßbuchstabenText = $strText2.ToUpper()
Write-Output "Der Text in Großbuchstaben lautet: $strGroßbuchstabenText"


##############################################
# Abschnitt 3: In Kleinbuchstaben umwandeln
##############################################

Write-Output "`n=== Abschnitt 3: In Kleinbuchstaben umwandeln ===`n"

$strText3 = Read-Host "Gib einen Text ein"
$strKleinbuchstabenText = $strText3.ToLower()
Write-Output "Der Text in Kleinbuchstaben lautet: $strKleinbuchstabenText"


##############################################
# Abschnitt 4: Teilstring extrahieren
##############################################

Write-Output "`n=== Abschnitt 4: Teilstring extrahieren ===`n"

$strText4 = Read-Host "Gib einen Text ein"
$startIndex4 = Read-Host "Gib den Startindex (Ganzzahl) ein"
$strLaenge4 = Read-Host "Gib die Länge des Teilstrings (Ganzzahl) ein"
$strTeilstring = $strText4.Substring($startIndex4, $strLaenge4)
Write-Output "Der extrahierte Teilstring lautet: $strTeilstring"


##############################################
# Abschnitt 5: Text ersetzen
##############################################

Write-Output "`n=== Abschnitt 5: Text ersetzen ===`n"

$strText5 = Read-Host "Gib einen Text ein"
$strSuchtext = Read-Host "Gib den zu suchenden Text ein"
$strErsatztext = Read-Host "Gib den Ersatztext ein"
$strNeuerText = $strText5.Replace($strSuchtext, $strErsatztext)
Write-Output "Der neue Text lautet: $strNeuerText"


##############################################
# Abschnitt 6: Text in Farbe ausgeben
##############################################

Write-Output "`n=== Abschnitt 6: Text in Farbe ausgeben ===`n"

$strText6 = Read-Host "Gib einen Text ein"
Write-Output $strText6 -ForegroundColor green


##############################################
# Abschnitt 7: Text verketten
##############################################

Write-Output "`n=== Abschnitt 7: Text verketten ===`n"

$strText7a = Read-Host "Gib den ersten Text ein"
$strText7b = Read-Host "Gib den zweiten Text ein"
$strVerketteterText = $strText7a + $strText7b
Write-Output "Die beiden Texte verknüpft ergeben: $strVerketteterText"


##############################################
# Abschnitt 8: Text formatieren
##############################################

Write-Output "`n=== Abschnitt 8: Text formatieren ===`n"

$strText8 = Read-Host "Gib einen Text ein"
$strFormatierterText = "`t`t$strText8"
Write-Output "Der formatierte Text lautet:"
Write-Output $strFormatierterText

##############################################
# Abschnitt 9: Text formatieren mit -f
##############################################

Write-Output "`n=== Abschnitt 9: Text formatieren mit -f ===`n"

$strText9 = Read-Host "Gib einen Namen ein"
$strAlter9 = Read-Host "Gib ein Alter ein"

$strFormatierterText9 = "Name: {0}, Alter: {1}" -f $strText9, $strAlter9

Write-Output "Der formatierte Text lautet:"
Write-Output $strFormatierterText9
