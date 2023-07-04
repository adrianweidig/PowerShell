##############################################
# Abschnitt 1: Zeichen z‰hlen
##############################################

Write-Host "=== Abschnitt 1: Zeichen z‰hlen ===`n"

$strText1 = Read-Host "Gib einen Text ein"
$anzahlZeichen = $strText1.Length
Write-Host "Die Anzahl der Zeichen im Text betr‰gt: $anzahlZeichen"


##############################################
# Abschnitt 2: In Groﬂbuchstaben umwandeln
##############################################

Write-Host "`n=== Abschnitt 2: In Groﬂbuchstaben umwandeln ===`n"

$strText2 = Read-Host "Gib einen Text ein"
$strGroﬂbuchstabenText = $strText2.ToUpper()
Write-Host "Der Text in Groﬂbuchstaben lautet: $strGroﬂbuchstabenText"


##############################################
# Abschnitt 3: In Kleinbuchstaben umwandeln
##############################################

Write-Host "`n=== Abschnitt 3: In Kleinbuchstaben umwandeln ===`n"

$strText3 = Read-Host "Gib einen Text ein"
$strKleinbuchstabenText = $strText3.ToLower()
Write-Host "Der Text in Kleinbuchstaben lautet: $strKleinbuchstabenText"


##############################################
# Abschnitt 4: Teilstring extrahieren
##############################################

Write-Host "`n=== Abschnitt 4: Teilstring extrahieren ===`n"

$strText4 = Read-Host "Gib einen Text ein"
$startIndex4 = Read-Host "Gib den Startindex (Ganzzahl) ein"
$strLaenge4 = Read-Host "Gib die L‰nge des Teilstrings (Ganzzahl) ein"
$strTeilstring = $strText4.Substring($startIndex4, $strLaenge4)
Write-Host "Der extrahierte Teilstring lautet: $strTeilstring"


##############################################
# Abschnitt 5: Text ersetzen
##############################################

Write-Host "`n=== Abschnitt 5: Text ersetzen ===`n"

$strText5 = Read-Host "Gib einen Text ein"
$strSuchtext = Read-Host "Gib den zu suchenden Text ein"
$strErsatztext = Read-Host "Gib den Ersatztext ein"
$strNeuerText = $strText5.Replace($strSuchtext, $strErsatztext)
Write-Host "Der neue Text lautet: $strNeuerText"


##############################################
# Abschnitt 6: Text in Farbe ausgeben
##############################################

Write-Host "`n=== Abschnitt 6: Text in Farbe ausgeben ===`n"

$strText6 = Read-Host "Gib einen Text ein"
Write-Host $strText6 -ForegroundColor green


##############################################
# Abschnitt 7: Text verketten
##############################################

Write-Host "`n=== Abschnitt 7: Text verketten ===`n"

$strText7a = Read-Host "Gib den ersten Text ein"
$strText7b = Read-Host "Gib den zweiten Text ein"
$strVerketteterText = $strText7a + $strText7b
Write-Host "Die beiden Texte verkn¸pft ergeben: $strVerketteterText"


##############################################
# Abschnitt 8: Text formatieren
##############################################

Write-Host "`n=== Abschnitt 8: Text formatieren ===`n"

$strText8 = Read-Host "Gib einen Text ein"
$strFormatierterText = "`t`t$strText8"
Write-Host "Der formatierte Text lautet:"
Write-Host $strFormatierterText
