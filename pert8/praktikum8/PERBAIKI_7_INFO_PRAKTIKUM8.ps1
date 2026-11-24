# PERBAIKI_7_INFO_PRAKTIKUM8.ps1
# Memperbaiki 7 lint info pada Praktikum 8 tanpa mengulang instalasi.
# Jalankan dari root project Flutter menggunakan CMD Windows.
$ErrorActionPreference = 'Stop'
$project = $PSScriptRoot
Set-Location -LiteralPath $project

if (-not (Test-Path -LiteralPath (Join-Path $project 'pubspec.yaml'))) {
    throw 'pubspec.yaml tidak ditemukan. Simpan script ini di root praktikum8.'
}

$pubspec = [System.IO.File]::ReadAllText((Join-Path $project 'pubspec.yaml'))
if ($pubspec -notmatch '(?m)^name:\s*praktikum8\s*$') {
    throw 'Nama package pubspec.yaml bukan praktikum8. Perbaikan dihentikan untuk mencegah import salah.'
}

$payload = @'
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
'@
$compressed = [System.Convert]::FromBase64String(($payload -replace '\s+', ''))
$buffer = New-Object System.IO.MemoryStream(, $compressed)
$gzip = New-Object System.IO.Compression.GZipStream($buffer, [System.IO.Compression.CompressionMode]::Decompress)
$reader = New-Object System.IO.StreamReader($gzip, [System.Text.Encoding]::UTF8)
try {
    $json = $reader.ReadToEnd()
} finally {
    $reader.Dispose()
    $gzip.Dispose()
    $buffer.Dispose()
}

$files = ConvertFrom-Json -InputObject $json
$utf8 = New-Object System.Text.UTF8Encoding($false)
$backupRoot = Join-Path $project ('.backup-fix-pert8\' + (Get-Date -Format 'yyyyMMdd_HHmmss'))
foreach ($item in $files.PSObject.Properties) {
    $relative = $item.Name.Replace('/', '\')
    $destination = Join-Path $project $relative
    if (-not (Test-Path -LiteralPath $destination)) {
        throw ('File sumber tidak ditemukan: ' + $relative)
    }
    $existing = [System.IO.File]::ReadAllText($destination)
    $updated = [string]$item.Value
    if ($existing -ceq $updated) {
        Write-Host ('SUDAH SESUAI: ' + $relative)
        continue
    }

    $backup = Join-Path $backupRoot ($relative + '.bak')
    $backupParent = Split-Path -Parent $backup
    if (-not (Test-Path -LiteralPath $backupParent)) {
        New-Item -ItemType Directory -Force -Path $backupParent | Out-Null
    }
    [System.IO.File]::Copy($destination, $backup, $true)
    [System.IO.File]::WriteAllText($destination, $updated, $utf8)
    Write-Host ('DIPERBAIKI: ' + $relative)
}

& dart format lib/pages/laporan_page.dart test/format_test.dart test/health_service_test.dart test/widget_test.dart
if ($LASTEXITCODE -ne 0) { throw 'dart format gagal.' }
& flutter analyze
if ($LASTEXITCODE -ne 0) { throw 'flutter analyze masih menemukan masalah. Periksa output.' }
& flutter test
if ($LASTEXITCODE -ne 0) { throw 'flutter test gagal. Periksa output.' }
Write-Host 'SELESAI: Source diperbaiki, analyze dan unit test lulus.'
