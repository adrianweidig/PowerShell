#requires -version 5.1

# Übergabeparameter
param(
    [string] $arbeitsVerzeichnis
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$VerbosePreference = 'Continue'   # Aktiviert Write-Verbose-Ausgaben

if (-not $arbeitsVerzeichnis) {
    # ermittelt das Verzeichnis, in dem dieses Skript liegt
    $arbeitsVerzeichnis = Split-Path -Parent $MyInvocation.MyCommand.Path
}
Write-Verbose "Arbeitsverzeichnis: $arbeitsVerzeichnis"


########################################
# Funktion : Schreib Logging mit Farben
########################################
function schreibeLog {
    param(
        [string] $nachricht,
        [ValidateSet('INFO','WARN','ERROR','DONE','DEBUG')]
        [string] $typ = 'INFO'
    )
    $farben = @{
        'INFO'  = 'Cyan'
        'WARN'  = 'Yellow'
        'ERROR' = 'Red'
        'DONE'  = 'Green'
        'DEBUG' = 'Gray'
    }
    Write-Host "[$typ] $nachricht" -ForegroundColor $farben[$typ]
}

########################################
# Funktion : Excel.Application starten
########################################
function starteExcel {
    schreibeLog 'Starte Excel-Anwendung...' 'INFO'
    $excelApp = New-Object -ComObject Excel.Application
    $excelApp.Visible = $false
    return $excelApp
}

########################################
# Funktion : Arbeitsbuch öffnen
########################################
function oeffneArbeitsbuch {
    param(
        $excelApp,
        [string] $pfad
    )
    if (-not (Test-Path $pfad)) {
        schreibeLog "Datei nicht gefunden : $pfad" 'ERROR'
        exit 1
    }
    try {
        $arbeitsbuch = $excelApp.Workbooks.Open($pfad)
        schreibeLog "Datei geöffnet : $pfad" 'INFO'
        return $arbeitsbuch
    } catch {
        schreibeLog "Fehler beim Öffnen : $pfad – $_" 'ERROR'
        exit 1
    }
}

########################################
# Funktion : Spaltenindex per Header ermitteln
########################################
function ermittleSpaltenIndex {
    param(
        $arbeitsblatt,
        [string] $headerName
    )
    Write-Verbose "Suche Header '$headerName' in Sheet '$($arbeitsblatt.Name)'"
    $zelle = $arbeitsblatt.UsedRange.Find($headerName)
    if (-not $zelle) {
        schreibeLog "Spalte '$headerName' nicht gefunden" 'ERROR'
        exit 1
    }
    Write-Verbose "Header '$headerName' gefunden in Zeile $($zelle.Row), Spalte $($zelle.Column)"
    return $zelle.Column
}

########################################
# Funktion : Ausgabe-Arbeitsbuch vorbereiten
########################################
function bereiteAusgabeVor {
    param(
        $excelApp,
        [string] $pfadAusgabe
    )
    if (Test-Path $pfadAusgabe) {
        schreibeLog "Lösche alte Datei: $pfadAusgabe" 'INFO'
        Remove-Item $pfadAusgabe -Force
    }
    $wbOut    = $excelApp.Workbooks.Add()
    $sheetOut = $wbOut.Sheets.Item(1)
    $kopf     = @('Anforderungspaket','Maßnahmentyp','Maßnahmenart','Projekt','Nr.','Soll-Maßnahme')
    for ($i = 0; $i -lt $kopf.Count; $i++) {
        $sheetOut.Cells.Item(1, $i + 1).Value2 = $kopf[$i]
    }
    schreibeLog "Kopfzeile gesetzt : $($kopf -join ', ')" 'INFO'
    return @{ wbOut = $wbOut; sheetOut = $sheetOut }
}

########################################
# Funktion : Metadaten (Maßnahmeart + Anforderungspaket)
# oberhalb einer Referenzzeile extrahieren
########################################
function extrahiereMetadatenOberhalb {
    param(
        $arbeitsblatt,
        [int] $spalteText,
        [int] $zeileStart,
        [int] $zeileKopf
    )
    $ergebnis = @{
        maßnahmeArt       = ''
        anforderungsPaket = ''
    }
    $muster = @{
        maßnahmeArt       = '^\d+\.\d+\.\d+\.\d+\.\s+(.+)$'
        anforderungsPaket = '^\d+\.\d+\.\d+\.\s+(.+)$'
    }

    for ($zeile = $zeileStart - 1; $zeile -gt $zeileKopf; $zeile--) {
        $zelleninhalt = $arbeitsblatt.Cells.Item($zeile, $spalteText).Value2
        if (-not $zelleninhalt) { continue }

        foreach ($schluessel in $muster.Keys) {
            if (-not $ergebnis[$schluessel] -and $zelleninhalt -match $muster[$schluessel]) {
                $erkannt = $matches[1].Trim()
                $ergebnis[$schluessel] = $erkannt
                switch ($schluessel) {
                    'maßnahmeArt'       { Write-Verbose "Art= '$erkannt' erkannt in Zeile $zeile" }
                    'anforderungsPaket' { Write-Verbose "Paket= '$erkannt' erkannt in Zeile $zeile" }
                }
            }
        }

        if ($ergebnis.maßnahmeArt -and $ergebnis.anforderungsPaket) {
            Write-Verbose "Beide Metadaten gefunden in Zeile $zeile : Art='$($ergebnis.maßnahmeArt)', Paket='$($ergebnis.anforderungsPaket)'"
            break
        }
    }

    return $ergebnis
}

########################################
# Funktion : Titel aus Maßnahmenblatt extrahieren
########################################
function extrahiereTitel {
    param(
        $sheetMass,
        [int] $zeile,
        [int] $spalteMassnahmenReferenz
    )
    $maxCol = $sheetMass.UsedRange.Columns.Count
    for ($c = $spalteMassnahmenReferenz + 1; $c -le $maxCol; $c++) {
        $wert = $sheetMass.Cells.Item($zeile, $c).Value2
        if ($wert) {
            $txt = ($wert -replace '[\r\n]+',' ').Trim()
            Write-Verbose "Titel gefunden in Zeile $zeile, Spalte $c : '$txt'"
            return $txt
        }
    }
    Write-Verbose "Kein Titel gefunden in Zeile $zeile"
    return ''
}

########################################
# Funktion : MergeArea-Zelle mit 'Anforderungsreferenz:' finden
########################################
function findeAnforderungsreferenzMergeArea {
    param(
        $sheetDesc,
        [string] $massnahmenReferenz
    )
    Write-Verbose "Suche Maßnahmenreferenz '$massnahmenReferenz' im Beschreibungs-Sheet"
    $startZelle = $sheetDesc.UsedRange.Find($massnahmenReferenz)
    if (-not $startZelle) {
        Write-Verbose "Maßnahmenreferenz '$massnahmenReferenz' nicht gefunden"
        return $null
    }
    Write-Verbose "Gefunden : Zeile $($startZelle.Row), Spalte $($startZelle.Column)"
    $maxRow = $sheetDesc.UsedRange.Row + $sheetDesc.UsedRange.Rows.Count - 1
    for ($r = $startZelle.Row + 1; $r -le $maxRow; $r++) {
        $val = $sheetDesc.Cells.Item($r, 1).Value2
        if ($val -and $val -match 'Anforderungsreferenz:') {
            Write-Verbose "Anforderungsreferenz-Zeile gefunden : $r"
            return $sheetDesc.Cells.Item($r, 1).MergeArea
        }
    }
    Write-Verbose "Keine Anforderungsreferenz-Zelle gefunden unter Zeile $($startZelle.Row)"
    return $null
}

########################################
# Funktion : Rohtext in Array von Referenzen zerlegen
########################################
function zerlegeReferenzen {
    param($mergeArea)
    $raw = $mergeArea.Value2
    if ($raw -is [object[,] ]) {
        $raw = ($raw | ForEach-Object { $_ }) -join ' '
    }
    $clean = ($raw -replace 'Anforderungsreferenz:','').Trim() `
             -replace '[\r\n]+',' ' -replace '\s+',' '
    $arr = $clean -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
    Write-Verbose "Referenzen extrahiert : $($arr -join ', ')"
    return $arr
}

########################################
# Funktion : Normalisieren von Spaltenwerten zur besseren Auffindung
########################################
function Normalize-Referenz {
    param([string] $wert)
    if (-not $wert) { return '' }
    return ($wert -replace '\s+', '').ToLower()
}


########################################
# Funktion : Details für eine Referenz holen
########################################
function sucheReferenzDetails {
    param(
        $sheetReq,
        [int] $spalteReferenz,
        [int] $spalteBeschreibung,
        [int] $zeileKopf,
        [int] $letzteZeile,
        [string] $referenz
    )
    Write-Verbose "Suche Details für Referenz '$referenz'"
    $res = @{
        beschreibung       = 'KEIN EINTRAG GEFUNDEN'
        maßnahmeArt       = ''
        anforderungsPaket = ''
    }

    for ($r = $zeileKopf + 1; $r -le $letzteZeile; $r++) {
        $wertZelle = $sheetReq.Cells.Item($r, $spalteReferenz).Value2
        if (Normalize-Referenz $wertZelle -eq Normalize-Referenz $referenz)
         {
            Write-Verbose "Referenz '$referenz' gefunden in Zeile $r"

            # Beschreibung holen und flatten
            $cell   = $sheetReq.Cells.Item($r, $spalteBeschreibung)
            $rawVal = if ($cell.MergeCells) { $cell.MergeArea.Value2 } else { $cell.Value2 }
            if ($rawVal -is [object[,] ]) {
                $flat = for ($i = 0; $i -lt $rawVal.GetLength(0); $i++) {
                    for ($j = 0; $j -lt $rawVal.GetLength(1); $j++) { $rawVal[$i,$j] }
                }
            } elseif ($rawVal -is [object[]]) {
                $flat = $rawVal
            } else {
                $flat = @($rawVal)
            }
            $beschreibung = ($flat -join ' ').Trim()
            $res.beschreibung = $beschreibung
            Write-Verbose "Beschreibung extrahiert : '$beschreibung'"

            # Metadaten oberhalb extrahieren
            $meta = extrahiereMetadatenOberhalb `
                -arbeitsblatt $sheetReq `
                -spalteText $spalteReferenz `
                -zeileStart $r `
                -zeileKopf 0

            $res.maßnahmeArt       = $meta.maßnahmeArt
            $res.anforderungsPaket = $meta.anforderungsPaket
            break
        }
    }

    return $res
}

########################################
# Funktion : Alle Maßnahmen verarbeiten
########################################
function verarbeiteMassnahmen {
    param(
        $sheetMass,
        $sheetDesc,
        $sheetReq,
        $sheetOut,
        [int] $spalteMassnahmenReferenz,
        [int] $spalteTitel,
        [int] $spalteReferenz,
        [int] $spalteBeschreibung,
        [int] $zeileKopf,
        [int] $letzteZeile
    )
    $zeileOut = 2
    $zeileIn  = $sheetMass.UsedRange.Find('Maßnahmenreferenz').Row + 1
    Write-Verbose "Starte Verarbeitung ab Zeile $zeileIn"

    while ($true) {
        $massRef = $sheetMass.Cells.Item($zeileIn, $spalteMassnahmenReferenz).Value2
        if (-not $massRef) {
            Write-Verbose "Keine Maßnahmenreferenz in Zeile $zeileIn – Abbruch"
            break
        }

        schreibeLog "==== Verarbeitung Zeile $zeileIn : Maßnahmentyp='$massRef'" 'INFO'

        # Basiszeile schreiben
        $titel = extrahiereTitel $sheetMass $zeileIn $spalteMassnahmenReferenz
        $sheetOut.Cells.Item($zeileOut, 2).Value2 = $massRef
        $sheetOut.Cells.Item($zeileOut, 6).Value2 = $titel
        schreibeLog "→ Basiszeile $zeileOut : Typ='$massRef', Soll-Maßnahme='$titel'" 'DEBUG'
        $zeileOut++

        # Anforderungsreferenzen auflösen
        $mergeArea = findeAnforderungsreferenzMergeArea $sheetDesc $massRef
        if ($mergeArea) {
            $referenzen = zerlegeReferenzen $mergeArea
            foreach ($anf in $referenzen) {
                schreibeLog "-- Bearbeite Referenz '$anf'" 'DEBUG'
                $details = sucheReferenzDetails `
                    $sheetReq `
                    $spalteReferenz `
                    $spalteBeschreibung `
                    $zeileKopf `
                    $letzteZeile `
                    $anf

                schreibeLog "   Beschreibung='$($details.beschreibung)', Art='$($details.maßnahmeArt)', Paket='$($details.anforderungsPaket)'" 'DEBUG'

                $sheetOut.Cells.Item($zeileOut, 1).Value2 = $details.anforderungsPaket
                $sheetOut.Cells.Item($zeileOut, 2).Value2 = $massRef
                $sheetOut.Cells.Item($zeileOut, 3).Value2 = $details.maßnahmeArt
                $sheetOut.Cells.Item($zeileOut, 5).Value2 = $anf
                $sheetOut.Cells.Item($zeileOut, 6).Value2 = $details.beschreibung
                schreibeLog "→ Detailzeile $zeileOut geschrieben" 'DEBUG'
                $zeileOut++
            }
        } else {
            schreibeLog "WARn : Keine Anforderungsreferenzen für '$massRef' gefunden" 'WARN'
        }

        $zeileIn++
    }
}

########################################
# Funktion : Speichern und Schließen
########################################
function speichereUndSchliessen {
    param(
        $excelApp,
        $wbOut,
        [string] $pfadAusgabe
    )
    schreibeLog "Speichere Ergebnis nach $pfadAusgabe" 'INFO'
    $wbOut.SaveAs($pfadAusgabe)
    foreach ($wb in $excelApp.Workbooks) { try { $wb.Close($true) } catch {} }
    $excelApp.Quit()
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($excelApp) | Out-Null
    schreibeLog 'Vorgang abgeschlossen und Excel geschlossen.' 'DONE'
}

######### Hauptskript #########
$ordner               = $arbeitsVerzeichnis
$pfadMassnahmen       = Join-Path $ordner 'Maßnahmen.xlsx'
$pfadBeschreibung     = Join-Path $ordner 'Maßnahmenbeschreibung.xlsx'
$pfadAnforderungsRef  = Join-Path $ordner 'Anforderungsreferenzen.xlsx'
$pfadAusgabe          = Join-Path $ordner 'Fertige Maßnahmenliste.xlsx'

# Excel & Workbooks initialisieren
$excelApp       = starteExcel
$wbMassnahmen   = oeffneArbeitsbuch $excelApp $pfadMassnahmen
$wbBeschreibung = oeffneArbeitsbuch $excelApp $pfadBeschreibung
$wbAnfRef       = oeffneArbeitsbuch $excelApp $pfadAnforderungsRef

$sheetMass = $wbMassnahmen.Sheets.Item(1)
$sheetDesc = $wbBeschreibung.Sheets.Item(1)
$sheetReq  = $wbAnfRef.Sheets.Item(1)

# Ausgabe vorbereiten
$out       = bereiteAusgabeVor $excelApp $pfadAusgabe
$wbOut     = $out.wbOut
$sheetOut  = $out.sheetOut

# Spaltenindizes ermitteln
$spalteMassnahmenReferenz = ermittleSpaltenIndex $sheetMass 'Maßnahmenreferenz'
$spalteTitel              = ermittleSpaltenIndex $sheetMass 'Titel'
$spalteReferenz           = ermittleSpaltenIndex $sheetReq 'Referenz'
$spalteBeschreibung       = ermittleSpaltenIndex $sheetReq 'Beschreibung'
$zeileKopf                = $sheetReq.UsedRange.Find('Referenz').Row
$letzteZeile              = $sheetReq.UsedRange.Row + $sheetReq.UsedRange.Rows.Count - 1

# Verarbeitung starten
verarbeiteMassnahmen `
    $sheetMass `
    $sheetDesc `
    $sheetReq `
    $sheetOut `
    $spalteMassnahmenReferenz `
    $spalteTitel `
    $spalteReferenz `
    $spalteBeschreibung `
    $zeileKopf `
    $letzteZeile

# Speichern und Schließen
speichereUndSchliessen $excelApp $wbOut $pfadAusgabe
