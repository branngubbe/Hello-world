Set-Variable mappe
Set-Variable mappe1
Set-Variable mappe2
Set-Variable mappe3
Set-Variable mappe4

$mappe='C:\temp\ny mappe'

#lage ny mappe
New-Item -Path $mappe -ItemType "directory"
$mappe1 =$mappe + '\del1' 
$mappe2 =$mappe + '\del2' 
$mappe3 =$mappe + '\del3' 
$mappe4 =$mappe + '\nodel1' 

# oppretter test mapper
New-Item -Path $mappe1 -ItemType "directory"
New-Item -Path $mappe2 -ItemType "directory"
New-Item -Path $mappe3 -ItemType "directory"
New-Item -Path $mappe4 -ItemType "directory"


# sletter alle mapper som ikke heter nodel eller del3
    
get-childitem -force $mappe -exclude *nodel*,*del3*  | remove-item -recurse



<# TODO
hvordan koble til ad for å spørre etter displayname basert på username
Sjekke at denne brukeren ikke har en aktive sesjon på server.


#>