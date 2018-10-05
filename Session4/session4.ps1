Set-ExecutionPolicy RemoteSigned

$Files = Get-ChildItem 

$Files[0]
$files[1]

$Files = Get-ChildItem *g*
$Files.LastWriteTime = get-date

$file = Get-ChildItem Script.bat
$file | gm
$file.LastWriteTime = "2001-01-01"
$file.IsReadOnly = $true

(gci cord.wav).name
(gci cord.wav).LastWriteTime = get-date
(gci (ps explorer).path).length

(get-item * | sort LastwriteTime )[0].name

gci *.txt | foreach {
    $_.LastWriteTime = "1999-01-01" 
}

gci *.txt | foreach {$_.IsReadOnly = $false}

gci *.txt | foreach {$_.IsReadOnly = $false ; $_ } | Format-Table name -AutoSize