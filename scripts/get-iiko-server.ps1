$path = "$env:APPDATA\iiko\cashserver\config.xml"

if (!(Test-Path $path)) {
    Write-Error "���� �� ������: $path"
    exit 1
}

try {
    [xml]$config = Get-Content $path
    $serverUrl = $config.config.serverUrl

    if ($serverUrl) {
        Write-Host "����� ������� iiko: $serverUrl"
    } else {
        Write-Warning "�� ������� ����� <serverUrl> � config.xml"
    }
} catch {
    Write-Error "������ ������ XML: $_"
}
