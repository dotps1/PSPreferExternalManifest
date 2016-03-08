#PSPreferExternalManifest#

This is module I am working on to help with the BS Scalling issues when using my Surface Pro 4.

Basically there is a registry key that if set, you can then put application manifest files with the .exe's to tell it to not be DPI aware.  This is to just help with that.

###Examples###

```PowerShell
#requires -Modules PSPreferExternalManifest

Set-ApplicationManifestNotDpiAware -Path C:\Windows\System32\mstsc.exe

    Directory: C:\Windows\System32


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----         3/8/2016  11:44 AM           1294 mstsc.exe.manifest
```
This will verify the registry key exists, if not create it, test for the manifest file, in not found, creates it.


###todo's###
* if the manifest file already exists, append, or change the dpi value.
* add Set-ApplicationManifestDpiAware to revert change
* add Remove-PreferExternalManifestRegistryKey


###notes###
* Admin privliges requied to use this module.