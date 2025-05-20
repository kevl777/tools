# URL файла для скачивания
$url = "https://fronttools.iiko.it/FrontTools.exe"

# Путь к папке "Загрузки" текущего пользователя
$downloadsPath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads"

# Проверяем, существует ли папка Downloads, если нет — создаём
if (-not (Test-Path -Path $downloadsPath)) {
    Write-Host "Папка Downloads не найдена, создаю..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $downloadsPath | Out-Null
}

# Полный путь для сохранения файла
$savePath = Join-Path -Path $downloadsPath -ChildPath "FrontTools.exe"

try {
    Write-Host "`n[!] Скачиваю FrontTools.exe в $savePath ..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $savePath

    Write-Host "[+] Файл успешно скачан: $savePath"
    Write-Host "[*] Запускаю FrontTools.exe..." -ForegroundColor Green

    Start-Process -FilePath $savePath -Wait
}
catch {
    Write-Error "Ошибка при скачивании или запуске: $_"
}
