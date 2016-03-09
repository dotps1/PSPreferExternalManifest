Function Remove-PreferExternalManifestRegistryKey {

    [CmdletBinding()]
    [OutputType()]

    Param ()

    Begin {
        $params = @{
            Path = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\SideBySide'
            Name = 'PreferExternalManifest'
            ErrorAction = 'Stop'
        }
    }

    End {
        try {
            Remove-ItemProperty @params

            Write-Warning -Message "The registry value '$($params.Name)' was removed from '$($params.Path)'.  You may need to reboot your computer for the changes to take affect."
        } catch {
            throw $_
        }
    }
}