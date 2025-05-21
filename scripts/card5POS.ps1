Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$serviceName = "iikoCard5POS"
$form = New-Object System.Windows.Forms.Form
$form.Text = "Управление службой $serviceName"
$form.Size = New-Object System.Drawing.Size(450, 700)
$form.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,10)
$label.Size = New-Object System.Drawing.Size(400, 100)
$label.Font = New-Object System.Drawing.Font("Consolas", 10)
$form.Controls.Add($label)

# Глобальные размеры
$buttonWidth = 400
$buttonHeight = 40
$padding = 10
$global:y = 120

function Get-ServiceStatusText {
    try {
        $svc = Get-WmiObject Win32_Service -Filter "Name='$serviceName'"
        if (!$svc) {
            return "Служба '$serviceName' не найдена."
        }
        return "Служба: $($svc.DisplayName)`nСтатус: $($svc.State)`nУчетная запись: $($svc.StartName)`nТип запуска: $($svc.StartMode -replace 'Auto','Автоматически' -replace 'Manual','Вручную' -replace 'Disabled','Отключена')"
    } catch {
        return "Ошибка получения данных службы"
    }
}

function Refresh-Status {
    $label.Text = Get-ServiceStatusText
}

function Add-Button([string]$text, [ScriptBlock]$onClick) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Text = $text
    $btn.Location = New-Object System.Drawing.Point(10, $global:y)
    $btn.Size = New-Object System.Drawing.Size($buttonWidth, $buttonHeight)
    $btn.Add_Click($onClick)
    $form.Controls.Add($btn)
    $global:y += $buttonHeight + $padding
}

# Кнопки:
Add-Button "1. Перезапустить службу" {
    Restart-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Refresh-Status
}

Add-Button "2. Сменить пользователя на NETWORK SERVICE" {
    sc.exe config $serviceName obj= "NT AUTHORITY\NetworkService" password= ""
    Start-Sleep -Seconds 1
    Refresh-Status
}

Add-Button "3. Сменить пользователя на LOCAL SERVICE" {
    sc.exe config $serviceName obj= "NT AUTHORITY\LocalService" password= ""
    Start-Sleep -Seconds 1
    Refresh-Status
}

Add-Button "4. Установить запуск: Автоматически" {
    sc.exe config $serviceName start= auto
    Start-Sleep -Seconds 1
    Refresh-Status
}

Add-Button "5. Остановить службу" {
    Stop-Service -Name $serviceName -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Refresh-Status
}

Add-Button "6. Запустить службу" {
    Start-Service -Name $serviceName -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    Refresh-Status
}

Add-Button "7. Перейти в свойства службы" {
    Start-Process "services.msc"
}

# Первичная загрузка
Refresh-Status

[void]$form.ShowDialog()
