##############################################
# Abschnitt 1: Einf�hrung in Arrays
##############################################

Write-Output "`n### Abschnitt 1: Einf�hrung in Arrays ###`n"

# Arrays erstellen
$fruechte = @("Apfel", "Banane", "Kirsche", "Orange")
$zahlen = @(1, 2, 3, 4, 5)

# Array-Elemente ausgeben
Write-Output "Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Output $_ }

Write-Output "`nInhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Output $_ }

##############################################
# Abschnitt 2: Elemente zu Arrays hinzuf�gen
##############################################

Write-Output "`n### Abschnitt 2: Elemente zu Arrays hinzuf�gen ###`n"

# Elemente zu Arrays hinzuf�gen
$fruechte += "Mango"
$zahlen += 6, 7, 8

# Aktualisierte Array-Elemente ausgeben
Write-Output "Aktualisierter Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Output $_ }

Write-Output "`nAktualisierter Inhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Output $_ }

##############################################
# Abschnitt 3: Auf Array-Elemente zugreifen
##############################################

Write-Output "`n### Abschnitt 3: Auf Array-Elemente zugreifen ###`n"

# Auf Array-Elemente zugreifen
$erstesElement = $fruechte[0]
$drittesElement = $zahlen[2]

# Array-Elemente ausgeben
Write-Output "Erstes Element des Arrays $ fruechte: $erstesElement"
Write-Output "Drittes Element des Arrays $ zahlen: $drittesElement"
 
##############################################
# Abschnitt 4: Array-L�nge ermitteln
##############################################

Write-Output "`n### Abschnitt 4: Array-L�nge ermitteln ###`n"

# Array-L�nge ermitteln
$fruechteLaenge = $fruechte.Length
$zahlenLaenge = $zahlen.Length

# Array-L�nge ausgeben
Write-Output "L�nge des Arrays $ fruechte: $fruechteLaenge"
Write-Output "L�nge des Arrays $ zahlen: $zahlenLaenge"

##############################################
# Abschnitt 5: Arrays durchlaufen
##############################################

Write-Output "`n### Abschnitt 5: Arrays durchlaufen ###`n"

# Arrays durchlaufen
Write-Output "Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Output $_ }

Write-Output "`nInhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Output $_ }

##############################################
# Abschnitt 6: Array-Elemente entfernen
##############################################

Write-Output "`n### Abschnitt 6: Array-Elemente entfernen ###`n"

# Array-Elemente entfernen
$fruechte = $fruechte | Where-Object { $_ -ne "Banane" }
$zahlen = $zahlen | Where-Object { $_ -lt 5 }

# Aktualisierte Array-Elemente ausgeben
Write-Output "Aktualisierter Inhalt des Arrays $ fruechte:"
$fruechte | ForEach-Object { Write-Output $_ }

Write-Output "`nAktualisierter Inhalt des Arrays $ zahlen:"
$zahlen | ForEach-Object { Write-Output $_ }

##############################################
# Abschnitt 7: Arrays iterieren
##############################################

Write-Output "`n### Abschnitt 7: Arrays iterieren ###`n"

# Beispiel 1: Kopfschleife
Write-Output "`nBeispiel 1: Kopfschleife`n"

$index = 0
while ($index -lt $fruechte.Length) {
    $element = $fruechte[$index]
    Write-Output "Element an Index $index : $element"
    $index++
}

# Beispiel 2: Z�hlerschleife
Write-Output "`nBeispiel 2: Z�hlerschleife`n"

for ($i = 0; $i -lt $fruechte.Length; $i++) {
    $element = $fruechte[$i]
    Write-Output "Element an Index $i : $element"
}

# Beispiel 3: Fu�schleife
Write-Output "`nBeispiel 3: Fu�schleife`n"

foreach ($element in $fruechte) {
    $index = [array]::IndexOf($fruechte, $element)
    Write-Output "Element an Index $index : $element"
}
