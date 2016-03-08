Function Test-PreferExternalManifiestRegistryKeyExists {
    
    [CmdletBinding()]
    [OutputType([Bool])]

    Param ()

    Begin {
        $params = @{
            Path = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\SideBySide'
            Name = 'PreferExternalManifest'
            ErrorAction = 'SilentlyContinue'
        }
    }

    End {
        if (Get-ItemProperty @params) {
            $true
        } else {
            $false
        }
    }
}