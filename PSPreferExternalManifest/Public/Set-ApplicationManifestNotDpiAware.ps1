Function Set-ApplicationManifestNotDpiAware {
    
    [CmdletBinding()]
    [OutputType([System.IO.FileInfo])]

    Param (
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [String[]]
        $Path,

        [Parameter()]
        [Switch]
        $ForceApplicationRestart
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
                [Xml]$manifest = Get-Content -Path "$($Path[$i]).manifest"
                if ($manifest.assembly.application.windowsSettings.dpiAware -and $manifest.assembly.application.windowsSettings.dpiAware -ne ($false -as [String])) {
                    try {
                        $manifest.assembly.application.windowsSettings.dpiAware = 'False'
                        $manifest.Save("$($Path[$i]).manifest")
                    } catch {
                        Write-Error -Message $_.ToString()
                    }
                } elseif ($manifest.assembly.application.windowsSettings.dpiAware.'#text' -and $manifest.assembly.application.windowsSettings.dpiAware.'#text' -ne ($false -as [String])) {
                    try {
                        $manifest.assembly.application.windowsSettings.dpiAware.'#text' = 'False'
                        $manifest.Save("$($Path[$i]).manifest")
                    } catch {
                        Write-Error -Message $_.ToString()                  
                    }
                } else {
                    # TODO: add full dpiAware node to manifest.
                }
            }

            if ($ForceApplicationRestart.IsPresent) {
                try {
                    Get-Process | Where-Object {
                        $_.Path -eq $Path[$i]
                    } | Stop-Process -Force -Confirm:$false -ErrorAction Stop

                    Start-Process -FilePath $Path[$i]
                } catch {
                    Write-Error -Message $_.ToString()
                }
            } else {
                Write-Warning -Message "The manifest was created successfuly for $($Path[$i]).  The application will need be restarted for the changes to take effect."
            }
        }
    }
}