##############################################
# Abschnitt 1: Einführung in WinForms
##############################################

Write-Output "`n### Abschnitt 1: Einführung in WinForms ###`n"

Add-Type -AssemblyName System.Windows.Forms

# Neues Windows-Formular erstellen
$form = New-Object System.Windows.Forms.Form
$form.Text = "Mein erstes WinForm"
$form.Size = New-Object System.Drawing.Size(400, 300)
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::Sizable

# Formular anzeigen
$form.ShowDialog()

##############################################
# Abschnitt 2: Hinzufügen von Steuerelementen
##############################################

Write-Output "`n### Abschnitt 2: Hinzufügen von Steuerelementen ###`n"

# Button hinzufügen
$button = New-Object System.Windows.Forms.Button
$button.Text = "Klick mich!"
$button.Location = New-Object System.Drawing.Point(50, 50)
$form.Controls.Add($button)

# Label hinzufügen
$label = New-Object System.Windows.Forms.Label
$label.Text = "Hallo, Welt!"
$label.Location = New-Object System.Drawing.Point(50, 100)
$form.Controls.Add($label)

# Formular anzeigen
$form.ShowDialog()

##############################################
# Abschnitt 3: Ereignisse und Aktionen
##############################################

Write-Output "`n### Abschnitt 3: Ereignisse und Aktionen ###`n"

# Ereignisbehandlung für den Button hinzufügen
$button.Add_Click({
    $label.Text = "Button wurde geklickt!"
})

# Formular anzeigen
$form.ShowDialog()

##############################################
# Abschnitt 4: Dialogfenster anzeigen
##############################################

Write-Output "`n### Abschnitt 4: Dialogfenster anzeigen ###`n"

# Dialogfenster anzeigen
$result = [System.Windows.Forms.MessageBox]::Show("Möchten Sie fortfahren?", "Bestätigung", `
    [System.Windows.Forms.MessageBoxButtons]::OKCancel)

# Ergebnis überprüfen
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    Write-Output "OK wurde ausgewählt."
} else {
    Write-Output "Abbrechen wurde ausgewählt."
}
