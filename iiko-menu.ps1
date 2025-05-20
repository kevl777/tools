# Главное меню PowerShell для запуска скриптов с GitHub

$menu = @(
    "1. Получить адрес сервера iiko (из config.xml)"
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
            Invoke-Expression (Invoke-RestMethod $scriptUrl)
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
