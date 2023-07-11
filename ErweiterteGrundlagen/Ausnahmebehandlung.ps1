# Setzt das Skript auch bei Error weiter fort
$ErrorActionPreference = "Continue"

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
# Abschnitt 5: Trap
##############################################

# Beachte, dass die Trap, egal wo sie im Code steht,
# immer ausgelöst wird sobald ein Fehler auftritt. 
# Wobei der letzte Aufruf einer Trap der "wertendste"
# ist. In diesem Fall wird die Abschnitt 5 Trap für alle
# Ausnahmen genutzt aber vorrangig die Trap aus Abschnitt 6
# für betroffene Ausnahmen von RuntimeException

Write-Host "`n=== Abschnitt 5: Trap ===`n"

trap {
    # Ausnahmebehandlung im Trap-Block
    Write-Host "Eine Ausnahme wurde ausgelöst: $($_.Exception.Message)"
}


# Möglicherweise fehlerhafter Code
$variable = "Wert"
$undefinierteVariable  # Verursacht eine Ausnahme, da die Variable nicht definiert ist

##############################################
# Abschnitt 6: Trap mit spezifischem FehlerTyp
##############################################

Write-Host "`n=== Abschnitt 6: Trap mit spezifischem FehlerTyp ===`n"

trap [System.Management.Automation.RuntimeException] {
    # Ausnahmebehandlung im Trap-Block für den spezifischen FehlerTyp
    Write-Host "Eine RuntimeException wurde ausgelöst: $($_.Exception.Message)"
} 

# Möglicherweise fehlerhafter Code
throw "Dies ist eine Test-RuntimeException."

##############################################
# Abschnitt 7: Exit und Exitcodes
##############################################

Write-Host "`n=== Abschnitt 7: Exit und Exitcodes ===`n"

function PerformCleanup {
    # Führe Aufräumarbeiten durch
    Write-Host "Aufräumarbeiten werden durchgeführt..."
    # ...
    Write-Host "Aufräumarbeiten abgeschlossen."
}

function DoSomething {
    try {
        # Möglicherweise fehlerhafter Code
        $result = 10 / 0  # Division durch Null verursacht einen Fehler
    } catch {
        # Ausnahmebehandlung
        Write-Host "Fehler aufgetreten: Es wurde versucht, durch 0 (null) zu teilen."
        # Führe Aufräumarbeiten durch, bevor das Skript abbricht
        PerformCleanup
        # Beim Aufruf von Exit kann kein weiterer Code ausgeführt werden
        # daher weise ich hier nun nur den Exitcode zu

        # Exit 1  # Beende das Skript mit Fehlercode 1

        return 1
    }
}

$exitCode = DoSomething

# Hier wird der Exitcode des Skripts ausgewertet

# Mit $LASTEXITCODE würde man den zuletzt ausgeworfenen Exitcode erhalten
# $exitCode = $LASTEXITCODE
Write-Host "Exitcode: $exitCode"

# Führe basierend auf dem Exitcode weitere Aktionen durch
switch ($exitCode) {
    0 {
        Write-Host "Das Skript wurde erfolgreich ausgeführt."
        # Führe weitere Aktionen aus...
    }
    1 {
        Write-Host "Das Skript wurde mit einem Fehler beendet."
        # Führe Fehlerbehandlung aus...
    }
    default {
        Write-Host "Ungültiger Exitcode: $exitCode"
    }
}