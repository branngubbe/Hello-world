
# antall dager du ønsker å beholde:
$limit = (Get-Date).AddDays(-90)
$path = "C:\inetpub\logs\LogFiles\W3SVC2"


# Delete files older than the $limit.
#Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

# Delete files older than the $limit.
$files=Get-ChildItem -Path $path -Recurse -Force *.log | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit }

write-host "nr of files:" $files.count
write-host "total filesize (MB):"
[Math]::Round((($files|Measure-Object -Property Length -Sum).Sum / 1MB),2)

#Actual delete:
$files | Remove-Item -Force


#Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Select-Object Name, @{Name="MegaBytes";Expression={$_.Length / 1MB}}

#Evnt denne oneliner for gjeldende mappe (uten logg):
Get-ChildItem|Where-Object {$_.LastAccessTime -lt(Get-Date).AddDays(-90)}|Remove-Item -Force