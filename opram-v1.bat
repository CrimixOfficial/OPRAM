lear-Host

# Get physical RAM in MB
$RAMBytes = (Get-CimInstance -ClassName Win32_ComputerSystem).TotalPhysicalMemory
$RAM_MB = [math]::Round($RAMBytes / 1MB)

# Option calculations
$Opt1 = $RAM_MB
$Opt2 = $RAM_MB + 8192
$Opt3 = $RAM_MB + 16384
$Opt4 = $RAM_MB + 32768
$Opt5 = $RAM_MB * 2

Write-Host "Physical RAM detected: $RAM_MB MB"
Write-Host ""
Write-Host "Choose virtual RAM size:"
Write-Host "1 - $Opt1 MB"
Write-Host "2 - $Opt2 MB"
Write-Host "3 - $Opt3 MB"
Write-Host "4 - $Opt4 MB"
Write-Host "5 - $Opt5 MB"
Write-Host "6 - Enter manually"

do { 
$choice = Read-Host "Select option (1-6)"
} while ($choice -notin 1..6)

if ($choice -eq 6) { 
do { 
$CustomSize = Read-Host "Enter size in MB" 
} while (-not [int]::TryParse($CustomSize, [ref]0))
} else { 
$CustomSize = switch ($choice) { 
1 { $Opt1 } 
2 { $Opt2 } 
3 { $Opt3 } 
4 { $Opt4 } 
5 { $Opt5 } 
}
}

Write-Host ""
Write-Host "You have chosen the Paging file size: $CustomSize MB"
Write-Host "To apply this change, run the script as administrator and modify the paging file."
Write-Host "This script currently does not change anything; it only serves as an interface."
Pause