##############################################
# Abschnitt 1: Try-Catch
##############################################

Write-Host "=== Abschnitt 1: Try-Catch ===`n"

try {
    # Möglicherweise fehlerhafter Code
    $result = 10 / 0  # Division durch Null verursacht einen Fehler
} catch {
    # Ausnahmebehandlung
    Write-Host "Fehler aufgetreten: Es wurde versucht, durch 0 (null) zu teilen."
}


##############################################
# Abschnitt 2: Finally
##############################################

Write-Host "`n=== Abschnitt 2: Finally ===`n"

try {
    ### Möglicherweise fehlerhafter Code ###
    $file = "C:\NichtVorhanden.txt"
    # -ErrorAction Stop sorgt dafür, dass definitiv abgebrochen wird.
    # Ohne diesen Parameter wird man nicht im catch landen
    $content = Get-Content $file -ErrorAction Stop
} catch {
    ### Ausnahmebehandlung: Allgemeiner Fehler ###
    Write-Host "Fehler beim Lesen der Datei: $($Error[0].Exception.Message)"
} finally {
    ### Code, der immer ausgeführt wird, unabhängig davon, ob eine Ausnahme auftritt oder nicht ###
    if ($content) {
        Write-Host "Inhalt der Datei: $content"
    } else {
        Write-Host "Die Datei konnte nicht gelesen werden."
    }
}


##############################################
# Abschnitt 3: Throw
##############################################

Write-Host "`n=== Abschnitt 3: Throw ===`n"

### Funktion, die eine Ausnahme auslöst ###
function Divide($a, $b) {
    if ($b -eq 0) {
        throw "Division durch 0 ist nicht erlaubt."
    }
    $result = $a / $b
    $result
}

try {
    $result = Divide 10 0
    Write-Host "Ergebnis: $result"
} catch {
    Write-Host "Fehler aufgetreten: $($_.Exception.Message)"
}


##############################################
# Abschnitt 4: Try-Catch bei Get- Cmdlets
##############################################

Write-Host "`n=== Abschnitt 4: Try-Catch bei Get- Cmdlets ===`n"

try {
    $process = Get-Process -Name "NonexistentProcess" -ErrorAction Stop
    Write-Host "Prozess gefunden: $($process.Name)"
} catch [Microsoft.PowerShell.Commands.ProcessCommandException] {
    Write-Host "Fehler beim Abrufen des Prozesses: Es wurde kein Prozess mit dem angegebenen Namen gefunden."
} catch {
    Write-Host "Fehler beim Abrufen des Prozesses: $($Error[0].Exception.Message)"
}

##############################################
# Abschnitt 10: Verbose-Ausgaben
##############################################

Write-Output "`n=== Abschnitt 10: Verbose-Ausgaben ===`n"

$strText10 = Read-Host "Gib einen Text ein"

# Entferne -verbose, sodass der Text nicht angezeigt wird.
# Dies ist eine sinnvolle Verwendung bei Funktionen um zusätzliche
# Informationen anzeigen zu lassen.
Write-Output "Der Text wird jetzt verarbeitet..."
Write-Verbose "Der eingegebene Text lautet: $strText10" -verbose

# Weitere Verarbeitungsschritte hier...

Write-Output "Die Verarbeitung des Textes wurde abgeschlossen."