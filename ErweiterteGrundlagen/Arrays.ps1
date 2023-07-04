##############################################
# Abschnitt 1: Einf�hrung in Arrays
##############################################

Write-Host "`n### Abschnitt 1: Einf�hrung in Arrays ###`n"

# Arrays erstellen
$fruechte = @("Apfel", "Banane", "Kirsche", "Orange")
$zahlen = @(1, 2, 3, 4, 5)

# Array-Elemente ausgeben
Write-Host "Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Host $_ }

Write-Host "`nInhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Host $_ }

##############################################
# Abschnitt 2: Elemente zu Arrays hinzuf�gen
##############################################

Write-Host "`n### Abschnitt 2: Elemente zu Arrays hinzuf�gen ###`n"

# Elemente zu Arrays hinzuf�gen
$fruechte += "Mango"
$zahlen += 6, 7, 8

# Aktualisierte Array-Elemente ausgeben
Write-Host "Aktualisierter Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Host $_ }

Write-Host "`nAktualisierter Inhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Host $_ }

##############################################
# Abschnitt 3: Auf Array-Elemente zugreifen
##############################################

Write-Host "`n### Abschnitt 3: Auf Array-Elemente zugreifen ###`n"

# Auf Array-Elemente zugreifen
$erstesElement = $fruechte[0]
$drittesElement = $zahlen[2]

# Array-Elemente ausgeben
Write-Host "Erstes Element des Arrays $ fruechte: $erstesElement"
Write-Host "Drittes Element des Arrays $ zahlen: $drittesElement"
 
##############################################
# Abschnitt 4: Array-L�nge ermitteln
##############################################

Write-Host "`n### Abschnitt 4: Array-L�nge ermitteln ###`n"

# Array-L�nge ermitteln
$fruechteLaenge = $fruechte.Length
$zahlenLaenge = $zahlen.Length

# Array-L�nge ausgeben
Write-Host "L�nge des Arrays $ fruechte: $fruechteLaenge"
Write-Host "L�nge des Arrays $ zahlen: $zahlenLaenge"

##############################################
# Abschnitt 5: Arrays durchlaufen
##############################################

Write-Host "`n### Abschnitt 5: Arrays durchlaufen ###`n"

# Arrays durchlaufen
Write-Host "Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Host $_ }

Write-Host "`nInhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Host $_ }

##############################################
# Abschnitt 6: Array-Elemente entfernen
##############################################

Write-Host "`n### Abschnitt 6: Array-Elemente entfernen ###`n"

# Array-Elemente entfernen
$fruechte = $fruechte | Where-Object { $_ -ne "Banane" }
$zahlen = $zahlen | Where-Object { $_ -lt 5 }

# Aktualisierte Array-Elemente ausgeben
Write-Host "Aktualisierter Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Host $_ }

Write-Host "`nAktualisierter Inhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Host $_ }

##############################################
# Abschnitt 7: Arrays iterieren
##############################################

Write-Host "`n### Abschnitt 7: Arrays iterieren ###`n"

# Beispiel 1: Kopfschleife
Write-Host "`nBeispiel 1: Kopfschleife`n"

$index = 0
while ($index -lt $fruechte.Length) {
    $element = $fruechte[$index]
    Write-Host "Element an Index $index : $element"
    $index++
}

# Beispiel 2: Z�hlerschleife
Write-Host "`nBeispiel 2: Z�hlerschleife`n"

for ($i = 0; $i -lt $fruechte.Length; $i++) {
    $element = $fruechte[$i]
    Write-Host "Element an Index $i : $element"
}

# Beispiel 3: Fu�schleife
Write-Host "`nBeispiel 3: Fu�schleife`n"

foreach ($element in $fruechte) {
    $index = [array]::IndexOf($fruechte, $element)
    Write-Host "Element an Index $index : $element"
}
