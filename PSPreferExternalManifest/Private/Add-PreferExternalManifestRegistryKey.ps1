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

            Write-Warning -Message "The registry value '$($params.Name)' was added to '$($params.Path)'.  You may need to reboot your computer for the changes to take affect."
        } catch {
            throw $_
        }
    }
}