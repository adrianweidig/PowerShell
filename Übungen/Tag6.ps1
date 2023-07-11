<# 
Aufgabe 01: (Version 1.30 vom 02. Mai 2022)

Schreiben Sie eine Funktion, welche die Meldungen des Ereignisprotokolls 
"y" der letzten "x" Stunden auf Konsole anzeigt, wahlweise ueber einen 
Switch-Parameter auch in einer anderen Farbkombinationen (Vordergrund rot
und Hintergrund gelb). 
Das Ausgeben auf Konsole soll über einen Parameter an- bzw. abschaltbar 
sein.
Die Meldungen sollen auf die Eigenschaften "Entrytype","Time","InstanceID"
und "Message" reduziert werden.
Als Return-Code soll nur die Anzahl der Meldungen zurückgegeben werden.

x --> Anzahl der Stunden variabel ueber Parameter (Standard 24 Stunden,
      minimal 1 Stunde, maximal 240 Stunden)
y --> Protokolltyp (Standard "System"); Protokolltyp soll nur auswaehlbar
      sein aus "System","Application" oder "Security"

Zusaetzlich soll die Auswahl der Art der Meldungen ("Error", "Warning" oder
"Information") ueber einen Parameter auswaehlbar sein (Standard "Error").

Optional:
Geben Sie zusaetzlich an passenden Stellen "verbose"-Meldungen (ausfuehrlich)
aus! 
#>


<# 
Aufgabe 01: (Version 1.30 vom 02. Mai 2022)

Schreiben Sie eine Funktion, welche die Meldungen des Ereignisprotokolls 
"y" der letzten "x" Stunden auf Konsole anzeigt, wahlweise ueber einen 
Switch-Parameter auch in einer anderen Farbkombinationen (Vordergrund rot
und Hintergrund gelb). 
Das Ausgeben auf Konsole soll über einen Parameter an- bzw. abschaltbar 
sein.
Die Meldungen sollen auf die Eigenschaften "Entrytype","Time","InstanceID"
und "Message" reduziert werden.
Als Return-Code soll nur die Anzahl der Meldungen zurückgegeben werden.

x --> Anzahl der Stunden variabel ueber Parameter (Standard 24 Stunden,
      minimal 1 Stunde, maximal 240 Stunden)
y --> Protokolltyp (Standard "System"); Protokolltyp soll nur auswaehlbar
      sein aus "System","Application" oder "Security"

Zusaetzlich soll die Auswahl der Art der Meldungen ("Error", "Warning" oder
"Information") ueber einen Parameter auswaehlbar sein (Standard "Error").

Optional:
Geben Sie zusaetzlich an passenden Stellen "verbose"-Meldungen (ausfuehrlich)
aus! 
#>

function Get-EreignisprotokollMeldungen {
    [CmdletBinding()]
    param (
        [ValidateRange(1,240)]
        [int]$Stunden = 24,
        [ValidateSet("System", "Application", "Security")]
        [string]$ProtokollTyp = "System",
        [ValidateSet("Error", "Warning", "Information","SuccessAudit", "FailureAudit")]
        [string]$MeldungsTyp = "Error",
        [switch]$FarbigeAusgabe,
        [switch]$Text
    )

    if (($ProtokollTyp -eq "System" -or $ProtokollTyp -eq "Application") -and
        ($MeldungsTyp -ne "Error" -and $MeldungsTyp -ne "Warning" -and $MeldungsTyp -ne "Information")) {
        Write-Host "Für den Protokolltyp '$ProtokollTyp' ist nur 'Error', 'Warning' oder 'Information' als Meldungstyp erlaubt."
        return
    }

    if (($ProtokollTyp -eq "Security") -and 
        ($MeldungsTyp -ne "SuccessAudit" -and $MeldungsTyp -ne "FailureAudit")) {
        Write-Host "Für den Protokolltyp '$ProtokollTyp' ist nur 'SuccessAudit' oder 'FailureAudit' als Meldungstyp erlaubt."
        return
    }
    
    Write-Verbose "`n==== Einstellungen ==="
    Write-Verbose "Anzahl Stunden: $Stunden"
    Write-Verbose "ProtokollTyp: $ProtokollTyp"
    Write-Verbose "MeldungsTyp: $MeldungsTyp"
    Write-Verbose "FarbigeAusgabe: $FarbigeAusgabe"
    Write-Verbose "`n=======================`n"

    $ereignisse = Get-EventLog -LogName $ProtokollTyp -After (Get-Date).AddHours(-$Stunden) -EntryType $MeldungsTyp |
                  Select-Object -Property EntryType, TimeGenerated, InstanceID, Message

    if ($Text) {
        if ($FarbigeAusgabe) {
            Write-Verbose "`n==== Farbige Auswahl aktiviert ==="
            $ereignisse | ForEach-Object {
                Write-Host "`Meldungstyp: $($_.EntryType) - Datum: $($_.TimeGenerated) - InstanzID: $($_.InstanceID)`n" -ForegroundColor Red -BackgroundColor Yellow -NoNewline
                Write-Host "$($_.Message)" -ForegroundColor Yellow -BackgroundColor Red
            }
        } else {
            Write-Verbose "`n==== Farbige Auswahl deaktiviert ==="
            $ereignisse | ForEach-Object {
                Write-Host "`n$($_.EntryType)  $($_.TimeGenerated)  $($_.InstanceID)  $($_.Message)"
            }
        }
    }

    return $ereignisse.Count
}

Get-EreignisprotokollMeldungen -Stunden 240 -ProtokollTyp "System" -MeldungsTyp "Error" -FarbigeAusgabe -Text -Verbose
