@echo off
>nul 2>&1 "%SYSTEMROOT%\System32\cacls.exe" "%SYSTEMROOT%\System32\config\system"

REM Check if the script is running with administrator privileges
if '%errorlevel%' NEQ '0' (
    echo Running as a non-administrator. Relaunching with administrator privileges...
    echo.
    powershell -Command "Start-Process -Verb RunAs cmd.exe '/C %~dpnx0'"
    exit /b
)

REM Welcome message
echo Welcome, %USERNAME%! This is the context menu script.

:MENU
cls
echo Context Menu Options:
echo.
echo 1. Create Report for Battery
echo 2. Create Report for System Information
echo 3. Create Energy Report
echo 4. Print Service Tag of the Laptop
echo 5. Print Info about Wi-Fi
echo 6. Wi-Fi Report
echo 7. Upgrade Windows Package Manager winget
echo 8. Upgrade all installed packages with winget
echo 9. Open https://ninite.com website
echo 10. Restart the system and enter the BIOS setup
echo 0. Exit
echo.

set /p choice=Enter your choice (1-10, 0): 

if "%choice%"=="1" (
    call :CREATE_BATTERY_REPORT
    goto MENU
)

if "%choice%"=="2" (
    call :CREATE_SYSTEM_INFO_REPORT
    goto MENU
)

if "%choice%"=="3" (
    call :CREATE_ENERGY_REPORT
    goto MENU
)

if "%choice%"=="4" (
    call :PRINT_SERVICE_TAG
    goto MENU
)

if "%choice%"=="5" (
    call :PRINT_WIFI_INFO
    goto MENU
)

if "%choice%"=="6" (
    call :WI_FI_REPORT
    goto MENU
)

if "%choice%"=="7" (
    call :UPGRADE_WINGET
    goto MENU
)

if "%choice%"=="8" (
    call :UPGRADE_ALL_PACKAGES
    goto MENU
)

if "%choice%"=="9" (
    start "" "https://ninite.com/"
    goto MENU
)

if "%choice%"=="10" (
    echo Restarting and entering BIOS...
    shutdown /r /fw /f /t 0
    goto MENU
)

if "%choice%"=="0" (
    goto :END
)

echo Invalid choice. Please try again.
pause
goto MENU

:CREATE_BATTERY_REPORT
echo Creating Battery Report...
powercfg /batteryreport
echo Battery Report created successfully.

pause
goto CONTINUE

:CREATE_SYSTEM_INFO_REPORT
echo Creating System Information Report...
systeminfo > "SystemInfoReport.txt"
echo System Information Report created successfully. Saved as "SystemInfoReport.txt"

pause
goto CONTINUE

:CREATE_ENERGY_REPORT
echo Creating Energy Report...
powercfg /energy
echo Energy Report created successfully.

pause
goto CONTINUE

:PRINT_SERVICE_TAG
echo Printing Service Tag of the Laptop...
wmic bios get serialnumber

pause
goto CONTINUE

:PRINT_WIFI_INFO
echo Printing Info about Wi-Fi...
netsh wlan show interfaces

pause
goto CONTINUE

:WI_FI_REPORT
echo Generating Wi-Fi Report...
netsh wlan show wlanreport
echo Wi-Fi Report generated successfully.

pause
goto CONTINUE

:UPGRADE_WINGET
echo Upgrading Windows Package Manager (winget)...
winget upgrade

pause
goto CONTINUE

:UPGRADE_ALL_PACKAGES
echo Upgrading all installed packages with winget...
winget upgrade -all

pause
goto CONTINUE

:END
REM End of script
echo Thank you for your time %USERNAME%! See ya!

pause
goto :EOF
