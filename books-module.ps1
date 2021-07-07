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
