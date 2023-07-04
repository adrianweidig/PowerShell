##############################################
# Abschnitt 1: Zeichen z‰hlen
##############################################

# Benutzer gibt einen Text ein
$strText1 = Read-Host "Gib einen Text ein"

# Anzahl der Zeichen im Text z‰hlen
$anzahlZeichen = $strText1.Length

# Ergebnis ausgeben
Write-Host "Die Anzahl der Zeichen im Text betr‰gt: $anzahlZeichen"


##############################################
# Abschnitt 2: In Groﬂbuchstaben umwandeln
##############################################

# Benutzer gibt einen Text ein
$strText2 = Read-Host "Gib einen Text ein"

# Text in Groﬂbuchstaben umwandeln
$strGroﬂbuchstabenText = $strText2.ToUpper()

# Ergebnis ausgeben
Write-Host "Der Text in Groﬂbuchstaben lautet: $strGroﬂbuchstabenText"


##############################################
# Abschnitt 3: In Kleinbuchstaben umwandeln
##############################################

# Benutzer gibt einen Text ein
$strText3 = Read-Host "Gib einen Text ein"

# Text in Kleinbuchstaben umwandeln
$strKleinbuchstabenText = $strText3.ToLower()

# Ergebnis ausgeben
Write-Host "Der Text in Kleinbuchstaben lautet: $strKleinbuchstabenText"


##############################################
# Abschnitt 4: Teilstring extrahieren
##############################################

# Benutzer gibt einen Text ein
$strText4 = Read-Host "Gib einen Text ein"

# Benutzer gibt den Startindex ein
$startIndex4 = Read-Host "Gib den Startindex (Ganzzahl) ein"

# Benutzer gibt die L‰nge des Teilstrings ein
$strLaenge4 = Read-Host "Gib die L‰nge des Teilstrings (Ganzzahl) ein"

# Teilstring extrahieren
$strTeilstring = $strText4.Substring($startIndex4, $strLaenge4)

# Ergebnis ausgeben
Write-Host "Der extrahierte Teilstring lautet: $strTeilstring"


##############################################
# Abschnitt 5: Text ersetzen
##############################################

# Benutzer gibt einen Text ein
$strText5 = Read-Host "Gib einen Text ein"

# Benutzer gibt den zu suchenden Text ein
$strSuchtext = Read-Host "Gib den zu suchenden Text ein"

# Benutzer gibt den Ersatztext ein
$strErsatztext = Read-Host "Gib den Ersatztext ein"

# Text ersetzen
$strNeuerText = $strText5.Replace($strSuchtext, $strErsatztext)

# Ergebnis ausgeben
Write-Host "Der neue Text lautet: $strNeuerText"


##############################################
# Abschnitt 6: Text in Farbe ausgeben
##############################################

# Benutzer gibt einen Text ein
$strText6 = Read-Host "Gib einen Text ein"

# Text in gr¸ner Farbe ausgeben
Write-Host $strText6 -ForegroundColor green


##############################################
# Abschnitt 7: Text verketten
##############################################

# Benutzer gibt einen Text ein
$strText7a = Read-Host "Gib den ersten Text ein"
$strText7b = Read-Host "Gib den zweiten Text ein"

# Texte verketten
$strVerketteterText = $strText7a + $strText7b

# Ergebnis ausgeben
Write-Host "Die beiden Texte verkn¸pft ergeben: $strVerketteterText"


##############################################
# Abschnitt 8: Text formatieren
##############################################

# Benutzer gibt einen Text ein
$strText8 = Read-Host "Gib einen Text ein"

# Text formatieren und mit Tabs mittels `t ausrichten
$strFormatierterText = "`t`t$strText8"

# Ergebnis ausgeben
Write-Host "Der formatierte Text lautet:"
Write-Host $strFormatierterText

