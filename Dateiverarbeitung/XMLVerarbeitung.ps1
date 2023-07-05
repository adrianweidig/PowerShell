# Beachte den Aufruf der Datei �ber n�tige Berechtigungen

##############################################
# Abschnitt 1: XML-Datei erstellen
##############################################

Write-Output "=== Abschnitt 1: XML-Datei erstellen ===`n"

# Pfad zur neuen XML-Datei festlegen
$neueXmlDatei = "C:\NeueXMLDatei.xml"

# XML-Struktur erstellen
$xml = New-Object System.Xml.XmlDocument
$root = $xml.CreateElement("Root")
$xml.AppendChild($root)

# Daten f�r die XML-Datei erstellen
$data = @(
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
        Stadt = "M�nchen"
    }
)

# XML-Elemente erstellen und zur XML-Struktur hinzuf�gen
foreach ($item in $data) {
    $person = $xml.CreateElement("Person")
    $name = $xml.CreateElement("Name")
    $name.InnerText = $item.Name
    $alter = $xml.CreateElement("Alter")
    $alter.InnerText = $item.Alter
    $stadt = $xml.CreateElement("Stadt")
    $stadt.InnerText = $item.Stadt

    $person.AppendChild($name)
    $person.AppendChild($alter)
    $person.AppendChild($stadt)
    $root.AppendChild($person)
}

# XML-Datei speichern mit UTF-8-Kodierung
$settings = New-Object System.Xml.XmlWriterSettings
$settings.Encoding = [System.Text.Encoding]::UTF8
$settings.Indent = $true
$settings.NewLineOnAttributes = $true

$writer = [System.Xml.XmlWriter]::Create($neueXmlDatei, $settings)
$xml.Save($writer)
$writer.Close()

# Erfolgsmeldung anzeigen
Write-Output "Die neue XML-Datei wurde erfolgreich erstellt: $neueXmlDatei"


##############################################
# Abschnitt 2: XML-Datei einlesen
##############################################

Write-Output "`n=== Abschnitt 2: XML-Datei einlesen ===`n"

# Pfad zur XML-Datei festlegen
$xmlDatei = "C:\NeueXMLDatei.xml"

# XML-Datei einlesen
$xml = New-Object System.Xml.XmlDocument
$xml.Load($xmlDatei)

# XML-Elemente auslesen
$personen = $xml.SelectNodes("//Person")

# Ausgabe der eingelesenen Daten
Write-Output "Die XML-Datei wurde erfolgreich eingelesen. Enthaltene Elemente:"
foreach ($person in $personen) {
    $name = $person.SelectSingleNode("Name").InnerText
    $alter = $person.SelectSingleNode("Alter").InnerText
    $stadt = $person.SelectSingleNode("Stadt").InnerText
    Write-Output "Name: $name, Alter: $alter, Stadt: $stadt"
}


##############################################
# Abschnitt 3: XML-Daten filtern
##############################################

Write-Output "`n=== Abschnitt 3: XML-Daten filtern ===`n"

# Filterkriterien festlegen
$filterSpalte = "Alter"
$filterWert = 30
# Erkl�rung zu XPath: https://www.windowspro.de/script/xml-powershell-xpath-abfragen-namespaces
# XPath-Ausdruck f�r die Filterung erstellen
$filterXPath = "//Person[$filterSpalte > $filterWert]"

# XML-Daten nach Filterkriterien filtern
$gefilterteDaten = $xml.SelectNodes($filterXPath)

# Ausgabe der gefilterten Daten
Write-Output "Die XML-Daten wurden erfolgreich gefiltert. Enthaltene Datens�tze:"
foreach ($person in $gefilterteDaten) {
    $name = $person.SelectSingleNode("Name").InnerText
    $alter = $person.SelectSingleNode("Alter").InnerText
    $stadt = $person.SelectSingleNode("Stadt").InnerText
    Write-Output "Name: $name, Alter: $alter, Stadt: $stadt"
}


##############################################
# Abschnitt 4: XML-Daten bearbeiten
##############################################

Write-Output "`n=== Abschnitt 4: XML-Daten bearbeiten ===`n"

# Spalte f�r die Bearbeitung ausw�hlen
$bearbeitungsSpalte = "Name"

# Neue Werte f�r die ausgew�hlte Spalte festlegen
foreach ($person in $gefilterteDaten) {
    $name = $person.SelectSingleNode($bearbeitungsSpalte)
    $name.InnerText = "Bearbeitet - " + $name.InnerText
}

# Ausgabe der bearbeiteten Daten
Write-Output "Die XML-Daten wurden erfolgreich bearbeitet. Enthaltene Datens�tze:"
foreach ($person in $gefilterteDaten) {
    $name = $person.SelectSingleNode("Name").InnerText
    $alter = $person.SelectSingleNode("Alter").InnerText
    $stadt = $person.SelectSingleNode("Stadt").InnerText
    Write-Output "Name: $name, Alter: $alter, Stadt: $stadt"
}

##############################################
# Abschnitt 5: XML-Datei l�schen
##############################################

Write-Output "`n=== Abschnitt 5: XML-Datei l�schen ===`n"

# Pfad zur zu l�schenden XML-Datei festlegen
$zuLoeschendeXmlDatei = "C:\NeueXMLDatei.xml"

# XML-Datei l�schen
Remove-Item -Path $zuLoeschendeXmlDatei -Force

# Erfolgsmeldung anzeigen
Write-Output "Die XML-Datei wurde erfolgreich gel�scht: $zuLoeschendeXmlDatei"
