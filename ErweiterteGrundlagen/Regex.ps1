##############################################
# Abschnitt 1: Einführung in reguläre Ausdrücke
##############################################

Write-Output "`n### Abschnitt 1: Einführung in reguläre Ausdrücke ###`n"

# Beispieltext festlegen
$text = "Hallo, dies ist ein Beispieltext. 12345 ABCDE"

# Einfacher Regex-Ausdruck zum Finden von Zahlen und Buchstaben
$pattern = "\w+"

# Mit dem Regex-Ausdruck den Text durchsuchen
$uebereinstimmungen = [regex]::Matches($text, $pattern)

# Gefundene Übereinstimmungen anzeigen
foreach ($match in $uebereinstimmungen) {
    Write-Output "Gefundene Übereinstimmung: $($match.Value)"
}


##############################################
# Abschnitt 2: Matchen von Text
##############################################

Write-Output "`n### Abschnitt 2: Matchen von Text ###`n"

# Beispieltext festlegen
$text = "Dies ist ein Beispieltext. Ein Beispielwort ist 'Beispiel'."

# Regex-Ausdruck zum Finden des Wortes "Beispiel"
$pattern = "Beispiel\w*"

# Mit dem Regex-Ausdruck den Text durchsuchen
$match = [regex]::Match($text, $pattern)

# Überprüfen, ob eine Übereinstimmung gefunden wurde
if ($match.Success) {
    Write-Output "Das Wort 'Beispiel' wurde gefunden: $($match.Value)"
} else {
    Write-Output "Das Wort 'Beispiel' wurde nicht gefunden."
}


##############################################
# Abschnitt 3: Ersetzen von Text
##############################################

Write-Output "`n### Abschnitt 3: Ersetzen von Text ###`n"

# Beispieltext festlegen
$text = "Dies ist ein Beispieltext."

# Regex-Ausdruck zum Ersetzen von "Beispiel" durch "Test"
$pattern = "Beispiel"
$replacement = "Test"

# Text mit dem Regex-Ausdruck ersetzen
$newText = [regex]::Replace($text, $pattern, $replacement)

# Den neuen Text anzeigen
Write-Output "Neuer Text: $newText"


##############################################
# Abschnitt 4: Aufteilen von Text
##############################################

Write-Output "`n### Abschnitt 4: Aufteilen von Text ###`n"

# Beispieltext festlegen
$text = "Dies-ist-ein-Beispieltext"

# Regex-Ausdruck zum Aufteilen des Textes anhand des Trennzeichens "-"
$pattern = "-"
$parts = [regex]::Split($text, $pattern)

# Die aufgeteilten Teile anzeigen
foreach ($part in $parts) {
    Write-Output "Teil: $part"
}


##############################################
# Abschnitt 5: Komplexere Regex
##############################################

Write-Output "`n### Abschnitt 5: Komplexere Regex ###`n"

# Beispieltext festlegen
$text = "01.08.2023 Dies ist ein Beispieltext mit Datum: 01.07.2023"

# Regex-Ausdruck zum Finden von Datumsangaben im Format TT.MM.JJJJ
$pattern = "\d{2}\.\d{2}\.\d{4}"

# Mit dem Regex-Ausdruck den Text durchsuchen
$uebereinstimmungen = [regex]::Matches($text, $pattern)

# Gefundene Datumsangaben anzeigen
foreach ($match in $uebereinstimmungen) {
    Write-Output "Gefundenes Datum: $($match.Value)"
}

