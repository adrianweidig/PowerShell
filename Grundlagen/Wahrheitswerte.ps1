<#     
-eq: (equal)            Prüft, ob zwei Werte gleich sind.
-lt: (lower-than)       Prüft, ob ein Wert kleiner ist als ein anderer Wert.
-gt: (greater-than)     Prüft, ob ein Wert größer ist als ein anderer Wert.
-le: (lower-equal)      Prüft, ob ein Wert kleiner oder gleich einem anderen Wert ist.
-ge: (greater-equal)    Prüft, ob ein Wert größer oder gleich einem anderen Wert ist.
-ne: (not-equal)        Prüft, ob zwei Werte ungleich sind. 
#>

##############################################
# Abschnitt 1: Wahrheitswerte in Powershell
##############################################

Write-Host "### Abschnitt 1: Wahrheitswerte in Powershell ###`n"

# Wahrheitswerte erstellen
$wahr = $true
$falsch = $false

# Wahrheitswerte ausgeben
Write-Host "Der Wert von $ wahr ist: $wahr"
Write-Host "Der Wert von $ falsch ist: $falsch`n"


##############################################
# Abschnitt 2: Logische Operatoren
##############################################

Write-Host "### Abschnitt 2: Logische Operatoren ###`n"

# Logische Operatoren auf Wahrheitswerte anwenden
$ergebnisUnd = $wahr -and $falsch
$ergebnisOder = $wahr -or $falsch
$ergebnisNicht = -not $wahr

# Ergebnisse ausgeben
Write-Host "Ergebnis des logischen UND-Operators ($ wahr -and $ falsch): $ergebnisUnd"
Write-Host "Ergebnis des logischen ODER-Operators ($ wahr -or $ falsch): $ergebnisOder"
Write-Host "Ergebnis des logischen NICHT-Operators (-not $ wahr): $ergebnisNicht`n"


##############################################
# Abschnitt 3: Vergleichsoperatoren
##############################################

Write-Host "### Abschnitt 3: Vergleichsoperatoren ###`n"

# Beispiele für Vergleichsoperatoren

# Gleichheitsvergleich
$zahl1 = 10
$zahl2 = 10
$gleichheitsVergleich = $zahl1 -eq $zahl2
Write-Host "Gleichheitsvergleich: $ zahl1 -eq $ zahl2 -> $gleichheitsVergleich"

# Kleiner-als-Vergleich
$zahl3 = 5
$kleinerAlsVergleich = $zahl3 -lt $zahl1
Write-Host "Kleiner-als-Vergleich: $ zahl3 -lt $ zahl1 -> $kleinerAlsVergleich"

# Größer-als-Vergleich
$zahl4 = 15
$groesserAlsVergleich = $zahl4 -gt $zahl1
Write-Host "Größer-als-Vergleich: $ zahl4 -gt $ zahl1 -> $groesserAlsVergleich"

# Kleiner-oder-gleich-Vergleich
$zahl5 = 10
$kleinerOderGleichVergleich = $zahl5 -le $zahl1
Write-Host "Kleiner-oder-gleich-Vergleich: $ zahl5 -le $ zahl1 -> $kleinerOderGleichVergleich"

# Größer-oder-gleich-Vergleich
$zahl6 = 10
$groesserOderGleichVergleich = $zahl6 -ge $zahl1
Write-Host "Größer-oder-gleich-Vergleich: $ zahl6 -ge $ zahl1 -> $groesserOderGleichVergleich"

# Ungleichheitsvergleich
$zahl7 = 20
$ungleichheitsVergleich = $zahl7 -ne $zahl1
Write-Host "Ungleichheitsvergleich: $ zahl7 -ne $ zahl1 -> $ungleichheitsVergleich"
