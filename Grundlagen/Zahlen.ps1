##############################################
# Abschnitt 1: Grundrechenarten
##############################################

# Benutzer gibt die Werte für zahl1 und zahl2 ein
Write-Host "=== Abschnitt 1: Grundrechenarten ===`n"
$zahl1 = [int](Read-Host "Gib den Wert für zahl1 ein")
$zahl2 = [int](Read-Host "Gib den Wert für zahl2 ein")

# Addition von zahl1 und zahl2
$ergebnisAddition = $zahl1 + $zahl2
Write-Host "`nDas Ergebnis von $zahl1 + $zahl2 ist: $ergebnisAddition`n"

# Subtraktion von zahl1 und zahl2
$ergebnisSubtraktion = $zahl1 - $zahl2
Write-Host "Das Ergebnis von $zahl1 - $zahl2 ist: $ergebnisSubtraktion`n"

# Multiplikation von zahl1 und zahl2
$ergebnisMultiplikation = $zahl1 * $zahl2
Write-Host "Das Ergebnis von $zahl1 * $zahl2 ist: $ergebnisMultiplikation`n"

# Division von zahl1 und zahl2
$ergebnisDivision = $zahl1 / $zahl2
Write-Host "Das Ergebnis von $zahl1 / $zahl2 ist: $ergebnisDivision`n"

# Modulo-Operation (Restwert) von zahl1 und zahl2
$ergebnisModulo = $zahl1 % $zahl2
Write-Host "Das Ergebnis von $zahl1 % $zahl2 ist: $ergebnisModulo`n"

# Potenzierung von zahl1 mit zahl2
$ergebnisPotenzierung = [math]::Pow($zahl1, $zahl2)
Write-Host "Das Ergebnis von $zahl1 hoch $zahl2 ist: $ergebnisPotenzierung`n"

# Vergleich von zahl1 und zahl2
# gt = greater than
$ergebnisVergleich = $zahl1 -gt $zahl2
Write-Host "Ist $zahl1 größer als $zahl2 ? $ergebnisVergleich`n"

# lt = lower than
$ergebnisVergleich = $zahl1 -lt $zahl2
Write-Host "Ist $zahl1 kleiner als $zahl2 ? $ergebnisVergleich`n"

# Runden von zahl1
$gerundet = [math]::Round($zahl1)
Write-Host "Die gerundete Zahl von $zahl1 ist: $gerundet`n"


##############################################
# Abschnitt 2: Typkonvertierung von Zahlen
##############################################

# Benutzer gibt eine Ganzzahl ein und konvertiert sie in einen Integer
Write-Host "=== Abschnitt 2: Typkonvertierung von Zahlen ===`n"
$ganzzahl = [int](Read-Host "Gib eine Ganzzahl ein")

# Benutzer gibt eine Gleitkommazahl ein und konvertiert sie in eine Float-Zahl
$gleitkommazahl = [float](Read-Host "Gib eine Gleitkommazahl ein")

# Benutzer gibt eine Zeichenkette ein und konvertiert sie in eine Ganzzahl (falls möglich)
$zeichenkette = Read-Host "Gib eine Zeichenkette ein"
$ganzzahlAusZeichenkette = [int]$zeichenkette

# Typüberprüfung
Write-Host "`n=== Typüberprüfung ==="
Write-Host "ganzzahl ist ein Integer? $($ganzzahl -is [int])"
Write-Host "gleitkommazahl ist ein Float? $($gleitkommazahl -is [float])" # Beachte, dass dem System egal ist ob Nachkommastellen vorhanden sind
Write-Host "zeichenkette ist ein String? $($zeichenkette -is [string])"
Write-Host "ganzzahlAusZeichenkette ist ein Integer? $($ganzzahl -is [int])`n"

# Ergebnisse ausgeben
Write-Host "=== Ergebnisse ==="
Write-Host "Ganzzahl: $ganzzahl"
Write-Host "Gleitkommazahl: $gleitkommazahl"
Write-Host "Ganzzahl aus Zeichenkette: $ganzzahlAusZeichenkette"


##############################################
# Abschnitt 3: Numerische Funktionen und Methoden
##############################################

# Sinus von zahl1
Write-Host "`n=== Abschnitt 3: Numerische Funktionen und Methoden ==="
$sinus = [math]::Sin($zahl1)
Write-Host "Sinus von $zahl1 ist: $sinus"

# Kosinus von zahl1
$kosinus = [math]::Cos($zahl1)
Write-Host "Kosinus von $zahl1 ist: $kosinus"

# Quadratwurzel von zahl1
$wurzel = [math]::Sqrt($zahl1)
Write-Host "Quadratwurzel von $zahl1 ist: $wurzel"

# Absolutwert von zahl1
$absolutwert = [math]::Abs($zahl1)
Write-Host "Absolutwert von $zahl1 ist: $absolutwert"

# Runden auf eine bestimmte Anzahl von Dezimalstellen
$gerundetAufDezimalstellen = [math]::Round($zahl1, 2)
Write-Host "Gerundet auf 2 Dezimalstellen: $gerundetAufDezimalstellen"

# Konvertierung von Zahl in Hexadezimalformat
$hexadezimal = [convert]::ToString($zahl1, 16)
Write-Host "Zahl $zahl1 in Hexadezimalformat: $hexadezimal"

# Konvertierung von Zahl in Binärformat
$binär = [convert]::ToString($zahl1, 2)
Write-Host "Zahl $zahl1 in Binärformat: $binär"


##############################################
# Abschnitt 4: Formatierung und Ausgabe von Zahlen
##############################################

Write-Host "`n=== Abschnitt 4: Formatierung und Ausgabe von Zahlen ==="

# Formatierungsoptionen für die Ausgabe von Zahlen
$zahlMitFormat = "{0:N2}" -f $zahl1
Write-Host "Zahl $zahl1 mit Formatierungsoptionen: $zahlMitFormat"

# Ausgabe von Zahl in wissenschaftlicher Notation
$wissenschaftlicheNotation = "{0:E2}" -f $zahl1
Write-Host "Zahl $zahl1 in wissenschaftlicher Notation: $wissenschaftlicheNotation"


##############################################
# Abschnitt 5: Zufallszahlen
##############################################

Write-Host "`n=== Abschnitt 5: Zufallszahlen ==="

# Zufallszahl zwischen 0 und 1 generieren
$zufallszahl = Get-Random
Write-Host "Zufallszahl zwischen 0 und 1: $zufallszahl"

# Zufallszahl in einem bestimmten Bereich generieren
$zufallszahlBereich = Get-Random -Minimum 1 -Maximum 100
Write-Host "Zufallszahl zwischen 1 und 100: $zufallszahlBereich"
