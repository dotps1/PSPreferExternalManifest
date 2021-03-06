#PSPreferExternalManifest#

This is a module I am working on to help with the BS Scaling issues when using my Surface Pro 4.

Basically there is a registry key that if set, you can then put application manifest files with the .exe's to tell it to not be DPI aware.  This is to just help with that.


![alt tag](http://dotps1.github.io/PSPreferExternalManifest/Images/keepass.gif)

    
###Examples###

This will verify the registry key exists, if not create it, test for the manifest file, if not found, creates it.
And only adds the dpiAware value.  If the application is running you will get a warning to restart it.
```PowerShell
PS C:\> Set-ApplicationManifestDpiAware -Path 'C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe' -DpiAware Fal
se


PreferExternalManifest    : True
ManifestFilePath          : C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe.manifest
ApplicationFilePath       : C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe
DpiAware                  : False
ManifestCreatedOrModified : True


WARNING: The manifest was created or modified successfully for C:\Program Files (x86)\KeePass Password Safe
2\KeePass.exe.  The application will need be restarted for the changes to take effect.
PS C:\>
```


This will change the value in the manifest that already exists for this application from 'True\PM' to 'false' and then restart the application.
```PowerShell
PS C:\> Set-ApplicationManifestDpiAware -Path 'C:\Program Files\Microsoft Office\Office16\lync.exe' -DpiAware False -For
ceApplicationRestart


PreferExternalManifest    : True
ManifestFilePath          : C:\Program Files\Microsoft Office\Office16\lync.exe.manifest
ApplicationFilePath       : C:\Program Files\Microsoft Office\Office16\lync.exe
DpiAware                  : False
ManifestCreatedOrModified : False
``` 

###todo's###
* ~~If the manifest file already exists, append, or change the dpiAware value.~~
* ~~Add Remove-PreferExternalManifestRegistryKey.~~
* If the manifest file already exists, but the node path assembly.application.windowsSettings.dpiAware doesn't exist, add it.
* Create ability to search from existing process.  Possibly a param set.


###notes###
* Admin privileges required to use this module.