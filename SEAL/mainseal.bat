mode con: cols=65 lines=25
@echo off
cls
echo loading...
if NOT EXIST "C:\SEAL\seal\SealContainer" (
copy "C:\SEAL\data\SealContainer" "C:\SEAL\seal" >nul 2>&1
)
color 0f
title SEAL
setlocal enabledelayedexpansion
if not exist "c:\SEAL\configs\sealUser.txt" goto :noconfig
if not exist "c:\SEAL\configs\sealPass.txt" goto :noconfig
attrib -h -s "c:\SEAL\configs\sealUser.txt" >nul 2>&1
attrib -h -s "c:\SEAL\configs\sealPass.txt" >nul 2>&1
for /f "usebackq delims=" %%A in ("c:\SEAL\configs\sealUser.txt") do set "username=%%A"
for /f "usebackq delims=" %%A in ("c:\SEAL\configs\sealPass.txt") do set "password=%%A"
attrib +h +s "c:\SEAL\configs\sealUser.txt" >nul 2>&1
attrib +h +s "c:\SEAL\configs\sealPass.txt" >nul 2>&1
cls
echo loaded
echo press any key to continue
pause > nul
goto MAIN

:noconfig
cls
echo No config detected...
echo.
echo Press any key to setup the config.
pause > nul
cls
set /p "input=Username: "
if "!input!"=="" (
set "username=%USERNAME%"
) else (
set "username=!input!"
)
cls
color 0f
set "password"==""
set /p "input=Password: "
if "!input!"=="" (
set "password"==""
) else (
set "password=!input!"
goto config_good
)
:config_good
if not exist "c:\SEAL\configs" mkdir "c:\SEAL\configs"
attrib -h -s "c:\SEAL\configs\sealUser.txt" >nul 2>&1
attrib -h -s "c:\SEAL\configs\sealPass.txt" >nul 2>&1
echo %username%> "c:\SEAL\configs\sealUser.txt"
echo %password%> "c:\SEAL\configs\sealPass.txt"
attrib +h +s "c:\SEAL\configs\sealUser.txt"
attrib +h +s "c:\SEAL\configs\sealPass.txt"
cls
echo Configuration saved!
echo.
echo Username: %username%
echo Password: %password%
pause
goto MAIN

:MAIN
cls
color 0f
echo SEAL by Howisthisnot85
echo.
echo Welcome, %username%.
echo loading ui...
if EXIST "C:\SEAL\seal\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK
if NOT EXIST "C:\SEAL\seal\SealContainer" (
copy "C:\SEAL\data\SealContainer" "C:\SEAL\seal" >nul 2>&1
)

:CONFIRM
cls
echo SEAL by Howisthisnot85
echo.
echo Welcome, %username%.
echo Seal Status: Inactive.
echo.
echo [F] Toggle Seal
echo [G] Open seal in explorer.
choice /c fg /n
if errorlevel 2 (
cls
echo loading file explorer...
explorer "C:\SEAL\seal\"
goto CONFIRM
)
cls
ren "C:\SEAL\seal\SealContainer" "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "C:\SEAL\seal\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
taskkill "explorer"
color 0f
echo SEAL by Howisthisnot85
echo.
echo Welcome, %username%.
echo.
echo Seal activated.
pause
goto UNLOCK

:UNLOCK
color 0f
cls
echo SEAL by Howisthisnot85
echo.
echo Welcome, %username%.
echo Seal Status: Active
echo.
set "pass"==""
set /p "pass=Password: "
if !pass!==!password! (
attrib -h -s "C:\SEAL\seal\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "C:\SEAL\seal\Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" "SealContainer"
goto CONFIRM
)
cls
color 04
echo Uh oh!
echo.
echo Invalid Password. (incorrect)
pause
color 0f
goto UNLOCK
