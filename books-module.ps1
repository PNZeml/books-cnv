function New-Epub {
    param (
        [string]$SourcePath,
        [string]$DestinationPath
    )
    
    if (-not (Test-Path -Path $SourcePath)) {
        Return
    }

    $fileName = Split-Path -Path $SourcePath -LeafBase

    Compress-Archive -Path "${SourcePath}\\*" -DestinationPath "${fileName}.epub" -Force
}

function Minify {
    param (
        [string]$SourcePath
    )

    if (-not (Test-Path -Path $SourcePath)) {
        Return
    }

    $extToFilter = @(".jpg", ".jpge", ".png")

    $filePaths = Get-ChildItem -Path $SourcePath -File -Recurse |
        Where-Object {$extToFilter -notcontains $_.extension}

    foreach ($filePath in $filePaths) {
        Write-Output "Minifying content of $($filePath.FullName)"

        if ((Get-Content $filePath) -eq $Null) {
            Write-Output "File is empty, ignoring it"
            Continue
        }

        $newContent = html-minifier $filePath.FullName `
            --keepClosingSlash true

        Set-Content -Path $filePath -Value $newContent
    }
}