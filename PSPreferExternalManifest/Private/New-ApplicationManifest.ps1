Function New-ApplicationManifest {
    [CmdletBinding()]
    [OutputType([Bool])]

    Param (
        [Parameter(
            Mandatory = $true
        )]
        [String]
        $Path
    )

    Begin {
        [Xml]$manifest = (Get-Content -Path "$PSScriptRoot\..\bin\_.manifest").Replace(
            '<--!ProcessorArchitecture!-->', $env:PROCESSOR_ARCHITECTURE
        )
    }

    End {
        try {
            #New-Item -Path (Split-Path -Path $Path -Parent) -Name "$(Split-Path -Path $Path -Leaf).manifest" -ItemType File -Value $manifest -Force
            $manifest.Save("${Path}.manifest")

            Get-Item -Path "${Path}.manifest"
        } catch {
            throw $_
        }
    }
}