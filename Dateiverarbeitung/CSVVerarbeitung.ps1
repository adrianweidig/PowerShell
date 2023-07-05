# PowerShell zeigt meine Ausgaben in der falschen Reihenfolge an?
# https://stackoverflow.com/questions/54344622/why-my-powershell-script-is-not-respecting-the-steps-order

##############################################
# Abschnitt 1: CSV-Datei erstellen
##############################################

Write-Output "=== Abschnitt 1: CSV-Datei erstellen ===`n"

# Pfad zur neuen CSV-Datei festlegen
$neueCsvDatei = "CSV-Datei.csv"

# Daten für die CSV-Datei erstellen
$csvDaten = @(
    [pscustomobject]@{
        Name = "Max Mustermann"
        Alter = 25
        Stadt = "Berlin"
    }
    [pscustomobject]@{
        Name = "Erika Musterfrau"
        Alter = 30
        Stadt = "Hamburg"
    }
    [pscustomobject]@{
        Name = "Hans Meier"
        Alter = 35
        Stadt = "München"
    }
)

# CSV-Datei erstellen und Daten speichern mit UTF-8 Encoding
$csvDaten | Export-Csv -Path $neueCsvDatei -NoTypeInformation -Encoding UTF8

# Erfolgsmeldung anzeigen
Write-Output "Die neue CSV-Datei wurde erfolgreich erstellt: $neueCsvDatei"


##############################################
# Abschnitt 2: CSV-Datei einlesen
##############################################

Write-Output "=== Abschnitt 2: CSV-Datei einlesen ===`n"

# Pfad zur CSV-Datei festlegen
$csvDatei = "CSV-Datei.csv"

# CSV-Datei einlesen und Daten in ein Array speichern
$csvDaten = Import-Csv -Path $csvDatei

# Ausgabe der eingelesenen Daten
Write-Output "Die CSV-Datei wurde erfolgreich eingelesen. Enthaltene Spalten:"
$csvDaten[0] | Get-Member -MemberType NoteProperty | ForEach-Object {
    Write-Output $_.Name
}


##############################################
# Abschnitt 3: CSV-Daten filtern
##############################################

Write-Output "`n=== Abschnitt 3: CSV-Daten filtern ===`n"

# Filterkriterien festlegen
$filterSpalte = "Alter"
$filterWert = 30

# CSV-Daten nach Filterkriterien filtern
$gefilterteDaten = $csvDaten | Where-Object { $_.$filterSpalte -gt $filterWert }

# Ausgabe der gefilterten Daten
Write-Output "Die CSV-Daten wurden erfolgreich gefiltert. Enthaltene Datensätze:"
$gefilterteDaten


##############################################
# Abschnitt 4: CSV-Daten bearbeiten
##############################################

Write-Output "`n=== Abschnitt 4: CSV-Daten bearbeiten ===`n"

# Spalte für die Bearbeitung auswählen
$bearbeitungsSpalte = "Name"

# Neue Werte für die ausgewählte Spalte festlegen
$newValues = $gefilterteDaten | ForEach-Object {
    $_.$bearbeitungsSpalte = "Bearbeitet - " + $_.$bearbeitungsSpalte
    $_
}

# Ausgabe der bearbeiteten Daten
Write-Output "Die CSV-Daten wurden erfolgreich bearbeitet. Enthaltene Datensätze:"
$newValues


##############################################
# Abschnitt 5: CSV-Datei speichern
##############################################

Write-Output "`n=== Abschnitt 5: CSV-Datei speichern ===`n"

# Neuen Dateinamen festlegen
$neuerDateiname = "NeueCSV-Datei.csv"

# CSV-Daten in eine neue CSV-Datei speichern mit UTF-8 Encoding
$newValues | Export-Csv -Path $neuerDateiname -NoTypeInformation -Encoding UTF8

# Erfolgsmeldung anzeigen
Write-Output "Die bearbeiteten Daten wurden erfolgreich in eine neue CSV-Datei gespeichert: $neuerDateiname"

##############################################
# Abschnitt 6: CSV-Datei löschen
##############################################

Write-Output "`n=== Abschnitt 6: CSV-Datei löschen ===`n"

# Pfad zur zu löschenden CSV-Datei festlegen
$zuLoeschendeCsvDatei = "CSV-Datei.csv"
$zuLoeschendeCsvDatei2 = "NeueCSV-Datei.csv"

# CSV-Datei löschen
Remove-Item -Path $zuLoeschendeCsvDatei -Force
Remove-Item -Path $zuLoeschendeCsvDatei2 -Force

# Erfolgsmeldung anzeigen
Write-Output "Die CSV-Datei wurde erfolgreich gelöscht: $zuLoeschendeCsvDatei"
