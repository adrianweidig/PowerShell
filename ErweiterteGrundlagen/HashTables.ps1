##############################################
# Abschnitt 1: Einführung in Hashtables
##############################################

Write-Host "`n### Abschnitt 1: Einführung in Hashtables ###`n"

# Hashtable erstellen und Werte hinzufügen
$person = @{
    "Name"  = "Alice"
    "Alter" = 30
    "Stadt" = "Berlin"
}

# Werte in Hashtable anzeigen
Write-Host "Name: $($person["Name"])"
Write-Host "Alter: $($person["Alter"])"
Write-Host "Stadt: $($person["Stadt"])"

##############################################
# Abschnitt 2: Hashtables mit verschiedenen Datentypen
##############################################

Write-Host "`n### Abschnitt 2: Hashtables mit verschiedenen Datentypen ###`n"

# Hashtable mit verschiedenen Datentypen erstellen
$car1 = @{
    "Marke"     = "BMW"
    "Modell"    = "X5"
    "Baujahr"   = 2020
    "Preis"     = 50000.50
    "Verfügbar" = $true
}

$car2 = @{
    "Marke"     = "Audi"
    "Modell"    = "A4"
    "Baujahr"   = 2019
    "Preis"     = 45000.75
    "Verfügbar" = $false
}

# Hashtable mit Autos erstellen
$cars = @($car1, $car2)

# Werte in Hashtable anzeigen
foreach ($car in $cars) {
    Write-Host "Marke: $($car["Marke"])"
    Write-Host "Modell: $($car["Modell"])"
    Write-Host "Baujahr: $($car["Baujahr"])"
    Write-Host "Preis: $($car["Preis"])"
    Write-Host "Verfügbar: $($car["Verfügbar"])"
}

##############################################
# Abschnitt 3: Hashtable-Funktionen
##############################################

Write-Host "`n### Abschnitt 3: Hashtable-Funktionen ###`n"

# Funktion zur Anzeige der Hashtable-Werte
Function ShowHashtableValues {
    param (
        [Parameter(Mandatory = $true)]
        [Hashtable]$hashTable
    )

    foreach ($key in $hashTable.Keys) {
        Write-Host "$key : $($hashTable[$key])"
    }
}

# Hashtable an die Funktion übergeben
ShowHashtableValues -hashTable $car1

##############################################
# Abschnitt 4: Verändern von Hashtable-Werten
##############################################

Write-Host "`n### Abschnitt 4: Verändern von Hashtable-Werten ###`n"

# Wert in Hashtable ändern
$car1["Preis"] = 55000.75

# Geänderten Wert anzeigen
Write-Host "Neuer Preis: $($car1["Preis"])"

##############################################
# Abschnitt 5: Hashtable als Parameter übergeben
##############################################

Write-Host "`n### Abschnitt 5: Hashtable als Parameter übergeben ###`n"

# Funktion zur Berechnung des Durchschnittspreises
Function CalculateAveragePrice {
    param (
        [Parameter(Mandatory = $true)]
        [Object[]]$cars
    )

    $totalPrice = 0
    $count = 0

    foreach ($car in $cars) {
        $totalPrice += $car["Preis"]
        $count++
    }

    $averagePrice = $totalPrice / $count
    return $averagePrice
}

# Hashtable an die Funktion übergeben und Durchschnittspreis berechnen
$average = CalculateAveragePrice -cars $cars
Write-Host "Durchschnittspreis: $average"
