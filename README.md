Block exe          
  
       $dir = $PWD.Path; Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -Command `"Set-Location -LiteralPath '$dir'; Invoke-WebRequest 'https://raw.githubusercontent.com/noeyefish/AdminBat/refs/heads/main/Block_all_exe_in_folder_IN_OUT.bat' -OutFile 'FirewallManager.bat'; .\FirewallManager.bat`""







```
iwr "https://raw.githubusercontent.com/noeyefish/AdminBat/refs/heads/main/Admin_Menu_All_In_One.bat" -OutFile "$env:TEMP\\tmp.bat"; Start-Process "$env:TEMP\\tmp.bat" -Verb RunAs

```


https://schneegans.de/windows/unattend-generator/?LanguageMode=Unattended&UILanguage=he-IL&Locale=he-IL&Keyboard=0000040d&UseKeyboard2=true&Locale2=en-US&Keyboard2=00000409&GeoLocation=117&ProcessorArchitecture=amd64&ComputerNameMode=Random&CompactOsMode=Never&TimeZoneMode=Explicit&TimeZone=Israel+Standard+Time&PartitionMode=Interactive&DiskAssertionMode=Skip&WindowsEditionMode=Generic&WindowsEdition=pro&InstallFromMode=Automatic&PEMode=Default&UserAccountMode=Unattended&AccountName0=Admin&AccountDisplayName0=&AccountPassword0=&AccountGroup0=Administrators&AutoLogonMode=Own&PasswordExpirationMode=Unlimited&LockoutMode=Default&HideFiles=Hidden&ShowFileExtensions=true&ClassicContextMenu=true&LaunchToThisPC=true&ShowEndTask=true&TaskbarSearch=Hide&TaskbarIconsMode=Empty&DisableWidgets=true&LeftTaskbar=true&HideTaskViewButton=true&DisableBingResults=true&StartTilesMode=Empty&StartPinsMode=Empty&EffectsMode=Default&DeleteEdgeDesktopIcon=true&DesktopIconsMode=Custom&IconRecycleBin=true&StartFoldersMode=Custom&StartFolderDownloads=true&StartFolderPersonalFolder=true&StartFolderPictures=true&StartFolderSettings=true&WifiMode=Interactive&ExpressSettings=DisableAll&LockKeysMode=Skip&StickyKeysMode=Disabled&ColorMode=Default&WallpaperMode=Default&LockScreenMode=Default&RemoveNotepad=true&RemovePowerShell2=true&RemoveZuneMusic=true&RemoveWindowsTerminal=true&SystemScript0=%24uri+%3D+%5Buri%5D%3A%3Anew%28+%27https%3A%2F%2Fdl.google.com%2Fchrome%2Finstall%2Fchrome_installer.exe%27+%29%3B%0D%0A%24file+%3D+%22%24env%3ATEMP%5C%7B0%7D%22+-f+%24uri.Segments%5B-1%5D%3B%0D%0A%5BSystem.Net.WebClient%5D%3A%3Anew%28%29.DownloadFile%28+%24uri%2C+%24file+%29%3B%0D%0AStart-Process+-FilePath+%24file+-ArgumentList+%27%2Fsilent+%2Finstall%27+-Wait%3B%0D%0ARemove-Item+-LiteralPath+%24file+-ErrorAction+%27SilentlyContinue%27%3B&SystemScriptType0=Ps1&FirstLogonScript0=reg+add+%22HKLM%5CSOFTWARE%5CMicrosoft%5CWindowsUpdate%5CUX%5CSettings%22+%2Fv+PauseFeatureUpdatesEndTime+%2Ft+REG_SZ+%2Fd+%222100-01-03T11%3A10%3A19Z%22+%2Ff%0D%0A%0D%0Areg+add+%22HKLM%5CSOFTWARE%5CMicrosoft%5CWindowsUpdate%5CUX%5CSettings%22+%2Fv+PauseQualityUpdatesEndTime+%2Ft+REG_SZ+%2Fd+%222100-01-03T11%3A10%3A19Z%22+%2Ff%0D%0A%0D%0Areg+add+%22HKLM%5CSOFTWARE%5CMicrosoft%5CWindowsUpdate%5CUX%5CSettings%22+%2Fv+PauseUpdatesExpiryTime+%2Ft+REG_SZ+%2Fd+%222100-01-03T11%3A10%3A19Z%22+%2Ff%0D%0A%0D%0Aecho+Done%21%0D%0A%40pause&FirstLogonScriptType0=Cmd&WdacMode=Skip&AppLockerMode=Skip
