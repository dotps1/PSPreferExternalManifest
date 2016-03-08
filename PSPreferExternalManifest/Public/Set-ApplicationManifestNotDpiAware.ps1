Function Set-ApplicationManifestNotDpiAware {
    
    [CmdletBinding()]
    [OutputType([System.IO.FileInfo])]

    Param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [String[]]
        $Path
    )

    Begin {
        if (-not (Test-PreferExternalManifiestRegistryKeyExists)) {
            try {
                Add-PreferExternalManifestRegistryKey
            } catch {
                throw $_
            }
        }
    }
    
    Process {
        for ($i = 0; $i -lt $Path.Length; $i++) {
            if (-not (Test-ApplicationManifestExists -Path $Path[$i])) {
                New-ApplicationManifest -Path $Path[$i]
            } else {
            
            }
        }
    }
}