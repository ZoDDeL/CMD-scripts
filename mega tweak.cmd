setlocal
reg query HKEY_USERS\S-1-5-20 1>nul 2>nul && goto GotPrivileges_1
If "%ElevError%"=="Y" goto Elev_Err_1
set "args="%~f0" %*" & call set "args=%%args:"=\"%%"
echo Initializing...
powershell -c "start cmd -ArgumentList '/c set ElevError=Y& call %args%' -verb runas" && exit /b

:Elev_Err_1
%ErrLine%
echo Right click on this file and select 'Run as administrator'
pause >nul
exit /b


:GotPrivileges_1
endlocal

@echo off & goto MainMenu

::========================================================================================================================================

:MainMenu

cls
title Mega Tweak by ZoDDeL
mode con cols=98 lines=22

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|      [1] Activate Windows (requires internet)                 ^|
echo                  ^|                                                               ^|
echo                  ^|      [2] CTT winUtil (requires internet)                      ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] TdrDelay + TdrDiDelay fix for GPU                    ^|
echo                  ^|                                                               ^|
echo                  ^|      [4] FastShutdown                                         ^|
echo                  ^|                                                               ^|
echo                  ^|      [5] SuperDNS Changer                                     ^|
echo                  ^|                                                               ^|
echo                  ^|      [6] Windows Defender Scheduler                           ^|
echo                  ^|                                                               ^|
echo                  ^|      [7] Windows Update Stuff                                 ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:1234567 /N /M ".                   Enter Your Choice [1,2,3,4,5,6,7] : "


if errorlevel  7 goto:WinUpdateStuffMenu
if errorlevel  6 goto:DefenderScheduleMenu
if errorlevel  5 goto:SuperDNSMenu
if errorlevel  4 goto:FastShutdownMenu
if errorlevel  3 goto:TdrMenu
if errorlevel  2 goto:CTTwinUtilMenu
if errorlevel  1 goto:ActivateWindowsMenu


::========================================================================================================================================

:ActivateWindowsMenu
setlocal
mode con cols=98 lines=26
powershell -c "irm https://get.activated.win | iex"

cls
endlocal
goto MainMenu


::========================================================================================================================================

:CTTwinUtilMenu
setlocal
mode con cols=98 lines=26
powershell -c "irm https://christitus.com/win | iex"

cls
endlocal
goto MainMenu


::========================================================================================================================================

:WinUpdateStuffMenu

cls
title Windows Update Stuff
mode con cols=98 lines=17

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Windows Update OnDemand                              ^|
echo                  ^|                                                               ^|
echo                  ^|      [2] Windows Update Notification Setting                  ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|                                                               ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:120 /N /M ".                   Enter Your Choice [1,2,0] : "

if errorlevel  3 goto:MainMenu
if errorlevel  2 goto:WinUpdateNotifyMenu
if errorlevel  1 goto:WinUpdateMenu


::========================================================================================================================================

:WinUpdateMenu

cls
title Windows Update OnDemand by ZoDDeL
mode con cols=98 lines=17

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Check Update Settings                                ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] Set Update Setting to OnDemand                       ^|
echo                  ^|                                                               ^|
echo                  ^|      [5] Disable OnDemand Updates                             ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:1350 /N /M ".                   Enter Your Choice [1,3,5,0] : "

if errorlevel  4 goto:MainMenu
if errorlevel  3 goto:WinUpdateDISABLE
if errorlevel  2 goto:WinUpdateSET
if errorlevel  1 goto:WinUpdateCHECK

::========================================================================================================================================

:WinUpdateCHECK
setlocal
mode con cols=98 lines=6
reg query HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU

echo press any key to go back to menu
pause >nul
cls
endlocal
goto WinUpdateMenu


:WinUpdateSET
setlocal
mode con cols=98 lines=4

reg add HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v AUOptions /t REG_DWORD /d 2 /f

echo press any key to go back to menu
pause >nul
cls
endlocal
goto WinUpdateMenu


:WinUpdateDISABLE
setlocal
mode con cols=98 lines=4

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /f

echo press any key to go back to menu
pause >nul
cls
endlocal
goto WinUpdateMenu


::========================================================================================================================================

:WinUpdateNotifyMenu

cls
title Windows Update Notification by ZoDDeL
mode con cols=98 lines=17

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Check Update Notification Settings                   ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] Disable Update Notification                          ^|
echo                  ^|                                                               ^|
echo                  ^|      [5] Reset Default Update Notification                    ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:1350 /N /M ".                   Enter Your Choice [1,3,5,0] : "

if errorlevel  4 goto:MainMenu
if errorlevel  3 goto:WinUpdateNotifyDISABLE
if errorlevel  2 goto:WinUpdateNotifySET
if errorlevel  1 goto:WinUpdateNotifyCHECK

::========================================================================================================================================

:WinUpdateNotifyCHECK
setlocal
mode con cols=98 lines=12
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetUpdateNotificationLevel
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v UpdateNotificationLevel

echo press any key to go back to menu
pause >nul
cls
endlocal
goto WinUpdateNotifyMenu


:WinUpdateNotifySET
setlocal
mode con cols=98 lines=4

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetUpdateNotificationLevel /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v UpdateNotificationLevel /t REG_DWORD /d 1 /f

echo press any key to go back to menu
pause >nul
cls
endlocal
goto WinUpdateNotifyMenu


:WinUpdateNotifyDISABLE
setlocal
mode con cols=98 lines=4

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v SetUpdateNotificationLevel /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v UpdateNotificationLevel /t REG_DWORD /d 0 /f

echo press any key to go back to menu
pause >nul
cls
endlocal
goto WinUpdateNotifyMenu


::========================================================================================================================================

:TdrMenu

cls
title TDR fix for GPU by ZoDDeL
mode con cols=98 lines=17

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Check TdrDelay + TdrDdiDelay                         ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] Set TdrDelay + TdrDdiDelay to 30sec (default 2-5sec) ^|
echo                  ^|                                                               ^|
echo                  ^|      [5] Disable(Delete) TdrDelay + TdrDdiDelay               ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:1350 /N /M ".                   Enter Your Choice [1,3,5,0] : "

if errorlevel  4 goto:MainMenu
if errorlevel  3 goto:TdrDISABLE
if errorlevel  2 goto:TdrSET
if errorlevel  1 goto:TdrCHECK

::========================================================================================================================================



:TdrSET
setlocal
mode con cols=98 lines=4

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers /v TdrDelay /t REG_DWORD /d 30 /f
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers /v TdrDdiDelay /t REG_DWORD /d 30 /f

echo press any key to go back to menu
pause >nul
cls
endlocal
goto TdrMenu


:TdrCHECK
setlocal
mode con cols=98 lines=9

reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers /v TdrDelay
reg query HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers /v TdrDdiDelay

echo press any key to go back to menu
pause >nul
cls
endlocal
goto TdrMenu


:TdrDISABLE
setlocal
mode con cols=98 lines=4

reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers /v TdrDelay /f
reg delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers /v TdrDdiDelay /f

echo press any key to go back to menu
pause >nul
cls
endlocal
goto TdrMenu


::========================================================================================================================================

:FastShutdownMenu

cls
title FastShutdown by ZoDDeL
mode con cols=98 lines=18

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Check FastShutdown                                   ^|
echo                  ^|                                                               ^|
echo                  ^|      [2] Set FastShutdown                                     ^|
echo                  ^|                                                               ^|
echo                  ^|      WARNING                                                  ^|
echo                  ^|      NO RESET POSSIBLE!!!                                     ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:120 /N /M ".                   Enter Your Choice [1,2,0] : "

if errorlevel  3 goto:MainMenu
if errorlevel  2 goto:FastShutdownSET
if errorlevel  1 goto:FastShutdownCHECK

::========================================================================================================================================

:FastShutdownCHECK
setlocal
mode con cols=98 lines=22
@echo off
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeOut
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks

echo press any key to go back to menu
pause >nul
cls
endlocal
goto FastShutdownMenu


:FastShutdownSET
setlocal
mode con cols=98 lines=22
@echo off
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /f /v WaitToKillServiceTimeout /t REG_SZ /d 1000
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control" /v WaitToKillServiceTimeout

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v WaitToKillAppTimeOut /t REG_SZ /d 1000
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v WaitToKillAppTimeOut

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v HungAppTimeout /t REG_SZ /d 1000
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v HungAppTimeout

reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /f /v AutoEndTasks /t REG_SZ /d 1
reg query "HKEY_CURRENT_USER\Control Panel\Desktop" /v AutoEndTasks

echo press any key to go back to menu
pause >nul
cls
endlocal
goto FastShutdownMenu

::========================================================================================================================================

:SuperDNSMenu

cls
title Super DNS Changer by ZoDDeL
mode con cols=98 lines=33

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Set Google DNS (ipv4+ipv6 all interfaces)            ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      ipv4:                                                    ^|
echo                  ^|      primary 8.8.8.8(google)                                  ^|
echo                  ^|                                                               ^|
echo                  ^|      ipv6:                                                    ^|
echo                  ^|      primary 2001:4860:4860:0:0:0:0:8888(google)              ^|
echo                  ^|                                                               ^|
echo                  ^|                                                               ^|
echo                  ^|      [2] Set Cloudflare DNS (ipv4+ipv6 all interfaces)        ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      ipv4:                                                    ^|
echo                  ^|      primary 1.1.1.1(cloudflare)                              ^|
echo                  ^|                                                               ^|
echo                  ^|      ipv6:                                                    ^|
echo                  ^|      primary 2606:4700:4700::1111(cloudflare)                 ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] Delete Custom DNS (resets to automatic ISP DNS)      ^|
echo                  ^|                                                               ^|
echo                  ^|                                                               ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|      [7] Exit                                                 ^|
echo                  ^|                                                               ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:1230 /N /M ".                   Enter Your Choice [1,2,3,0] : "

if errorlevel  4 goto:MainMenu
if errorlevel  3 goto:SuperDNSDISABLE
if errorlevel  2 goto:SuperDNSSETCLOUDFLARE
if errorlevel  1 goto:SuperDNSSETGOOGLE

::========================================================================================================================================



:SuperDNSSETGOOGLE
setlocal
mode con cols=100 lines=50

powershell "foreach ($c in Get-NetAdapter) { write-host 'Setting DNS for' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ServerAddresses ('8.8.8.8') }"

powershell "foreach ($c in Get-NetAdapter) { write-host 'Setting DNS for' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ServerAddresses ('2001:4860:4860:0000:0000:0000:0000:8888') }"

netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns

echo press any key to go back to menu
pause >nul
cls
endlocal
goto SuperDNSMenu


:SuperDNSSETCLOUDFLARE
setlocal
mode con cols=100 lines=50

powershell "foreach ($c in Get-NetAdapter) { write-host 'Setting DNS for' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ServerAddresses ('1.1.1.1') }"

powershell "foreach ($c in Get-NetAdapter) { write-host 'Setting DNS for' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ServerAddresses ('2606:4700:4700:0000:0000:0000:0000:1111') }"

netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns

echo press any key to go back to menu
pause >nul
cls
endlocal
goto SuperDNSMenu



:SuperDNSDISABLE
setlocal
mode con cols=100 lines=50

powershell "foreach ($c in Get-NetAdapter) { write-host 'Setting DNS for' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ResetServerAddresses }"

powershell "foreach ($c in Get-NetAdapter) { write-host 'Setting DNS for' $c.interfaceName ; Set-DnsClientServerAddress -InterfaceIndex $c.interfaceindex -ResetServerAddresses }"

netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns

echo press any key to go back to menu
pause >nul
cls
endlocal
goto SuperDNSMenu


::========================================================================================================================================

:DefenderScheduleMenu

cls
title Windows Defender Scheduler by ZoDDeL
mode con cols=98 lines=17

echo.
echo.
echo                   _______________________________________________________________
echo                  ^|                                                               ^| 
echo                  ^|                                                               ^|
echo                  ^|      [1] Check Defender Scheduler State                       ^|
echo                  ^|                                                               ^|
echo                  ^|      [3] Disable Defender Scheduler                           ^|
echo                  ^|                                                               ^|
echo                  ^|      [5] Enable Defender Scheduler                            ^|
echo                  ^|      ___________________________________________________      ^|
echo                  ^|                                                               ^|
echo                  ^|      [0] Return to Main Menu                                  ^|
echo                  ^|_______________________________________________________________^|
echo.          
choice /C:1350 /N /M ".                   Enter Your Choice [1,3,5,0] : "

if errorlevel  4 goto:MainMenu
if errorlevel  3 goto:DefenderScheduleENABLE
if errorlevel  2 goto:DefenderScheduleDISABLE
if errorlevel  1 goto:DefenderScheduleCHECK

::========================================================================================================================================

:DefenderScheduleCHECK
setlocal
mode con cols=98 lines=24
SCHTASKS /QUERY /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
SCHTASKS /QUERY /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
SCHTASKS /QUERY /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
SCHTASKS /QUERY /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification"

echo press any key to go back to menu
pause >nul
cls
endlocal
goto DefenderScheduleMenu


:DefenderScheduleDISABLE
setlocal
mode con cols=140 lines=8

SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /DISABLE
SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /DISABLE
SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /DISABLE
SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /DISABLE

echo press any key to go back to menu
pause >nul
cls
endlocal
goto DefenderScheduleMenu


:DefenderScheduleENABLE
setlocal
mode con cols=140 lines=8

SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /ENABLE
SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /ENABLE
SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /ENABLE
SCHTASKS /CHANGE /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /ENABLE

echo press any key to go back to menu
pause >nul
cls
endlocal
goto DefenderScheduleMenu


:EXIT
exit /b
