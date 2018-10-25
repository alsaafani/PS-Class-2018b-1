Remove-Item backup -Force:$true -Confirm:$false 
New-Item backup -ItemType Directory
"*"*80
Write-Host "Saving the following files to the ""Backup"" folder"
"*"*80
$BUCount = 0 ; $BUSize =0


Get-ChildItem | Where-Object {$_.LastWriteTime -ge "2011-01-01"} |
ForEach-Object { 
    Write-Host " " $_.Name
    $BUSize += $_.Length
    $BUCount ++
    $NewFileName = "backup\" + ($_.BaseName) + "_" + $_.LastWriteTime.ToString("yyyy-MM-dd") + ($_.Extension)
    Copy-Item $_ $NewFileName
 }
 Write-Host "Saved:" $BUCount "Files," $BUSize.ToString("n0") "bytes"

