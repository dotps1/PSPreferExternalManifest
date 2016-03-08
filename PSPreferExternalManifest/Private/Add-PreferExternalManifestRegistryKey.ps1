Function Add-PreferExternalManifestRegistryKey {

    [CmdletBinding()]
    [OutputType()]

    Param ()

    Begin {
        $params = @{
            Path = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\SideBySide'
            Name = 'PreferExternalManifest'
            PropertyType = 'DWORD'
            Value = 1
            ErrorAction = 'Stop'
        }
    }

    End {
        try {
            New-ItemProperty @params | Out-Null
        } catch {
            throw $_
        }
    }
}