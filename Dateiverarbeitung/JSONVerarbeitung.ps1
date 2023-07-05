# PowerShell zeigt meine Ausgaben in der falschen Reihenfolge an?
# https://stackoverflow.com/questions/54344622/why-my-powershell-script-is-not-respecting-the-steps-order

##############################################
# Abschnitt 1: JSON-Datei erstellen
##############################################

Write-Output "=== Abschnitt 1: JSON-Datei erstellen ===`n"

# Pfad zur neuen JSON-Datei festlegen
$neueJsonDatei = "JSONDatei.json"

# Daten für die JSON-Datei erstellen
$jsonDaten = @(
    @{
        Name = "Max Mustermann"
        Alter = 25
        Stadt = "Berlin"
    }
    @{
        Name = "Erika Musterfrau"
        Alter = 30
        Stadt = "Hamburg"
    }
    @{
        Name = "Hans Meier"
        Alter = 35
        Stadt = "München"
    }
)

# JSON-Datei erstellen und Daten speichern mit UTF-8 Encoding
$jsonDaten | ConvertTo-Json | Out-File -FilePath $neueJsonDatei -Encoding UTF8

# Erfolgsmeldung anzeigen
Write-Output "Die neue JSON-Datei wurde erfolgreich erstellt: $neueJsonDatei"


##############################################
# Abschnitt 2: JSON-Datei einlesen
##############################################

Write-Output "`n=== Abschnitt 2: JSON-Datei einlesen ===`n"

# Pfad zur JSON-Datei festlegen
$jsonDatei = "JSONDatei.json"

# JSON-Datei einlesen und Daten in ein Array speichern
$jsonDaten = Get-Content -Raw -Path $jsonDatei | ConvertFrom-Json

# Ausgabe der eingelesenen Daten
Write-Output "Die JSON-Datei wurde erfolgreich eingelesen. Enthaltene Elemente:"
$jsonDaten


##############################################
# Abschnitt 3: JSON-Daten filtern
##############################################

Write-Output "`n=== Abschnitt 3: JSON-Daten filtern ===`n"

# Filterkriterien festlegen
$filterSpalte = "Alter"
$filterWert = 30

# JSON-Daten nach Filterkriterien filtern
$gefilterteDaten = $jsonDaten | Where-Object { $_.$filterSpalte -gt $filterWert }

# Ausgabe der gefilterten Daten
Write-Output "Die JSON-Daten wurden erfolgreich gefiltert. Enthaltene Datensätze:"
$gefilterteDaten


##############################################
# Abschnitt 4: JSON-Daten bearbeiten
##############################################

Write-Output "`n=== Abschnitt 4: JSON-Daten bearbeiten ===`n"

# Spalte für die Bearbeitung auswählen
$bearbeitungsSpalte = "Name"

# Neue Werte für die ausgewählte Spalte festlegen
$newValues = $gefilterteDaten | ForEach-Object {
    $_.$bearbeitungsSpalte = "Bearbeitet - " + $_.$bearbeitungsSpalte
    $_
}

# Ausgabe der bearbeiteten Daten
Write-Output "Die JSON-Daten wurden erfolgreich bearbeitet. Enthaltene Datensätze:"
$newValues

##############################################
# Abschnitt 5: JSON-Datei speichern
##############################################

Write-Output "`n=== Abschnitt 5: JSON-Datei speichern ===`n"

# Neuen Dateinamen festlegen
$neuerDateiname = "NeueJSONDatei.json"

# JSON-Daten in eine neue JSON-Datei speichern mit UTF-8 Encoding
$newValues | ConvertTo-Json | Out-File -FilePath $neuerDateiname -Encoding UTF8

# Erfolgsmeldung anzeigen
Write-Output "Die bearbeiteten Daten wurden erfolgreich in eine neue JSON-Datei gespeichert: $neuerDateiname"

##############################################
# Abschnitt 6: JSON-Datei löschen
##############################################

Write-Output "`n=== Abschnitt 6: JSON-Datei löschen ===`n"

# Pfad zur zu löschenden JSON-Datei festlegen
$zuLoeschendeJsonDatei = "JSONDatei.json"
$zuLoeschendeJsonDatei2 = "NeueJSONDatei.json"

# JSON-Datei löschen
Remove-Item -Path $zuLoeschendeJsonDatei -Force
Remove-Item -Path $zuLoeschendeJsonDatei2 -Force

# Erfolgsmeldung anzeigen
Write-Output "Die JSON-Datei wurde erfolgreich gelöscht."
