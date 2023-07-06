##############################################
# Abschnitt 1: Klassendefinition
##############################################

Write-Output "=== Abschnitt 1: Klassendefinition ===`n"

# Klassen Definition
class Person {
    [string] $Name
    [int] $Alter

    Person([string] $name, [int] $alter) {
        $this.Name = $name
        $this.Alter = $alter
    }

    [string] GetInfo() {
        return "Name: $($this.Name), Alter: $($this.Alter)"
    }

    [void] Sprechen() {
        # Achtung Write-Output funktioniert aufgrund des Scopes nicht
        Write-Host "Hey ich bin $($this.Name) und bin $($this.Alter) alt."
    }
}
 

##############################################
# Abschnitt 2: Objekterzeugung und Methodenaufruf
##############################################

Write-Output "`n=== Abschnitt 2: Objekterzeugung und Methodenaufruf ===`n"

# Objekterzeugung
$person1 = [Person]::new("Max Mustermann", 30)
$person2 = [Person]::new("Erika Musterfrau", 25)

# Methodenaufruf
Write-Output "Person 1: $($person1.GetInfo())"
Write-Output "Person 2: $($person2.GetInfo())"

$person1.Sprechen()
$person2.Sprechen()


##############################################
# Abschnitt 3: Statische Methoden und Eigenschaften
##############################################

Write-Output "`n=== Abschnitt 4: Statische Methoden und Eigenschaften ===`n"

# Klassen mit statischen Methoden und Eigenschaften
class MathHelper {
    static [double] $Pi = 3.14159

    static [double] KreisBerechnen([double] $radius) {
        return [Math]::Pow($radius, 2) * [MathHelper]::Pi
    }
}

# Statische Methodenaufrufe
$radius = 5.0
$circleArea = [MathHelper]::KreisBerechnen($radius)

Write-Output "Der Flächeninhalt eines Kreises mit Radius $radius beträgt: $circleArea"
