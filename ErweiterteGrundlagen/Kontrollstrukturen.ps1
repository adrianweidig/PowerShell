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

Write-Host "=== Abschnitt 1: Kontrollstruktur if-else ===`n"

# Beispiel 1: Prüfen einer Bedingung mit if-else
$zahl = 10

if ($zahl -gt 0) {
    Write-Host "Die Zahl ist größer als 0."
} else {
    Write-Host "Die Zahl ist kleiner oder gleich 0."
}

# Beispiel 2: Mehrere Bedingungen mit elseif
$note = 75

if ($note -ge 90) {
    Write-Host "Sehr gut!"
} elseif ($note -ge 80) {
    Write-Host "Gut!"
} elseif ($note -ge 70) {
    Write-Host "Befriedigend!"
} elseif ($note -ge 60) {
    Write-Host "Ausreichend!"
} else {
    Write-Host "Nicht bestanden!"
}


##############################################
# Abschnitt 2: Vergleiche
##############################################

Write-Host "`n=== Abschnitt 2: Vergleiche ===`n"

# Beispiel 1: Vergleich von Zahlen
$zahl1 = 10
$zahl2 = 5

if ($zahl1 -eq $zahl2) {
    Write-Host "Die Zahlen sind gleich."
} elseif ($zahl1 -gt $zahl2) {
    Write-Host "Zahl 1 ist größer als Zahl 2."
} else {
    Write-Host "Zahl 1 ist kleiner als Zahl 2."
}

# Beispiel 2: Vergleich von Strings
$text1 = "Hallo"
$text2 = "Welt"

if ($text1 -eq $text2) {
    Write-Host "Die Texte sind gleich."
} else {
    Write-Host "Die Texte sind unterschiedlich."
}

# Beispiel 3: Vergleich von Datumswerten
$datum1 = Get-Date -Year 2022 -Month 1 -Day 1
$datum2 = Get-Date -Year 2023 -Month 1 -Day 1

if ($datum1 -lt $datum2) {
    Write-Host "Datum 1 liegt vor Datum 2."
} elseif ($datum1 -gt $datum2) {
    Write-Host "Datum 1 liegt nach Datum 2."
} else {
    Write-Host "Die beiden Daten sind identisch."
}


##############################################
# Abschnitt 3: Kopfgesteuerte Schleife (while)
##############################################

Write-Host "`n=== Abschnitt 3: Kopfgesteuerte Schleife (while) ===`n"

# Beispiel: Zahlen von 1 bis 5 ausgeben
$zahl = 1

while ($zahl -le 5) {
    Write-Host $zahl
    $zahl++
}


##############################################
# Abschnitt 4: Fußgesteuerte Schleife (do-while)
##############################################

Write-Host "`n=== Abschnitt 4: Fußgesteuerte Schleife (do-while) ===`n"

# Beispiel: Zahlen von 1 bis 5 ausgeben
$zahl = 1

do {
    Write-Host $zahl
    $zahl++
} while ($zahl -le 5)


##############################################
# Abschnitt 5: Zählerschleife (for)
##############################################

Write-Host "`n=== Abschnitt 5: Zählerschleife (for) ===`n"

# Beispiel: Zahlen von 1 bis 5 ausgeben
for ($zahl = 1; $zahl -le 5; $zahl++) {
    Write-Host $zahl
}


##############################################
# Abschnitt 6: Zählerschleife (foreach)
##############################################

Write-Host "`n=== Abschnitt 6: Zählerschleife (foreach) ===`n"

# Beispiel: Elemente in einem Array ausgeben
$tiere = "Hund", "Katze", "Maus"

foreach ($tier in $tiere) {
    Write-Host $tier
}
