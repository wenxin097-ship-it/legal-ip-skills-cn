param(
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
$env:PYTHONUTF8 = '1'

$toolRoot = $PSScriptRoot
$venvPath = Join-Path $toolRoot '.venv'
$venvPython = Join-Path $venvPath 'Scripts\python.exe'
$requirements = Join-Path $toolRoot 'requirements.lock.txt'
$bundledPython = Join-Path $HOME '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'

if ($Force -and (Test-Path -LiteralPath $venvPath)) {
    $resolvedToolRoot = [System.IO.Path]::GetFullPath($toolRoot)
    $resolvedVenv = [System.IO.Path]::GetFullPath($venvPath)
    if (-not $resolvedVenv.StartsWith($resolvedToolRoot, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing to remove venv outside tool root: $resolvedVenv"
    }
    Remove-Item -LiteralPath $resolvedVenv -Recurse -Force
}

if (-not (Test-Path -LiteralPath $venvPython)) {
    if (Test-Path -LiteralPath $bundledPython) {
        $basePython = $bundledPython
    } else {
        $pythonCommand = Get-Command python -ErrorAction SilentlyContinue
        if (-not $pythonCommand) {
            throw 'No usable Python interpreter was found.'
        }
        $basePython = $pythonCommand.Source
    }

    & $basePython -m venv $venvPath
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to create the validation virtual environment.'
    }
}

& $venvPython -m pip install --disable-pip-version-check -r $requirements
if ($LASTEXITCODE -ne 0) {
    throw 'Failed to install validation dependencies.'
}

& $venvPython -c "import yaml; print('Validator environment ready. PyYAML ' + yaml.__version__)"
if ($LASTEXITCODE -ne 0) {
    throw 'PyYAML verification failed.'
}
