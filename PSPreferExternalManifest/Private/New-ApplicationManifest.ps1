Function New-ApplicationManifest {

    [CmdletBinding()]
    [OutputType([Void])]

    Param (
        [Parameter(
            Mandatory = $true
        )]
        [String]
        $Path,

        [Parameter(
            Mandatory = $true
        )]
        [Bool]
        $DpiAware
    )

    Begin {
        [Xml]$manifest = (Get-Content -Path "$PSScriptRoot\..\bin\_.manifest").Replace(
            '<--!ProcessorArchitecture!-->', $env:PROCESSOR_ARCHITECTURE
        ).Replace(
            '<--!DpiAware!-->', $DpiAware
        )
    }

    End {
        try {
            $manifest.Save("${Path}.manifest")
        } catch {
            throw $_
        }
    }
}