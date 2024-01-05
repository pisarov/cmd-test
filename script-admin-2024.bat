@echo off

REM Welcome message
echo Welcome, %USERNAME%! This is the context menu script.

SET CPU_INFO=
FOR /F "skip=1 tokens=*" %%A IN ('wmic cpu get caption ^| findstr "."') DO SET "CPU_INFO=%%A"

SET RAM_INFO=
FOR /F "skip=1 tokens=*" %%B IN ('wmic memorychip get capacity ^| findstr "."') DO SET "RAM_INFO=%%B"

SET GPU_INFO=
FOR /F "skip=1 tokens=*" %%C IN ('wmic path win32_videocontroller get caption ^| findstr "."') DO SET "GPU_INFO=%%C"

SET DISK_INFO=
FOR /F "skip=1 tokens=*" %%D IN ('wmic logicaldisk where "deviceid='C:'" get size ^| findstr "."') DO SET "DISK_INFO=%%D"


:MENU
cls
echo Context Menu Options:
echo.
echo 1. View All Users
echo 2. Create Report for Battery
echo 3. Create Report for System Information
echo 4. Print Service Tag of the Laptop
echo 5. Print Info about Wi-Fi
echo 6. Show Computer Name
echo 7. Check for Updates
echo 8. Report Windows Defender Status
echo 9. Check Windows Activation Status
echo 10. Show Activation Status and Product Key
echo 11. View CPU, RAM, GPU, and Disk Space
echo 12. Execute CMD Commands (Administrator)
echo 13. Command 1
echo 14. Command 2
echo 15. Command 3
echo 16. Exit
echo.

set /p choice=Enter your choice (1-16): 

if "%choice%"=="1" (
    call :VIEW_ALL_USERS
    goto MENU
)

if "%choice%"=="2" (
    call :CREATE_BATTERY_REPORT
    goto MENU
)

if "%choice%"=="3" (
    call :CREATE_SYSTEM_INFO_REPORT
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
    call :SHOW_COMPUTER_NAME
    goto MENU
)

if "%choice%"=="7" (
    call :CHECK_FOR_UPDATES
    goto MENU
)

if "%choice%"=="8" (
    call :REPORT_DEFENDER_STATUS
    goto MENU
)

if "%choice%"=="9" (
    call :CHECK_ACTIVATION_STATUS
    goto MENU
)

if "%choice%"=="10" (
    call :SHOW_ACTIVATION_STATUS_AND_KEY
    goto MENU
)

if "%choice%"=="11" (
    call :VIEW_SYSTEM_INFO
    goto MENU
)

if "%choice%"=="12" (
    call :EXECUTE_CMD_COMMANDS
    goto MENU
)

if "%choice%"=="13" (
    call :COMMAND1
    goto MENU
)

if "%choice%"=="14" (
    call :COMMAND2
    goto MENU
)

if "%choice%"=="15" (
    call :COMMAND3
    goto MENU
)

if "%choice%"=="16" (
    goto :END
)

echo Invalid choice. Please try again.
pause
goto MENU

:VIEW_ALL_USERS
echo Viewing All Users...
net user
pause
exit /b

:CREATE_BATTERY_REPORT
echo Creating Battery Report...
powercfg /batteryreport
echo Battery Report created successfully.
pause
exit /b

:CREATE_SYSTEM_INFO_REPORT
echo Creating System Information Report...
systeminfo > "SystemInfoReport.txt"
echo System Information Report created successfully. Saved as "SystemInfoReport.txt"
pause
exit /b

:PRINT_SERVICE_TAG
echo Printing Service Tag of the Laptop...
wmic bios get serialnumber
pause
exit /b

:PRINT_WIFI_INFO
echo Printing Info about Wi-Fi...
netsh wlan show interfaces
pause
exit /b

:SHOW_COMPUTER_NAME
echo Showing Computer Name...
hostname
pause
exit /b

:CHECK_FOR_UPDATES
echo Checking for updates...
wuauclt /detectnow
timeout /t 30 >nul 2>&1
echo Update Status:
powershell -command "Get-WmiObject -Class Win32_QuickFixEngineering | Select-Object -Property HotFixID,Description"
pause
exit /b

:REPORT_DEFENDER_STATUS
echo Reporting Windows Defender Status...
reg query "HKLM\SOFTWARE\Microsoft\Windows Defender\Status" /v "DisableAntiSpyware"
echo.
pause
exit /b

:CHECK_ACTIVATION_STATUS
echo Checking Windows Activation Status...
cscript //nologo "%windir%\system32\slmgr.vbs" /dli
pause
exit /b

:SHOW_ACTIVATION_STATUS_AND_KEY
echo Showing Windows Activation Status and Product Key...
wmic path softwarelicensingservice get OA3xOriginalProductKey
cscript //nologo "%windir%\system32\slmgr.vbs" /dli
pause
exit /b

:VIEW_SYSTEM_INFO
echo Viewing CPU, RAM, GPU, and Disk Space...

powershell -command "& { Get-CimInstance -ClassName Win32_Processor | Select-Object -Property DeviceID, Name, Manufacturer, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors | Format-Table -AutoSize; }"
powershell -command "& { Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property TotalVisibleMemorySize | Format-Table -AutoSize; }"
powershell -command "& { Get-CimInstance -ClassName Win32_VideoController | Select-Object -Property AdapterCompatibility, VideoProcessor | Format-Table -AutoSize; }"
powershell -command "& { Get-CimInstance -ClassName Win32_DiskDrive | Select-Object -Property DeviceID, Size, MediaType | Format-Table -AutoSize; }"

pause
exit /b


:EXECUTE_CMD_COMMANDS
echo Executing CMD command(s) with administrative rights...
set /p cmd_input=Enter CMD command(s): 
powershell -Command "& { Start-Process cmd -ArgumentList '/c', '%cmd_input%' -RedirectStandardOutput %TEMP%\output.txt -WindowStyle Hidden -PassThru | Wait-Process; Get-Content %TEMP%\output.txt }"
pause
exit /b

:COMMAND1
echo Running Command 1
REM Put your code for Command 1 here
pause
exit /b

:COMMAND2
echo Running Command 2
REM Put your code for Command 2 here
pause
exit /b

:COMMAND3
echo Running Command 3
REM Put your code for Command 3 here
pause
exit /b

:END
REM End of script
echo Thank you for your time %USERNAME%! See ya!
pause
exit /b
