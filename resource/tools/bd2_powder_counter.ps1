param(
    [ValidateSet("reset", "next")]
    [string]$Mode = "next",
    [int]$Max = -1
)

$ErrorActionPreference = "Stop"

$statePath = Join-Path $PSScriptRoot "bd2_powder_counter_state.json"
$logPath = Join-Path $PSScriptRoot "bd2_powder_counter.log"

function Write-CounterLog {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
    Add-Content -LiteralPath $logPath -Value "$timestamp $Message" -Encoding UTF8
}

if ($Mode -eq "reset") {
    $state = [ordered]@{
        max = [Math]::Max(0, $Max)
        done = 0
    }
    $state | ConvertTo-Json -Compress | Set-Content -LiteralPath $statePath -Encoding UTF8
    Write-CounterLog "reset max=$($state.max)"
    exit 0
}

if (-not (Test-Path -LiteralPath $statePath)) {
    $state = [pscustomobject]@{ max = 0; done = 0 }
} else {
    $state = Get-Content -LiteralPath $statePath -Raw | ConvertFrom-Json
}

$maxValue = [int]$state.max
$doneValue = [int]$state.done + 1

$newState = [ordered]@{
    max = $maxValue
    done = $doneValue
}
$newState | ConvertTo-Json -Compress | Set-Content -LiteralPath $statePath -Encoding UTF8

if ($maxValue -gt 0 -and $doneValue -ge $maxValue) {
    Write-CounterLog "next done=$doneValue max=$maxValue stop"
    exit 1
}

Write-CounterLog "next done=$doneValue max=$maxValue continue"
exit 0
