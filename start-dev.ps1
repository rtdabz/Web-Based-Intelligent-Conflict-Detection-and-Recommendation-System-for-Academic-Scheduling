$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$backendRoot = Join-Path $projectRoot 'backend'
$php = 'C:\xampp\php\php.exe'

if (-not (Test-Path -LiteralPath $php)) {
    throw "PHP executable not found at $php"
}

if (-not (Test-Path -LiteralPath (Join-Path $backendRoot 'artisan'))) {
    throw "Laravel backend was not found at $backendRoot"
}

function Start-WicarsProcess {
    param(
        [string] $FilePath,
        [string[]] $ArgumentList,
        [string] $WorkingDirectory,
        [switch] $Hidden
    )

    $options = @{
        FilePath = $FilePath
        ArgumentList = $ArgumentList
        WorkingDirectory = $WorkingDirectory
        PassThru = $true
    }
    if ($Hidden) {
        $options.WindowStyle = 'Hidden'
    }

    return Start-Process @options
}

$backendServer = Start-WicarsProcess `
    -FilePath $php `
    -ArgumentList @((Join-Path $backendRoot 'artisan'), 'serve') `
    -WorkingDirectory $backendRoot

$queueWorker = Start-WicarsProcess `
    -FilePath $php `
    -ArgumentList @((Join-Path $backendRoot 'artisan'), 'queue:work', 'database', '--queue=scheduling,default', '--tries=1', '--timeout=180', '--sleep=1') `
    -WorkingDirectory $backendRoot `
    -Hidden

$vite = Start-WicarsProcess `
    -FilePath 'npm.cmd' `
    -ArgumentList @('run', 'dev') `
    -WorkingDirectory (Join-Path $projectRoot 'wicars-ui')

Write-Host "WICARS development services started."
Write-Host "Laravel server PID: $($backendServer.Id)"
Write-Host "Scheduling worker PID: $($queueWorker.Id)"
Write-Host "Vite server PID: $($vite.Id)"
Write-Host "Keep this window open while developing."
