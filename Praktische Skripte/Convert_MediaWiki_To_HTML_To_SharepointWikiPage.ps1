$VerbosePreference = "Continue"
Write-Verbose "Starte den Wiki-Konvertierungsprozess..."

# XML-Dokument über XmlDocument-Objekt laden – so wird das Zeichenlimit umgangen
Write-Verbose "Lade XML-Dokument..."
$xmlData = New-Object System.Xml.XmlDocument
$xmlPath = Convert-Path "C:\temp\wiki.xml"
$xmlData.Load($xmlPath)
Write-Verbose "XML-Dokument wurde erfolgreich geladen: $xmlPath"

# Zielordner für die Vorschau-Dateien
$previewFolder = "C:\temp\wiki"
if (!(Test-Path $previewFolder)) {
    Write-Verbose "Vorschauordner '$previewFolder' existiert nicht, erstelle Ordner..."
    New-Item -ItemType Directory -Path $previewFolder | Out-Null
} else {
    Write-Verbose "Vorschauordner '$previewFolder' existiert bereits."
}

# Zielordner in SharePoint (Serverrelative URL) – später sollen alle Seiten unter /test/wiki abgelegt werden
$sharePointTargetFolder = "/test/wiki"
Write-Verbose "Ziel-SharePoint-Ordner: $sharePointTargetFolder"

# Array zum Sammeln von Seiteninformationen für das Inhaltsverzeichnis
$pageIndexList = @()

# Funktion: Konvertiert MediaWiki-Markup via Pandoc in HTML
function Convert-WikiToHtml {
    param (
        [Parameter(Mandatory = $true)]
        [string]$wikiMarkup
    )
    
    Write-Verbose "Konvertiere Wiki-Markup mit Pandoc..."
    
    # Temporäre Dateien für Input und Output erstellen
    $tempInput = [System.IO.Path]::GetTempFileName() + ".mediawiki"
    $tempOutput = [System.IO.Path]::GetTempFileName() + ".html"
    
    # Schreibe den Wiki-Markup-Inhalt in die Input-Datei unter UTF8 (BOM) – so werden Umlaute korrekt gespeichert
    [System.IO.File]::WriteAllText($tempInput, $wikiMarkup, [System.Text.Encoding]::UTF8)
    Write-Verbose "Temporäre Eingabedatei erstellt: $tempInput"
    
    # Pandoc aufrufen – stelle sicher, dass Pandoc installiert und im PATH ist!
    $pandocArgs = "-f mediawiki -t html -o `"$tempOutput`" `"$tempInput`""
    Write-Verbose "Rufe Pandoc mit Argumenten: $pandocArgs"
    $process = Start-Process -FilePath "pandoc" -ArgumentList $pandocArgs -NoNewWindow -Wait -PassThru
    
    if ($process.ExitCode -ne 0) {
        Write-Error "Fehler bei der Pandoc-Konvertierung für $tempInput (Exit-Code: $($process.ExitCode))"
        Remove-Item $tempInput, $tempOutput -ErrorAction SilentlyContinue
        return ""
    }
    
    # Lese den generierten HTML-Inhalt unter UTF8 ein
    $htmlContent = [System.IO.File]::ReadAllText($tempOutput, [System.Text.Encoding]::UTF8)
    Write-Verbose "HTML-Inhalt erfolgreich erzeugt."

    # Entferne die temporären Dateien
    Remove-Item $tempInput, $tempOutput -ErrorAction SilentlyContinue
    Write-Verbose "Temporäre Dateien wurden entfernt."
    
    return $htmlContent
}

# Wähle alle <page>-Elemente (unabhängig vom XML-Namespace) mithilfe von SelectNodes
Write-Verbose "Ermittle alle <page>-Elemente aus dem XML-Dokument..."
$pages = $xmlData.SelectNodes("//*[local-name()='page']")
Write-Verbose "Anzahl der gefundenen Seiten: $($pages.Count)"

# Iteriere über alle Seiten aus dem Dump
foreach ($page in $pages) {
    # Extrahiere den Seitentitel (über XPath und local-name())
    $titleNode = $page.SelectSingleNode("./*[local-name()='title']")
    if (-not $titleNode) {
        Write-Verbose "Seite ohne Titel gefunden – überspringe diese Seite."
        continue
    }
    $title = $titleNode.InnerText
    Write-Verbose "Verarbeite Seite: '$title'"
    
    # Erstelle einen sicheren Dateinamen, indem unerlaubte Zeichen entfernt werden
    $safeTitle = $title -replace '[\\\/:*?"<>|]', ''
    $fileName = "$safeTitle.aspx"
    $localFilePath = Join-Path $previewFolder $fileName
    
    # Hole alle Revisionen der Seite und wähle die letzte (aktuellste)
    $revisionNodes = $page.SelectNodes("./*[local-name()='revision']")
    if (-not $revisionNodes -or $revisionNodes.Count -eq 0) {
        Write-Verbose "Seite '$title' enthält keine Revision – überspringe diese Seite."
        continue
    }
    $lastRevision = $revisionNodes[$revisionNodes.Count - 1]
    Write-Verbose "Letzte Revision für '$title' ausgewählt (Revision Count: $($revisionNodes.Count))."
    
    # Extrahiere den Wiki-Text aus dem <text>-Element in der Revision
    $textNode = $lastRevision.SelectSingleNode("./*[local-name()='text']")
    if (-not $textNode) {
        Write-Verbose "Revision ohne Textinhalt in Seite '$title' – überspringe diese Seite."
        continue
    }
    
    $wikiMarkup = $textNode.InnerText
    if ([string]::IsNullOrWhiteSpace($wikiMarkup)) {
        Write-Verbose "Seite '$title' hat leeren Wiki-Text – überspringe diese Seite."
        continue
    }
    
    Write-Verbose "Starte Konvertierung der Seite '$title'..."
    # Konvertiere MediaWiki-Markup in HTML mittels Pandoc
    $htmlContent = Convert-WikiToHtml $wikiMarkup
    if ([string]::IsNullOrEmpty($htmlContent)) {
         Write-Verbose "Fehler bei der Konvertierung der Seite '$title'."
         continue
    }
    
    Write-Verbose "Speichere den konvertierten HTML-Inhalt der Seite '$title' als ASPX-Datei..."
    # Speichere den konvertierten HTML-Inhalt in einer .aspx-Datei unter UTF8 (mit BOM)
    [System.IO.File]::WriteAllText($localFilePath, $htmlContent, [System.Text.Encoding]::UTF8)
    
    # Erstelle einen Eintrag für das Inhaltsverzeichnis
    $pageIndexList += [PSCustomObject]@{
        Title     = $title
        FileName  = $fileName
        LocalPath = $localFilePath
        # Der spätere ServerRelativePageUrl wird unter /test/wiki/<Dateiname> liegen
        SPUrl     = "$sharePointTargetFolder/$fileName"
    }
    
    Write-Verbose "Seite '$title' wurde als Vorschau erzeugt: $localFilePath"
}

# Erzeuge ein Index-HTML-Dokument im Preview-Ordner, das als Inhaltsverzeichnis aller Seiten dient
Write-Verbose "Erstelle Index-HTML-Dokument für die Vorschau..."
$indexFilePath = Join-Path $previewFolder "index.html"
$indexContent = @"
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>Wiki Vorschau - Inhaltsverzeichnis</title>
    <style>
       body { font-family: Arial, sans-serif; }
       ul { list-style-type: none; }
       li { margin-bottom: 0.5em; }
    </style>
</head>
<body>
    <h1>Vorschau - Inhaltsverzeichnis der Wiki-Seiten</h1>
    <ul>
"@

foreach ($item in $pageIndexList) {
    # Annahme: Alle Vorschau-Dateien liegen im gleichen Ordner wie index.html
    $indexContent += "        <li><a href='$($item.FileName)'>$($item.Title)</a></li>`r`n"
}
$indexContent += @"
    </ul>
    <p>Öffnen Sie diese Datei in Ihrem Browser, um die konvertierten Seiten zu überprüfen.</p>
</body>
</html>
"@
[System.IO.File]::WriteAllText($indexFilePath, $indexContent, [System.Text.Encoding]::UTF8)
Write-Verbose "Index-Datei mit Inhaltsverzeichnis wurde erstellt: $indexFilePath"
Write-Host "Bitte öffnen Sie die Index-Datei im Browser, um die konvertierten Seiten zu überprüfen."

# Abfrage zur Bestätigung, ob der Import in SharePoint erfolgen soll
$confirmation = Read-Host "Möchten Sie nun die Seiten in SharePoint importieren? (j/n)"
if ($confirmation -ne "j") {
    Write-Host "Import abgebrochen. Die Vorschau-Dateien verbleiben im Ordner $previewFolder."
    return
}

# Stelle SharePoint-Verbindung wieder her, falls erforderlich
# (Falls die Verbindung noch aktiv ist, kann dieser Schritt entfallen)
Write-Verbose "Stelle Verbindung zu SharePoint her..."
Connect-PnPOnline -Url "https://deinsharepointsite/sites/deinesite" -Credentials (Get-Credential)

# Importiere die Seiten in SharePoint unter /test/wiki
Write-Verbose "Starte Import der Seiten in SharePoint..."
foreach ($item in $pageIndexList) {
    Write-Verbose "Lese Inhalt der Vorschau-Datei: $($item.LocalPath)"
    $pageContent = [System.IO.File]::ReadAllText($item.LocalPath, [System.Text.Encoding]::UTF8)
    try {
        Add-PnPWikiPage -ServerRelativePageUrl $item.SPUrl -Content $pageContent
        Write-Verbose "Wiki-Seite '$($item.Title)' erfolgreich in SharePoint erstellt unter $($item.SPUrl)"
    } catch {
        Write-Error "Fehler beim Erstellen der Wiki-Seite '$($item.Title)': $_"
    }
}

Write-Host "Importprozess abgeschlossen."
