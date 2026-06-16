param(
    [string]$Target = (Join-Path $HOME '.codex\skills'),
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$root = $PSScriptRoot
$sourceSkills = Join-Path $root 'skills'

if (-not (Test-Path -LiteralPath $sourceSkills)) {
    throw "Missing skills directory: $sourceSkills"
}

New-Item -ItemType Directory -Force -Path $Target | Out-Null

$installed = [System.Collections.Generic.List[string]]::new()
$skipped = [System.Collections.Generic.List[string]]::new()

Get-ChildItem -LiteralPath $sourceSkills -Directory | ForEach-Object {
    $dest = Join-Path $Target $_.Name
    if ((Test-Path -LiteralPath $dest) -and -not $Force) {
        $skipped.Add($_.Name)
        return
    }

    if (Test-Path -LiteralPath $dest) {
        $resolvedTarget = [System.IO.Path]::GetFullPath($Target)
        $resolvedDest = [System.IO.Path]::GetFullPath($dest)
        if (-not $resolvedDest.StartsWith($resolvedTarget, [System.StringComparison]::OrdinalIgnoreCase)) {
            throw "Refusing to replace path outside target: $resolvedDest"
        }
        Remove-Item -LiteralPath $dest -Recurse -Force
    }

    Copy-Item -LiteralPath $_.FullName -Destination $dest -Recurse
    $installed.Add($_.Name)
}

Write-Host "Target: $Target"
Write-Host "Installed: $($installed.Count)"
Write-Host "Skipped: $($skipped.Count)"

if ($skipped.Count -gt 0) {
    Write-Host "Skipped existing skills. Re-run with -Force to replace:"
    $skipped | ForEach-Object { Write-Host "  $_" }
}

