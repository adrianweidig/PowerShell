<#
/ - Schr�gstrich oder Vorw�rtsschr�gstrich
Verwendung: Der Schr�gstrich wird verwendet, um Pfade in Dateisystemen anzugeben. 
Zum Beispiel: C:\Pfad\Zur\Datei.txt

& - Kaufmanns-Und-Zeichen
Verwendung: Das Kaufmanns-Und-Zeichen wird verwendet, um einen Befehl oder eine Funktion in PowerShell auszuf�hren. 
Zum Beispiel: & "C:\Pfad\Zur\Datei.exe"

$ - Dollarzeichen
Verwendung: Das Dollarzeichen kennzeichnet in PowerShell eine Variable. 
Zum Beispiel: $name = "John"; Write-Host "Hallo, $name!"

<> - Winkelklammern
Verwendung: Winkelklammern werden verwendet, um Eingabe- und Ausgabestr�me in einer Pipeline umzuleiten. 
Zum Beispiel: Get-Process > C:\Ausgabe.txt
ACHTUNG: > Ausgabe.txt �berschreibt vorhandenen Text
         >> Ausgabe.txt h�ngt den neuen Text links davon an an (append)

- - Minuszeichen
Verwendung: Das Minuszeichen wird in PowerShell als Pr�fix verwendet, um Optionen, Argumente und Parameter anzugeben. 
Zum Beispiel: Get-Help -Name Get-Process

? - Konditionaler Operator
Verwendung: Das Fragezeichen wird in PowerShell als Konditionaler Operator verwendet, um eine bedingte Auswertung durchzuf�hren. 
Zum Beispiel: $ergebnis = ($zahl -gt 10) ? "Gr��er als 10" : "Kleiner oder gleich 10"

_ - Unterstrich
Verwendung: Der Underscore (Unterstrich) wird in PowerShell oft als Platzhalter f�r den aktuellen Wert in einer Pipeline verwendet. 
Zum Beispiel: Get-ChildItem | ForEach-Object { Write-Host "Verarbeitung von $_" }

` - Grave-Zeichen
Verwendung: Das Grave-Zeichen wird in PowerShell als Escape-Zeichen verwendet, um Sonderzeichen zu maskieren.
Zum Beispiel: "Das ist ein Beispiel f�r das Entkommen eines Sonderzeichens (`$) in PowerShell."

+=, -=, *=, /=, %= - Erweiterte Zuweisungsoperatoren
Verwendung: Diese erweiterten Zuweisungsoperatoren erm�glichen die schnelle Aktualisierung von Variablenwerten. 
Zum Beispiel: $zahl += 5; $zahl -= 2; $zahl *= 3

~ - Tilde
Verwendung: Die Tilde wird in PowerShell als Kurzform f�r das Benutzerverzeichnis verwendet. 
Zum Beispiel: $pfad = "~\Dokumente"
#>