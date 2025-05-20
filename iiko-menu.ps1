Clear-Host

Write-Host "=== Инструменты поддержки iiko ===`n"

Write-Host "1. Получить адрес сервера iiko (из config.xml)"
Write-Host "2. Database4"
Write-Host "3. Скачать FrontTools"
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
            $scriptUrl = "https://raw.githubusercontent.com/kevl777/tools/main/soft/database4.ps1"
            Write-Host "`n[!] Загружаю скрипт database4.ps1 с GitHub..." -ForegroundColor Yellow

            $utf8 = New-Object System.Text.UTF8Encoding $true
            $webClient = New-Object System.Net.WebClient
            $bytes = $webClient.DownloadData($scriptUrl)
            $script = $utf8.GetString($bytes)

            Invoke-Expression $script
        } catch {
            Write-Error "Не удалось загрузить или выполнить скрипт: $_"
        }
    }
'3' {
    try {
        $scriptUrl = "https://raw.githubusercontent.com/kevl777/tools/main/soft/download-FrontTools.ps1"
        Write-Host "`n[!] Загружаю скрипт download-FrontTools.ps1 с GitHub..." -ForegroundColor Yellow

        $utf8 = New-Object System.Text.UTF8Encoding $true
        $webClient = New-Object System.Net.WebClient
        $bytes = $webClient.DownloadData($scriptUrl)
        $script = $utf8.GetString($bytes)

        Invoke-Expression $script
    }
    catch {
        Write-Error "Ошибка при загрузке или выполнении скрипта download-FrontTools.ps1: $_"
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
