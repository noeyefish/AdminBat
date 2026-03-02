@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ---------------------------------------------------------
:: Firewall Rule Manager (EXE files in script folder)
:: - Menu: Block / Unblock
:: - No "Block" prefix in rule names
:: - Avoid duplicates: delete existing rules before adding
:: - Shows status + counts
:: - Waits for keypress and returns to menu (never auto-closes)
:: ---------------------------------------------------------

:: Get the folder where this script is located
set "current_dir=%~dp0"
cd /d "%current_dir%"

:: Check for Administrator privileges
net session >nul 2>&1
if not "%errorlevel%"=="0" (
    echo [!] Administrator privileges are required.
    echo     Right-click this .bat and choose "Run as administrator".
    pause
    exit /b 1
)

:MENU
cls
echo ========================================================
echo              FIREWALL RULE MANAGER
echo ========================================================
echo Folder: "%current_dir%"
echo --------------------------------------------------------
echo [1] BLOCK Internet Access (IN + OUT) for all .exe here
echo [2] UNBLOCK Internet Access (delete rules) for all .exe
echo [3] Exit
echo ========================================================
set /p "choice=Enter your choice (1-3): "

if "%choice%"=="1" goto BLOCK
if "%choice%"=="2" goto UNBLOCK
if "%choice%"=="3" goto END

echo.
echo Invalid choice.
pause
goto MENU


:BLOCK
cls
echo Blocking internet access for EXE files in:
echo "%current_dir%"
echo.

set "exe_count=0"
set "rules_added=0"
set "rules_removed=0"

for %%F in (*.exe) do (
    set /a exe_count+=1
    echo Processing: %%~nxF

    :: Remove existing rules first (avoid duplicates) + count removals if they exist
    netsh advfirewall firewall show rule name="%%~nxF IN"  >nul 2>&1
    if not errorlevel 1 (
        netsh advfirewall firewall delete rule name="%%~nxF IN"  >nul 2>&1
        set /a rules_removed+=1
    )

    netsh advfirewall firewall show rule name="%%~nxF OUT" >nul 2>&1
    if not errorlevel 1 (
        netsh advfirewall firewall delete rule name="%%~nxF OUT" >nul 2>&1
        set /a rules_removed+=1
    )

    :: Add fresh rules (IN + OUT)
    netsh advfirewall firewall add rule name="%%~nxF IN"  dir=in  action=block program="%current_dir%%%~nxF" enable=yes >nul 2>&1
    netsh advfirewall firewall add rule name="%%~nxF OUT" dir=out action=block program="%current_dir%%%~nxF" enable=yes >nul 2>&1
    set /a rules_added+=2
)

echo.
if "%exe_count%"=="0" (
    echo No EXE files found in this folder.
) else (
    echo SUMMARY:
    echo --------------------------------
    echo EXE files processed : %exe_count%
    echo Rules removed       : %rules_removed%
    echo Rules added         : %rules_added%
    echo.
    echo Done. All EXE files were blocked.
)

pause
goto MENU


:UNBLOCK
cls
echo Checking firewall status and removing rules...
echo.

set "exe_count=0"
set "rules_removed=0"
set "blocked_files=0"
set "not_blocked_files=0"

for %%F in (*.exe) do (
    set /a exe_count+=1
    set "blocked=no"

    netsh advfirewall firewall show rule name="%%~nxF IN"  >nul 2>&1
    if not errorlevel 1 set "blocked=yes"

    netsh advfirewall firewall show rule name="%%~nxF OUT" >nul 2>&1
    if not errorlevel 1 set "blocked=yes"

    if "!blocked!"=="yes" (
        set /a blocked_files+=1
        echo %%~nxF : BLOCKED  ^> removing rules

        netsh advfirewall firewall delete rule name="%%~nxF IN"  >nul 2>&1
        if not errorlevel 1 set /a rules_removed+=1

        netsh advfirewall firewall delete rule name="%%~nxF OUT" >nul 2>&1
        if not errorlevel 1 set /a rules_removed+=1
    ) else (
        set /a not_blocked_files+=1
        echo %%~nxF : NOT BLOCKED  ^> skipped
    )
)

echo.
if "%exe_count%"=="0" (
    echo No EXE files found in this folder.
) else (
    echo SUMMARY:
    echo --------------------------------
    echo EXE files checked    : %exe_count%
    echo Blocked EXE files    : %blocked_files%
    echo Not blocked EXE files: %not_blocked_files%
    echo Rules removed        : %rules_removed%
    echo.
    echo Done.
)

pause
goto MENU


:END
echo Goodbye.
endlocal
exit /b 0
