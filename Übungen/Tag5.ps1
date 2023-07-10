##############################################
# Aufgaben - PowerShell-Wiederholung (Beachte fehlende Adminbenachrichtigungen)
##############################################

# 1.) Welche Cmdlets nutzen Sie, um Hilfe zur Syntax oder zu Beispielen zu erhalten?
get-help
get-command

# 2.) Welche Filtermöglichkeiten haben Sie, um sich nur bestimmte Cmdlets anzeigen zu lassen? Zeigen Sie alle Cmdlets an, die „get“ als ersten Namensbestandteil enthalten. Zeigen Sie alle Cmdlets an, die „process“ als zweiten Namensbestandteil enthalten.
get-command –verb get
get-command –noun process

# 3.) $a = „test“, zeigen Sie die Member des Objektes $a an!
$a = "test"
$a | Get-Member

# 4.) Zeigen Sie nur die Methoden des Objektes $a an.
$a | Get-Member -MemberType Methods

# 5.) Zeigen Sie alle Prozesse im Gridview an.
get-process | out-gridview

# 6.) Erzeugen Sie einen Zufallsgenerator für Lotto 6 aus 49.
1..49 | get-random -Count 6
# oder
1..6 | foreach-object { 1..49 | get-random}

# 7.) Erstellen Sie eine Pipeline für: Anzeigen aller Dienste, Reduzierung auf alle laufenden Dienste, Reduzierung auf Spalten Name und Status, Anzeigen im Grid
get-service | where-object { $_.status –like „Running“ } | select-object name, status | out-gridview

# 8.) Geben Sie je ein Beispiel für ein kurzes Script, maximal 3 Zeilen oder 3 Pipelinebestandteile für foreach-object und foreach? Was sind Vor- und Nachteile der beiden Varianten?
get-service | ForEach-Object { if ($_.status -eq "Running" ) { $_.name } }
# oder
$Service = get-service
ForEach ($x in $Service)
   { if ($x.status -eq 'Running') { "$($x.name) is running ..." } }

# 9.) Erstellen Sie ein kurzes Script für: Lesen Sie eine beliebige Textdatei ein und geben Sie diese zeilenweise auf Konsole aus! Der Dateiname soll von Benutzer online erfragt werden.
$name = read-host „Filename“
get-content $name | out-host -Paging

# 10.) Erstellen Sie ein kurzes Script für: Lesen Sie eine beliebige Datei ein. Geben Sie die Datei wieder in eine andere Datei aus. Schreiben Sie dabei zu Beginn jeder Zeile zusätzlich den Text „*** Hello World ***“ hinzu.
$name = read-host „Filename“
get-content $name | foreach-object { "*** Hello World *** " + $_  } | out-file -append file.txt

# 11.) Trennen Sie den folgenden String in ein Array auf, Trennzeichen ist das Leerzeichen: „Die Katze hat die Email-Adresse miau@katze.de“
$text = "Die Katze hat die Email-Adresse miau@katze.de"
$text -split " "

# 12.) Befehl für: Liste alle verfügbaren Module
get-module -listavailable

# 13.) Befehl für: Liste aller geladenen Module
get-module

# 14.) Befehl für: Liste aller verfügbaren Snapins
get-pssnapin -registered

# 15.) Befehl für: Liste aller geladenen Snapins
get-pssnapin

# 16.) Erstellen Sie ein Script für: Hochzählen von 1 bis 100 in 7-Schritten und Ausgabe der aktuellen Zahl (Nutzung der do-while-Schleife)
$i = 1
do  { $i; $i = $i+7 }
while ($i -lt 100) 

# 17.) Erstellen Sie ein Script für: Runterzählen von 50 bis 10 in 3-er Schritten und Ausgabe der aktuellen Zahl sowie der Ausschrift „ungerade Zahl“ bei allen ungeraden Zahlen (Nutzung der do-until-Schleife)
$i = 50
do  {   $i = $i-3; write-host $i -NoNewline; if ($i % 2) { write-host „ --> ungerade Zahl“ -NoNewline }; Write-Host "" }
until ($i -lt 10)  

# 18.) Erstellen Sie ein Script für: Hochzählen von 0 bis 100 in 5-Schritten und Ausgabe der aktuellen Zahl (Nutzung der for-Schleife)
for ($i=0; $i -le 100; $i += 5)
{ „Aktuelle Zahl ist $i“}

# 19.) Schreiben Sie ein kurzes Statement mit „if“, mit dem Sie folgendes abbilden: Ist die eingegebene Zahl größer 100, erfolgt die Ausschrift „Zahl größer 100“, sonst erfolgt die Ausschrift „Zahl kleiner 100“.
[int32]$h = Read-Host "Eingabe Zahl"
if ( $h -gt 100 )
   { "Zahl $h ist größer als 100"}
else
   { "Zahl $h ist kleiner als 100" }

# 20.) Testen Sie mit „Switch“ die Zahlenfolge 1 bis 20. Schreiben Sie jede Zahl aus und bei geradzahligen Zahlen die Ausschrift „geradzahlig“, bei ungeraden Zahlen die Ausschrift „ungeradzahlig“.
$a = 1..20
switch ($a)
   {    
     	{$_ % 2} {"Die Zahl $_ ist ungerade."}
   		default {"Die Zahl $_ ist gerade."}
  	}
  
# 21.) Beenden Sie alle laufenden Dienste / Service.
get-service | stop-service -force

# 22.) Beenden Sie alle laufenden Prozesse mit dem Namen „Notepad“.
get-process | where-object {$_.Name -like "Notepad"} | stop-process 

# 23.) Zeigen Sie das Eventlog „System“ komplett an!
get-eventlog system

# 24.) Zeigen Sie aus dem Eventlog „Anwendung“ alle Fehlermeldungen der letzten 72 Stunden an!
get-eventlog application -EntryType error -after ((get-date)-(New-TimeSpan -Hours 72))

# 25.) Erzeugen Sie in „C:\“ einen neuen Ordner „temp“. Erzeugen Sie in diesem neuen Ordner eine Datei „testfile.txt“. Befüllen Sie die Datei mit einem beliebigen Zeichen in der Menge von 1 MB.
new-item -Path C:\ -Name temp -ItemType directory
new-item -path c:\temp -name test.txt -itemtype file
Set-Content -Path c:\temp\test.txt ("x" * 1MB)