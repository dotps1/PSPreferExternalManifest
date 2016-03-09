#PSPreferExternalManifest#

This is module I am working on to help with the BS Scalling issues when using my Surface Pro 4.

Basically there is a registry key that if set, you can then put application manifest files with the .exe's to tell it to not be DPI aware.  This is to just help with that.

###Examples###

This will verify the registry key exists, if not create it, test for the manifest file, in not found, creates it.
Only adds the dpiAware value.
```PowerShell
PS C:\> Set-ApplicationManifestNotDpiAware -Path 'C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe'


    Directory: C:\Program Files (x86)\KeePass Password Safe 2


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         3/9/2016   9:30 AM           1294 KeePass.exe.manifest
WARNING: The manifest was created successfuly for C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe.  The
application will need be restarted for the changes to take effect.

PS C:\>
```


This will change the value in the manifest that already exists for this application from 'True\PM' to 'False' and then restart the application.
```PowerShell
PS C:\> Set-ApplicationManifestNotDpiAware -Path $env:ProgramFiles\Office\Office16\lync.exe -ForceRestartApplication
``` 

###todo's###
* ~~if the manifest file already exists, append, or change the dpiAware value.~~
* add Set-ApplicationManifestDpiAware to revert change.
* ~~add Remove-PreferExternalManifestRegistryKey.~~
* if the manifest file already exists, but the node path assembly.application.windowsSettings.dpiAware doesnt exist, add it.


###notes###
* Admin privliges requied to use this module.