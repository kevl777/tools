# Главное меню PowerShell для запуска скриптов поддержки iiko

$menu = @(
    "1. Получить адрес сервера iiko (из config.xml)"
    "2. Database4"
    "0. Выход"
)

Write-Host "`n=== Инструменты поддержки iiko ===`n"
$menu | ForEach-Object { Write-Host $_ }

$choice = Read-Host "`nВведите номер действия"

switch ($choice) {
    '1' {
        try {
            $scriptUrl = "https://raw.githubusercontent.com/kevl777/tools/main/scripts/get-iiko-server.ps1"
            Write-Host "`n[!] Загружаю скрипт get-iiko-server.ps1 с GitHub..." -ForegroundColor Yellow

            # Корректная загрузка с кодировкой UTF-8 с BOM
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
            $scriptUrl = "https://raw.githubusercontent.com/kevl777/tools/main/soft/run-yadisk-file.ps1"
            Write-Host "`n[!] Загружаю скрипт run-yadisk-file.ps1 с GitHub..." -ForegroundColor Yellow

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
