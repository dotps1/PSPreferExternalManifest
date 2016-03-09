Function Set-ApplicationManifestNotDpiAware {
    
    [CmdletBinding()]
    [OutputType([PSCustomObject])]

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
        if (-not ($preferExternalManifest = Test-PreferExternalManifiestRegistryKeyExists)) {
            try {
                Add-PreferExternalManifestRegistryKey
            } catch {
                throw $_
            }
        }
    }
    
    Process {
        for ($i = 0; $i -lt $Path.Length; $i++) {
            $manifestCreatedOrModified = $false

            if (-not (Test-ApplicationManifestExists -Path $Path[$i])) {
                New-ApplicationManifest -Path $Path[$i]

                $manifestCreatedOrModified = $true
            } else {
                try {
                    [Xml]$manifest = Get-Content -Path "$($Path[$i]).manifest"
                    if ($manifest.SelectSingleNode("//*[local-name() = 'dpiAware']").'#text' -ne $null -and $manifest.SelectSingleNode("//*[local-name() = 'dpiAware']").'#text' -ne $false) {
                        $manifest.SelectSingleNode("//*[local-name() = 'dpiAware']").'#text' = ($false -as [String])
                        $manifest.Save("$($Path[$i]).manifest")

                        $manifestCreatedOrModified = $true
                    } else {
                        # TODO: create entire node if missing.
                    }
                } catch {
                    Write-Error -Message $_.ToString()
                }
            }

            New-Object -TypeName PSCustomObject -Property ([Ordered]@{
                PreferExternalManifest = $preferExternalManifest
                ManifestFilePath = "$($Path[$i]).manifest"
                ApplicationFilePath = $Path[$i]
                DPIAware = ([Xml](Get-Content -Path "$($Path[$i]).manifest")).SelectSingleNode("//*[local-name() = 'dpiAware']").'#text'
            }) | Format-List

            if ($manifestCreatedOrModified) {
                if ($ForceApplicationRestart.IsPresent) {
                    try {
                        Get-Process | Where-Object {
                            $_.Path -eq $Path[$i]
                        } | Stop-Process -Force -Confirm:$false -ErrorAction Stop

                        Start-Process -FilePath $Path[$i]
                    } catch {
                        Write-Error -Message $_.ToString()
                    }
                } elseif (Get-Process -Name (Split-Path -Path $Path[$i] -Leaf).TrimEnd('.exe') -ErrorAction SilentlyContinue) {
                    Write-Warning -Message "The manifest was created or modified successfuly for $($Path[$i]).  The application will need be restarted for the changes to take effect."
                }
            }
        }
    }
}