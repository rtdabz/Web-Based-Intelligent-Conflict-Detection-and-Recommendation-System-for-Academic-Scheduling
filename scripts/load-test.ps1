param(
    [string]$BaseUrl = 'http://localhost:8000/api',
    [string]$Token,
    [int]$Requests = 50,
    [int]$Concurrency = 10,
    [string]$Path = '/initial-data'
)

$headers = @{}
if ($Token) { $headers.Authorization = "Bearer $Token" }
$jobs = 1..$Requests | ForEach-Object {
    Start-Job -ScriptBlock {
        param($url, $headers)
        $sw = [Diagnostics.Stopwatch]::StartNew()
        try { Invoke-WebRequest -Uri $url -Headers $headers -UseBasicParsing | Out-Null; $status = 200 }
        catch { $status = $_.Exception.Response.StatusCode.value__ }
        $sw.Stop()
        [pscustomobject]@{ status = $status; ms = $sw.ElapsedMilliseconds }
    } -ArgumentList ($BaseUrl.TrimEnd('/') + $Path, $headers)
    while ((Get-Job -State Running).Count -ge $Concurrency) { Start-Sleep -Milliseconds 50 }
}
$results = $jobs | Wait-Job | Receive-Job
$results | Remove-Job
$times = @($results | ForEach-Object ms | Sort-Object)
[pscustomobject]@{
    requests = $results.Count
    errors = @($results | Where-Object status -ge 400).Count
    p50_ms = $times[[math]::Max(0, [math]::Floor($times.Count * .50) - 1)]
    p95_ms = $times[[math]::Max(0, [math]::Floor($times.Count * .95) - 1)]
    max_ms = $times[-1]
}
