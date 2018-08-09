$lastChecked = Get-ChildItem $PSScriptRoot\ | Where-Object -Property Name -eq lastChecked.pso


$folderListing = Get-ChildItem C:\Users\$env:UserName\AppData\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\ | Where-Object {!$_.PsIsContainer -and ($_.LastWriteTime -gt $lastChecked.LastWriteTime) -and ($_.Length -gt 300000)}

If (!(Test-Path "$PSScriptRoot\files\")) {

    New-Item  -ItemType Directory $PSScriptRoot\files\ | Out-Null
}

foreach ($item in $folderListing) {

    $item | Copy-Item -Destination $PSScriptRoot\files\
        
    Get-ChildItem $PSScriptRoot\files\$($item.Name) | Rename-Item -NewName {$_.name + ".jpg"} 
}

$null > $PSScriptRoot\lastChecked.pso


explorer $PSScriptRoot\files\