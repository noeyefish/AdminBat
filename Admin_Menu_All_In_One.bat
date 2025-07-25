@echo off
:: Force admin privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B
)

:: Set blue background, white text
color 1F
title Admin Script Menu

:MENU
cls
echo.
echo ================================
echo        ADMIN SCRIPT MENU
echo ================================
echo.
echo 1. Block All EXE in Folder (IN/OUT)
echo 2. Pause Windows Update
echo 3. Enable Full Right-Click Menu (Win11)
echo 4. Exit
echo.

set /p choice=Select an option (1-4): 

if "%choice%"=="1" (
    call :BLOCK_EXE
    pause
    goto MENU
) else if "%choice%"=="2" (
    call :PAUSE_UPDATES
    pause
    goto MENU
) else if "%choice%"=="3" (
    call :CONTEXT_MENU
    pause
    goto MENU
) else if "%choice%"=="4" (
    exit
) else (
    echo Invalid choice. Please select 1-4.
    timeout /t 2 >nul
    goto MENU
)

:BLOCK_EXE
@echo off
setlocal enabledelayedexpansion

:: קבלת הנתיב של התיקייה שבה נמצא הסקריפט
set "current_dir=%~dp0"

cd /d "%current_dir%"

for %%F in (*.exe) do (
    echo חוסם את %%F בחומת האש...
    netsh advfirewall firewall add rule name="Block %%~nxF IN" dir=in action=block program="%current_dir%%%F" enable=yes
    netsh advfirewall firewall add rule name="Block %%~nxF OUT" dir=out action=block program="%current_dir%%%F" enable=yes
)

echo כל קובצי ה-EXE בתיקייה "%current_dir%" נחסמו בהצלחה!
pause

goto :eof

:PAUSE_UPDATES
@echo off
color 2

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseFeatureUpdatesEndTime /t REG_SZ /d "2100-01-03T11:10:19Z" /f

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseQualityUpdatesEndTime /t REG_SZ /d "2100-01-03T11:10:19Z" /f

reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v PauseUpdatesExpiryTime /t REG_SZ /d "2100-01-03T11:10:19Z" /f

echo Done!
pause

goto :eof

:CONTEXT_MENU
@echo off
title Right-Click Menu Selector

echo What do you want to do?
echo 1. Use Windows 10-style right-click menu
echo 2. Use Windows 11-style right-click menu
set /p choice=Enter your choice (1 or 2): 

if "%choice%"=="1" (
    echo Applying Windows 10-style right-click menu...
    reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f
    echo Restarting Explorer...
    taskkill /f /im explorer.exe
    start explorer.exe
    echo Done.
) else if "%choice%"=="2" (
    echo Applying Windows 11-style right-click menu...
    reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
    echo Restarting Explorer...
    taskkill /f /im explorer.exe
    start explorer.exe
    echo Done.
) else (
    echo Invalid choice. Exiting.
)



goto :eof
