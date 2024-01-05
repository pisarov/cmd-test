@echo off

REM Welcome message
echo Welcome, %USERNAME%! This is the context menu script.

:MENU
cls
echo Context Menu Options:
echo.
echo 1. Create Report for Battery
echo 2. Create Report for System Information
echo 3. Print Service Tag of the Laptop
echo 4. Print Info about Wi-Fi
echo 5. Exit
echo.

set /p choice=Enter your choice (1-5): 

if "%choice%"=="1" (
    call :CREATE_BATTERY_REPORT
    goto MENU
)

if "%choice%"=="2" (
    call :CREATE_SYSTEM_INFO_REPORT
    goto MENU
)

if "%choice%"=="3" (
    call :PRINT_SERVICE_TAG
    goto MENU
)

if "%choice%"=="4" (
    call :PRINT_WIFI_INFO
    goto MENU
)

if "%choice%"=="5" (
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

:END
REM End of script
echo Thank you for your time %USERNAME%! See ya!
pause
exit /b

:CONTINUE
REM This label is used to continue the execution after a specific command
goto :EOF
