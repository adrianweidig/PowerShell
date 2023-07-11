<#
Write-* Kommandos in PowerShell

+-------------------------+--------------------------------------------------------+------------------------------------------+
|       Write-Kommando    |                  Voraussetzungen                       |                Auswirkungen               |
+-------------------------+--------------------------------------------------------+------------------------------------------+
|     Write-Output        | Keine besonderen Voraussetzungen                       | Schreibt Text auf die Pipeline            |
|     Write-Host          | Keine besonderen Voraussetzungen                       | Gibt Text auf der Konsole aus             |
|     Write-Warning       | Keine besonderen Voraussetzungen                       | Gibt eine Warnmeldung aus                 |
|     Write-Error         | Keine besonderen Voraussetzungen                       | Gibt eine Fehlermeldung aus               |
|     Write-Verbose       | Verbose-Schalter (-Verbose) erforderlich               | Gibt ausführliche Informationen aus       |
|     Write-Debug         | Debug-Schalter (-Debug) erforderlich                   | Gibt Debugging-Informationen aus          |
|     Write-Information   | Information-Schalter (-InformationAction) erforderlich | Gibt Informationen aus                    |
|     Write-Progress      | Keine besonderen Voraussetzungen                       | Gibt Fortschrittsinformationen aus        |
+-------------------------+--------------------------------------------------------+------------------------------------------+
#>

function write-commands {

##############################################
# Abschnitt 1: Write-Output
##############################################

<#
Voraussetzungen:
- Keine besonderen Voraussetzungen.

Auswirkungen:
- Schreibt den angegebenen Text auf die Pipeline (Standardausgabe).
- Der Text wird an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

Write-Output "Dies ist ein Text, der auf die Pipeline geschrieben wird."


##############################################
# Abschnitt 2: Write-Host
##############################################

<#
Voraussetzungen:
- Keine besonderen Voraussetzungen.

Auswirkungen:
- Gibt den angegebenen Text auf der Konsole aus.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

Write-Host "Dieser Text wird auf der Konsole ausgegeben."


##############################################
# Abschnitt 3: Write-Warning
##############################################

<#
Voraussetzungen:
- Keine besonderen Voraussetzungen.

Auswirkungen:
- Gibt eine Warnmeldung mit dem angegebenen Text aus.
- Die Warnmeldung wird auf der Konsole angezeigt.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

Write-Warning "Achtung! Dies ist eine Warnmeldung."

##############################################
# Abschnitt 4: Write-Verbose
##############################################

<#
Voraussetzungen:
- Das Skript oder der Befehl muss mit dem Verbose-Schalter (z.B. -Verbose) ausgeführt werden.

Auswirkungen:
- Gibt eine ausführliche Information für Debugging-Zwecke aus.
- Die Ausgabe erfolgt nur dann, wenn das Skript oder der Befehl mit dem Verbose-Schalter ausgeführt wird.
- Die Information wird auf der Konsole angezeigt.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

Write-Verbose "Dies ist eine ausführliche Information für Debugging-Zwecke."


##############################################
# Abschnitt 5: Write-Debug
##############################################

<#
Voraussetzungen:
- Das Skript oder der Befehl muss mit dem Debug-Schalter (z.B. -Debug) ausgeführt werden.

Auswirkungen:
- Gibt Debugging-Informationen aus.
- Die Ausgabe erfolgt nur dann, wenn das Skript oder der Befehl mit dem Debug-Schalter ausgeführt wird.
- Die Informationen werden auf der Konsole angezeigt.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

Write-Debug "Dies ist eine Debugging-Nachricht."


##############################################
# Abschnitt 6: Write-Information
##############################################

<#
Voraussetzungen:
- Das Skript oder der Befehl muss mit dem Information-Schalter (z.B. -InformationAction Continue) ausgeführt werden.

Auswirkungen:
- Gibt Informationen mit den angegebenen Daten aus.
- Die Ausgabe erfolgt nur dann, wenn das Skript oder der Befehl mit dem Information-Schalter ausgeführt wird.
- Die Informationen werden auf der Konsole angezeigt.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

Write-Information -MessageData @{
    "Information" = "Dies ist eine Information.";
    "MoreInfo" = "Weitere Informationen finden Sie unter http://example.com.";
}


##############################################
# Abschnitt 7: Write-Progress
##############################################

<#
Voraussetzungen:
- Keine besonderen Voraussetzungen.

Auswirkungen:
- Gibt Fortschrittsinformationen aus.
- Die Ausgabe erfolgt in Form einer Fortschrittsleiste auf der Konsole.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
#>

$dauer = 5
$intervall = 0.1
$gesamtIterationen = $dauer / $intervall

for ($aktuelleIteration = 0; $aktuelleIteration -lt $gesamtIterationen; $aktuelleIteration++) {
    $fortschritt = ($aktuelleIteration / $gesamtIterationen) * 100
    Write-Progress -Activity "Aktivität" -Status "In Bearbeitung" -PercentComplete $fortschritt -SecondsRemaining ($dauer - ($aktuelleIteration * $intervall))
    Start-Sleep -Seconds $intervall
}


##############################################
# Abschnitt 8: Write-Error
##############################################

<#
Voraussetzungen:
- Keine besonderen Voraussetzungen.

Auswirkungen:
- Gibt eine Fehlermeldung mit dem angegebenen Text aus.
- Die Fehlermeldung wird auf der Konsole angezeigt.
- Der Text wird nicht an das nächste Cmdlet in der Pipeline weitergeleitet.
- Das Cmdlet führt zum Beenden des Skripts mit einem Fehlerstatus.
#>

Write-Error "Ein Fehler ist aufgetreten."

}

# Beachte, dass aufgrund von Write-Error wirklich abgebrochen wird
write-commands -Verbose -InformationAction Continue -Debug
