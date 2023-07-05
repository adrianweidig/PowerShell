<#     
-eq: (equal)            Prüft, ob zwei Werte gleich sind.
-lt: (lower-than)       Prüft, ob ein Wert kleiner ist als ein anderer Wert.
-gt: (greater-than)     Prüft, ob ein Wert größer ist als ein anderer Wert.
-le: (lower-equal)      Prüft, ob ein Wert kleiner oder gleich einem anderen Wert ist.
-ge: (greater-equal)    Prüft, ob ein Wert größer oder gleich einem anderen Wert ist.
-ne: (not-equal)        Prüft, ob zwei Werte ungleich sind. 
#>

##############################################
# Abschnitt 1: Kontrollstruktur if-else
##############################################

Write-Output "=== Abschnitt 1: Kontrollstruktur if-else ===`n"

# Beispiel 1: Prüfen einer Bedingung mit if-else
$zahl = 10

if ($zahl -gt 0) {
    Write-Output "Die Zahl ist größer als 0."
} else {
    Write-Output "Die Zahl ist kleiner oder gleich 0."
}

# Beispiel 2: Mehrere Bedingungen mit elseif
$note = 75

if ($note -ge 90) {
    Write-Output "Sehr gut!"
} elseif ($note -ge 80) {
    Write-Output "Gut!"
} elseif ($note -ge 70) {
    Write-Output "Befriedigend!"
} elseif ($note -ge 60) {
    Write-Output "Ausreichend!"
} else {
    Write-Output "Nicht bestanden!"
}


##############################################
# Abschnitt 2: Vergleiche
##############################################

Write-Output "`n=== Abschnitt 2: Vergleiche ===`n"

# Beispiel 1: Vergleich von Zahlen
$zahl1 = 10
$zahl2 = 5

if ($zahl1 -eq $zahl2) {
    Write-Output "Die Zahlen sind gleich."
} elseif ($zahl1 -gt $zahl2) {
    Write-Output "Zahl 1 ist größer als Zahl 2."
} else {
    Write-Output "Zahl 1 ist kleiner als Zahl 2."
}

# Beispiel 2: Vergleich von Strings
$text1 = "Hallo"
$text2 = "Welt"

if ($text1 -eq $text2) {
    Write-Output "Die Texte sind gleich."
} else {
    Write-Output "Die Texte sind unterschiedlich."
}

# Beispiel 3: Vergleich von Datumswerten
$datum1 = Get-Date -Year 2022 -Month 1 -Day 1
$datum2 = Get-Date -Year 2023 -Month 1 -Day 1

if ($datum1 -lt $datum2) {
    Write-Output "Datum 1 liegt vor Datum 2."
} elseif ($datum1 -gt $datum2) {
    Write-Output "Datum 1 liegt nach Datum 2."
} else {
    Write-Output "Die beiden Daten sind identisch."
}

##############################################
# Abschnitt 3: Switch
##############################################

Write-Output "`n=== Abschnitt 3: Switch ===`n"

# Beispiel: Ausgabe des Wochentags basierend auf der Tagesnummer
$wochentag = ""
$tag = (Get-Date).DayOfWeek

switch ($tag) {
    "Monday"    { $wochentag = "Montag" }
    "Tuesday"   { $wochentag = "Dienstag" }
    "Wednesday" { $wochentag = "Mittwoch" }
    "Thursday"  { $wochentag = "Donnerstag" }
    "Friday"    { $wochentag = "Freitag" }
    "Saturday"  { $wochentag = "Samstag" }
    "Sunday"    { $wochentag = "Sonntag" }
    default     { $wochentag = "Ungültiger Tag" }
}

Write-Output "Heute ist $wochentag."

# Beispiel: Ausgabe des Wochentags direkt als deutscher Wochentag
# $deutscheWochennamen = [System.Globalization.CultureInfo]::CreateSpecificCulture("de-DE")
# $tag = (Get-Date).ToString("dddd", $deutscheWochennamen)

##############################################
# Abschnitt 4: Kopfgesteuerte Schleife (while)
##############################################

Write-Output "`n=== Abschnitt 3: Kopfgesteuerte Schleife (while) ===`n"

# Beispiel: Zahlen von 1 bis 5 ausgeben
$zahl = 1

while ($zahl -le 5) {
    Write-Output $zahl
    $zahl++
}


##############################################
# Abschnitt 5: Fußgesteuerte Schleife (do-while)
##############################################

Write-Output "`n=== Abschnitt 4: Fußgesteuerte Schleife (do-while) ===`n"

# Beispiel: Zahlen von 1 bis 5 ausgeben
$zahl = 1

do {
    Write-Output $zahl
    $zahl++
} while ($zahl -le 5)

# Es gibt die umgekehrte Variante mit until
# Dies ist keine gängige Variante und wird deswegen nicht gelistet


##############################################
# Abschnitt 6: Zählerschleife (for)
##############################################

Write-Output "`n=== Abschnitt 5: Zählerschleife (for) ===`n"

# Beispiel: Zahlen von 1 bis 5 ausgeben
for ($zahl = 1; $zahl -le 5; $zahl++) {
    Write-Output $zahl
}


##############################################
# Abschnitt 7: Zählerschleife (foreach)
##############################################

Write-Output "`n=== Abschnitt 6: Zählerschleife (foreach) ===`n"

# Beispiel: Elemente in einem Array ausgeben
$tiere = "Hund", "Katze", "Maus"

foreach ($tier in $tiere) {
    Write-Output $tier
}
