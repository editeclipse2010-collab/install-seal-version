@echo off
cls
color 0f
title seal thing
:LOOP
call "C:\SEAL\mainseal.bat"
color 04
echo Uh oh!
echo.
echo A fatal error has occurred. Press any key to restart the batch program.
pause > nul
goto LOOP
