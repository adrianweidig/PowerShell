# Gute Quellen:
# https://learn.microsoft.com/de-de/powershell/module/microsoft.powershell.utility/get-date?view=powershell-7.3
# https://www.msxfaq.de/code/powershell/psdatetime.htm

##############################################
# Abschnitt 1: Aktuelles Datum anzeigen
##############################################

Write-Host "=== Abschnitt 1: Aktuelles Datum anzeigen ===`n"

# Aktuelles Datum abrufen
$aktuellesDatum = Get-Date

Write-Host "Das aktuelle Datum ist: $($aktuellesDatum.ToString('dd.MM.yyyy'))"


##############################################
# Abschnitt 2: Aktuelle Uhrzeit anzeigen
##############################################

Write-Host "`n=== Abschnitt 2: Aktuelle Uhrzeit anzeigen ===`n"

# Aktuelle Uhrzeit abrufen
$aktuelleUhrzeit = Get-Date

Write-Host "Die aktuelle Uhrzeit ist: $($aktuelleUhrzeit.ToString('HH:mm:ss'))"


##############################################
# Abschnitt 3: Datum und Uhrzeit kombinieren
##############################################

Write-Host "`n=== Abschnitt 3: Datum und Uhrzeit kombinieren ===`n"

# Aktuelles Datum und Uhrzeit abrufen
$aktuellesDatumUndUhrzeit = Get-Date

Write-Host "Das aktuelle Datum und die Uhrzeit sind: $($aktuellesDatumUndUhrzeit.ToString('dd.MM.yyyy HH:mm:ss'))"


##############################################
# Abschnitt 4: Zeitzone ändern
##############################################

Write-Host "`n=== Abschnitt 4: Zeitzone ändern ===`n"

# Aktuelle Zeitzone abrufen
$aktuelleZeitzone = (Get-TimeZone).DisplayName

# Neue Zeitzone festlegen
$neueZeitzone = 'Pacific Standard Time'

# Zeitzone ändern (Anhand des Parameters Id (Identifikation) und der Zeitzone als String)
Set-TimeZone -Id $neueZeitzone

# Aktualisierte Zeitzone anzeigen
$aktualisierteZeitzone = (Get-TimeZone).DisplayName
Write-Host "Die Zeitzone wurde von '$aktuelleZeitzone' auf '$aktualisierteZeitzone' geändert."


##############################################
# Abschnitt 5: Datum und Zeit berechnen
##############################################

Write-Host "`n=== Abschnitt 5: Datum und Zeit berechnen ===`n"

# Datum in der Zukunft berechnen
$zukuenftigesDatum = (Get-Date).AddDays(7)

# Differenz zwischen zwei Daten berechnen
$erstesDatum = Get-Date -Year 2022 -Month 1 -Day 1
$zweitesDatum = Get-Date -Year 2023 -Month 1 -Day 1
$differenzInTagen = ($zweitesDatum - $erstesDatum).Days

Write-Host "Das Datum in einer Woche ist: $($zukuenftigesDatum.ToString('dd.MM.yyyy'))"
Write-Host "Die Anzahl der Tage zwischen dem 01.01.2022 und dem 01.01.2023 beträgt: $differenzInTagen"


##############################################
# Abschnitt 6: Datums- und Zeitangaben analysieren
##############################################

Write-Host "`n=== Abschnitt 6: Datums- und Zeitangaben analysieren ===`n"

# Datum und Zeit aus einem String analysieren
$datumString = '2022-12-31'
$zeitString = '23:59:59'
$analyseErgebnis = [DateTime]::Parse("$datumString $zeitString")

Write-Host "Das analysierte Datum und die Zeit sind: $($analyseErgebnis.ToString('dd.MM.yyyy HH:mm:ss'))"


##############################################
# Abschnitt 7: Datum und Zeit vergleichen
##############################################

Write-Host "`n=== Abschnitt 7: Datum und Zeit vergleichen ===`n"

# Benutzer gibt das erste Datum ein
$erstesDatum = Read-Host "Geben Sie das erste Datum ein (Format: TT.MM.JJJJ)"

# Benutzer gibt das zweite Datum ein
$zweitesDatum = Read-Host "Geben Sie das zweite Datum ein (Format: TT.MM.JJJJ)"

# Datumswerte analysieren und vergleichen
try {
    $erstesDatumObjekt = [DateTime]::ParseExact($erstesDatum, "dd.MM.yyyy", $null)
    $zweitesDatumObjekt = [DateTime]::ParseExact($zweitesDatum, "dd.MM.yyyy", $null)

    # Vergleich der Datumswerte
    $vergleichErgebnis = $erstesDatumObjekt.CompareTo($zweitesDatumObjekt)

    # Vergleichsergebnis anzeigen
    if ($vergleichErgebnis -lt 0) {
        Write-Host "Das erste Datum liegt vor dem zweiten Datum."
    } elseif ($vergleichErgebnis -gt 0) {
        Write-Host "Das erste Datum liegt nach dem zweiten Datum."
    } else {
        Write-Host "Die beiden Daten sind identisch."
    }
} catch {
    Write-Host "Ungültiges Datumsformat. Bitte geben Sie das Datum im Format TT.MM.JJJJ ein."
}

##############################################
# Abschnitt 8: Formatierung von Datum
##############################################

Write-Host "`n=== Abschnitt 8: Formatierung von Datum ===`n"

# Aktuelles Datum abrufen
$aktuellesDatum = Get-Date

# Datumsformatierungen mit dem Parameter -f
$formatiertesDatum1 = "{0:dd.MM.yyyy}" -f $aktuellesDatum
Write-Host "Formatiertes Datum (TT.MM.JJJJ): $formatiertesDatum1"

$formatiertesDatum2 = "{0:yyyy-MM-dd}" -f $aktuellesDatum
Write-Host "Formatiertes Datum (JJJJ-MM-TT): $formatiertesDatum2"

$formatiertesDatum3 = "{0:ddd, dd MMM yyyy}" -f $aktuellesDatum
Write-Host "Formatiertes Datum (Wochentag, TT Monat JJJJ): $formatiertesDatum3"

$formatiertesDatum4 = "{0:D}" -f $aktuellesDatum
Write-Host "Formatiertes Datum (Langes Datum): $formatiertesDatum4"


