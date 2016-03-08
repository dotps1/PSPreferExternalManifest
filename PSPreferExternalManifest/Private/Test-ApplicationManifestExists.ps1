Function Test-ApplicationManifestExists {

    [CmdletBinding()]
    [OutputType([Bool])]

    Param (
        [Parameter(
            Mandatory = $true
        )]
        [String]
        $Path
    )

    if (Test-Path -Path $Path) {
        if (Test-Path -Path "${Path}.manifest") {
            $true
        } else {
            $false
        }
    } else {
        throw "Path to application $Path not found."
    }
}