[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$OriginalPath,

    [Parameter(Mandatory = $true)]
    [string]$RevisedPath,

    [string]$OutputPath,

    [string]$RevisedAuthor = 'Codex',

    [switch]$Visible,

    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Resolve-RequiredPath {
    param([string]$PathValue)
    if (-not (Test-Path -LiteralPath $PathValue)) {
        throw "Path not found: $PathValue"
    }
    return (Resolve-Path -LiteralPath $PathValue).Path
}

function Get-DefaultOutputPath {
    param(
        [string]$OriginalFile,
        [string]$RevisedFile
    )

    $revisedItem = Get-Item -LiteralPath $RevisedFile
    $stem = [System.IO.Path]::GetFileNameWithoutExtension($revisedItem.Name)
    $cleanSuffix = '-CPC' + [string]([char]0x6E05) + [char]0x6D01 + [char]0x7248
    $revisionSuffix = '-CPC' + [string]([char]0x4FEE) + [char]0x8BA2 + [char]0x7248
    if ($stem.EndsWith($cleanSuffix)) {
        $stem = $stem.Substring(0, $stem.Length - $cleanSuffix.Length) + $revisionSuffix
    }
    else {
        $stem = $stem + $revisionSuffix
    }
    return (Join-Path $revisedItem.DirectoryName ($stem + $revisedItem.Extension))
}

$original = Resolve-RequiredPath -PathValue $OriginalPath
$revised = Resolve-RequiredPath -PathValue $RevisedPath
$output = if ($OutputPath) { $OutputPath } else { Get-DefaultOutputPath -OriginalFile $original -RevisedFile $revised }
$output = [System.IO.Path]::GetFullPath($output)

if ((Test-Path -LiteralPath $output) -and -not $Force) {
    throw "Output already exists. Re-run with -Force or choose a new OutputPath: $output"
}

if (Test-Path -LiteralPath $output) {
    Remove-Item -LiteralPath $output -Force
}

$wdCompareDestinationNew = 2
$wdGranularityWordLevel = 0
$wdFormatXMLDocument = 12

$word = $null
$originalDoc = $null
$revisedDoc = $null
$compareDoc = $null

try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = [bool]$Visible
    $word.DisplayAlerts = 0

    $originalDoc = $word.Documents.Open($original, $false, $true)
    $revisedDoc = $word.Documents.Open($revised, $false, $true)

    $compareDoc = $word.CompareDocuments(
        $originalDoc,
        $revisedDoc,
        $wdCompareDestinationNew,
        $wdGranularityWordLevel,
        $true,
        $true,
        $true,
        $true,
        $true,
        $true,
        $true,
        $true,
        $true,
        $true,
        $RevisedAuthor,
        $true
    )

    $compareDoc.SaveAs2($output, $wdFormatXMLDocument)
    Write-Output "REVISION_COPY $output"
}
finally {
    if ($compareDoc) { try { $compareDoc.Close($false) } catch {} }
    if ($originalDoc) { try { $originalDoc.Close($false) } catch {} }
    if ($revisedDoc) { try { $revisedDoc.Close($false) } catch {} }
    if ($word) { try { $word.Quit() } catch {} }
}
