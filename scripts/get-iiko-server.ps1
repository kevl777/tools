$path = "$env:APPDATA\iiko\cashserver\config.xml"

if (!(Test-Path $path)) {
    Write-Error "Файл не найден: $path"
    exit 1
}

try {
    [xml]$config = Get-Content $path
    $serverUrl = $config.config.serverUrl

    if ($serverUrl) {
        Write-Host "Адрес сервера iiko: $serverUrl"
    } else {
        Write-Warning "Не удалось найти <serverUrl> в config.xml"
    }
} catch {
    Write-Error "Ошибка чтения XML: $_"
}
