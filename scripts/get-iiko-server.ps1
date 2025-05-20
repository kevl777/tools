$path = "$env:APPDATA\iiko\cashserver\config.xml"

if (!(Test-Path $path)) {
    Write-Error "Ôàéë íå íàéäåí: $path"
    exit 1
}

try {
    [xml]$config = Get-Content $path
    $serverUrl = $config.config.serverUrl

    if ($serverUrl) {
        Write-Host "Адрес сервера iiko: $serverUrl"
    } else {
        Write-Warning "Не найден <serverUrl> в config.xml"
    }
} catch {
    Write-Error "Îøèáêà ÷òåíèÿ XML: $_"
}
