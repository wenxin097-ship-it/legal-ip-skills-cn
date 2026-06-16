param(
    [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
    [string[]]$Path,

    [switch]$AllUserSkills
)

$ErrorActionPreference = 'Stop'
$env:PYTHONUTF8 = '1'

$toolRoot = $PSScriptRoot
$venvPython = Join-Path $toolRoot '.venv\Scripts\python.exe'
$setupScript = Join-Path $toolRoot 'setup.ps1'
$validator = Join-Path $HOME '.codex\skills\.system\skill-creator\scripts\quick_validate.py'
$userSkillsRoot = Join-Path $HOME '.codex\skills'

if (-not (Test-Path -LiteralPath $validator)) {
    throw "Codex official validator was not found: $validator"
}

$environmentReady = $false
if (Test-Path -LiteralPath $venvPython) {
    & $venvPython -c "import yaml" 2>$null
    $environmentReady = $LASTEXITCODE -eq 0
}

if (-not $environmentReady) {
    & $setupScript
}

$targets = [System.Collections.Generic.List[string]]::new()

if ($AllUserSkills) {
    Get-ChildItem -LiteralPath $userSkillsRoot -Directory |
        Where-Object { -not $_.Name.StartsWith('.') } |
        ForEach-Object { $targets.Add($_.FullName) }
}

foreach ($item in $Path) {
    $targets.Add([System.IO.Path]::GetFullPath($item))
}

if ($targets.Count -eq 0) {
    throw 'Provide one or more skill directories, or use -AllUserSkills.'
}

$failed = [System.Collections.Generic.List[string]]::new()

foreach ($target in $targets | Select-Object -Unique) {
    if (-not (Test-Path -LiteralPath $target -PathType Container)) {
        Write-Host "[FAIL] $target - directory not found" -ForegroundColor Red
        $failed.Add($target)
        continue
    }

    $output = & $venvPython $validator $target 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[PASS] $target - $output" -ForegroundColor Green
    } else {
        Write-Host "[FAIL] $target - $output" -ForegroundColor Red
        $failed.Add($target)
    }
}

Write-Host ''
Write-Host "Validated: $($targets.Count); Failed: $($failed.Count)"

if ($failed.Count -gt 0) {
    exit 1
}
