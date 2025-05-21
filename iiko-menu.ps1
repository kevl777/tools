Clear-Host

Write-Host "=== Инструменты поддержки iiko ===`n"

Write-Host "1. Получить адрес сервера iiko (из config.xml)"
Write-Host "2. Скачать и запустить Database4"
Write-Host "3. Скачать и запустить FrontTools"
Write-Host "4. Служба iikoCard5POS"
Write-Host "0. Выход`n"

$choice = Read-Host "Введите номер действия"

switch ($choice) {
    '1' {
        try {
            $scriptUrl = "https://raw.githubusercontent.com/kevl777/tools/main/scripts/get-iiko-server.ps1"
            Write-Host "`n[!] Загружаю скрипт get-iiko-server.ps1 с GitHub..." -ForegroundColor Yellow

            $utf8 = New-Object System.Text.UTF8Encoding $true
            $webClient = New-Object System.Net.WebClient
            $bytes = $webClient.DownloadData($scriptUrl)
            $script = $utf8.GetString($bytes)

            Invoke-Expression $script
        } catch {
            Write-Error "Не удалось загрузить или выполнить скрипт: $_"
        }
    }
    '2' {
        try {
            $publicUrl = "https://disk.yandex.ru/d/aKmufr351xu1hw"
            $apiUrl = "https://cloud-api.yandex.net/v1/disk/public/resources/download?public_key=$([uri]::EscapeDataString($publicUrl))"

            $response = Invoke-RestMethod -Uri $apiUrl -Method Get
            $downloadUrl = $response.href

            if (-not $downloadUrl) {
                throw "Прямая ссылка не получена"
            }

            $downloadsPath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads"

            if (-not (Test-Path -Path $downloadsPath)) {
                New-Item -ItemType Directory -Path $downloadsPath | Out-Null
            }

            $savePath = Join-Path -Path $downloadsPath -ChildPath "database4.exe"

            Write-Host "`n[!] Скачиваю файл в $savePath ..." -ForegroundColor Cyan
            Invoke-WebRequest -Uri $downloadUrl -OutFile $savePath

            Write-Host "[+] Файл сохранён: $savePath"
            Write-Host "[*] Запускаю файл..." -ForegroundColor Green

            Start-Process -FilePath $savePath -Wait
        } catch {
            Write-Error "Ошибка при скачивании или запуске: $_"
        }
    }
    '3' {
        try {
            $url = "https://fronttools.iiko.it/FrontTools.exe"
            $downloadsPath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads"

            if (-not (Test-Path -Path $downloadsPath)) {
                Write-Host "Папка Downloads не найдена, создаю..." -ForegroundColor Yellow
                New-Item -ItemType Directory -Path $downloadsPath | Out-Null
            }

            $savePath = Join-Path -Path $downloadsPath -ChildPath "FrontTools.exe"

            Write-Host "`n[!] Скачиваю FrontTools.exe в $savePath ..." -ForegroundColor Cyan
            Invoke-WebRequest -Uri $url -OutFile $savePath

            Write-Host "[+] Файл успешно скачан: $savePath"
            Write-Host "[*] Запускаю FrontTools.exe..." -ForegroundColor Green
            Start-Process -FilePath $savePath -Wait
        } catch {
            Write-Error "Ошибка при скачивании или запуске: $_"
        }
    }
    '4' {
        try {
            $scriptUrl = "https://raw.githubusercontent.com/kevl777/tools/main/scripts/card5POS.ps1"
            Write-Host "`n[!] Загружаю скрипт card5POS.ps1 с GitHub..." -ForegroundColor Yellow

            $utf8 = New-Object System.Text.UTF8Encoding $true
            $webClient = New-Object System.Net.WebClient
            $bytes = $webClient.DownloadData($scriptUrl)
            $script = $utf8.GetString($bytes)

            Invoke-Expression $script
        } catch {
            Write-Error "Не удалось загрузить или выполнить скрипт: $_"
        }
    }
    '0' {
        Write-Host "Выход..."
        exit
    }
    default {
        Write-Warning "Неверный выбор. Повторите попытку."
    }
}
