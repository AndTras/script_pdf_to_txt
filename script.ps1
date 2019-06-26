$cont = 0;
$timer = [Diagnostics.Stopwatch]::StartNew()
$folder = 'C:\Users\usuario\codigos\scriptPowerShell\fact1'
$folder2 = 'C:\Users\usuario\codigos\scriptPowerShell\fact1_backup'
$folder3 = 'C:\Users\usuario\codigos\scriptPowerShell\fact1_txt'
$filter = '*.*'

$fsw = New-Object IO.FileSystemWatcher $folder -Property @{
   IncludeSubdirectories = $false, $filter
   NotifyFilter = [IO.NotifyFilters]'FileName'
}


$created = Register-ObjectEvent $fsw -EventName Created -Action {
   $item = Get-Item $Event.SourceEventArgs
   $cont = $cont + 1;
   $name = $Event.SourceEventArgs.Name
   $changeType = $Event.SourceEventArgs.ChangeType
   $timeStamp = $Event.TimeGenerated
   copy-item -Path "C:\Users\usuario\codigos\scriptPowerShell\fact1\$name" -Destination "C:\Users\usuario\codigos\scriptPowerShell\fact1_backup\new$cont.pdf"
}

$fsw2 = New-Object IO.FileSystemWatcher $folder2 -Property @{
   IncludeSubdirectories = $false, $filter
   NotifyFilter = [IO.NotifyFilters]'FileName'
}


$created2 = Register-ObjectEvent $fsw2 -EventName Created -Action {
   $item = Get-Item $Event.SourceEventArgs
   $cont = $cont + 1;
   $name = $Event.SourceEventArgs.Name
   $changeType = $Event.SourceEventArgs.ChangeType
   $timeStamp = $Event.TimeGenerated
   $target= "C:\Users\usuario\codigos\scriptPowerShell\fact1_backup\$name"
   $pathCSV  = "C:\Users\usuario\codigos\scriptPowerShell\fact1_txt\new$cont.txt"
   java -jar C:\Users\usuario\codigos\scriptPowerShell\tabula.jar -n -a 62.741,30.814,78.334,431.764 -a 35.269,497.846,47.891,576.551 -a 72.394,429.536,85.016,552.791 -a 89.471,431.021,101.351,570.611  -a 104.321,431.764,119.171,572.839  -a 119.171,431.764,136.249,569.126 -a 122.141,33.041,138.476,300.341 -a 136.249,32.299,151.841,430.279  -a 187.481,21.161,661.939,588.431 -t -p 1 "$1" -o $pathCSV $target 
   Write-Host "nuevo pdf '$pathCSV' " -fore green
}