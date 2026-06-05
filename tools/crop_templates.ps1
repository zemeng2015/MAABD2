param(
    [string]$ProjectRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
)

Add-Type -AssemblyName System.Drawing

$cropFile = Join-Path $ProjectRoot 'docs/screenshots/template-crops.json'
$imageRoot = Join-Path $ProjectRoot 'resource/image'
$previewFile = Join-Path $ProjectRoot 'docs/screenshots/template_preview.png'

$crops = Get-Content -Raw -Encoding UTF8 -LiteralPath $cropFile | ConvertFrom-Json

function Save-Crop {
    param(
        [string]$TemplatePath,
        [object]$Spec
    )

    $src = Join-Path $ProjectRoot $Spec.source
    $dst = Join-Path $imageRoot $TemplatePath
    $dstDir = Split-Path -Parent $dst
    if (!(Test-Path -LiteralPath $dstDir)) {
        New-Item -ItemType Directory -Force -Path $dstDir | Out-Null
    }

    $box = $Spec.box
    $img = [System.Drawing.Bitmap]::FromFile($src)
    try {
        $rect = New-Object System.Drawing.Rectangle($box[0], $box[1], $box[2], $box[3])
        $crop = $img.Clone($rect, $img.PixelFormat)
        try {
            $crop.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
        }
        finally {
            $crop.Dispose()
        }
    }
    finally {
        $img.Dispose()
    }
}

$templateNames = @()
foreach ($prop in $crops.PSObject.Properties) {
    Save-Crop -TemplatePath $prop.Name -Spec $prop.Value
    $templateNames += $prop.Name
}

$thumbW = 220
$thumbH = 120
$labelH = 28
$pad = 12
$cols = 3
$rows = [Math]::Ceiling($templateNames.Count / $cols)
$sheetW = $cols * ($thumbW + $pad) + $pad
$sheetH = $rows * ($thumbH + $labelH + $pad) + $pad

$sheet = New-Object System.Drawing.Bitmap($sheetW, $sheetH)
$g = [System.Drawing.Graphics]::FromImage($sheet)
$font = New-Object System.Drawing.Font('Arial', 9)

try {
    $g.Clear([System.Drawing.Color]::FromArgb(245, 245, 245))

    for ($i = 0; $i -lt $templateNames.Count; $i++) {
        $rel = $templateNames[$i]
        $path = Join-Path $imageRoot $rel
        $img = [System.Drawing.Image]::FromFile($path)
        try {
            $col = $i % $cols
            $row = [Math]::Floor($i / $cols)
            $x = $pad + $col * ($thumbW + $pad)
            $y = $pad + $row * ($thumbH + $labelH + $pad)
            $scale = [Math]::Min($thumbW / $img.Width, $thumbH / $img.Height)
            $w = [int]($img.Width * $scale)
            $h = [int]($img.Height * $scale)
            $dx = $x + [int](($thumbW - $w) / 2)
            $dy = $y + [int](($thumbH - $h) / 2)

            $g.FillRectangle([System.Drawing.Brushes]::White, $x, $y, $thumbW, $thumbH)
            $g.DrawImage($img, $dx, $dy, $w, $h)
            $g.DrawString($rel, $font, [System.Drawing.Brushes]::Black, $x, $y + $thumbH + 4)
        }
        finally {
            $img.Dispose()
        }
    }

    $sheet.Save($previewFile, [System.Drawing.Imaging.ImageFormat]::Png)
}
finally {
    $font.Dispose()
    $g.Dispose()
    $sheet.Dispose()
}

Write-Output "Cropped $($templateNames.Count) templates."
Write-Output "Preview: $previewFile"

