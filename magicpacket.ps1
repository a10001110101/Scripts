# ---Configuration---
$TargetIP = "XXX.XXX.XXX.XXX"
$PingTimeout = 1
$WaitBetweenPings = 3
$MacAddress = "XX:XX:XX:XX:XX:XX"

Write-Host "Sending magic packet..."

$cleanMac = $MacAddress -replace '[-:]', ''
$macBytes = for ($i = 0; $i -lt 12; $i += 2) {
    [Convert]::ToByte($cleanMac.Substring($i, 2), 16)
}
$packet = [byte[]](,@(0xFF) * 6 + $macBytes * 16)

$udpClient = [System.Net.Sockets.UdpClient]::new()
try {
    $udpClient.Connect([System.Net.IPAddress]::Broadcast, 9)
    $udpClient.Send($packet, $packet.Length) | Out-Null
} finally {
    $udpClient.Dispose()
}

Write-Host "Magic packet sent. Checking if up now..."

while (-not (Test-Connection -ComputerName $TargetIP -Count 1 -Quiet)) {
    Write-Host "Still waiting for reply..."
    Start-Sleep -Seconds $WaitBetweenPings
}

Write-Host "$TargetIP is now up..."

Write-Host "Checking for SSH availability..."

while (-not (Test-NetConnection -ComputerName $TargetIP -Port 22 -InformationLevel Quiet)) {
    Write-Host "SSH not available yet..."
    Start-Sleep -Seconds $WaitBetweenPings
}

Write-Host "SSH is now available to connect!"