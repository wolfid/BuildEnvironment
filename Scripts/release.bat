@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Copy latest HTC binaries to release area...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 18 Jan 2016
echo ###
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :NOBLDBRA
if "%BLDVER:~0,4%" equ "use:" call "%BATDRV%:%BATDIR%\setver.bat" "%MAPDRV%:\%BLDTGT%\%BLDBRA%\src\%BLDVER:~4%"
echo on
for /f "tokens=* usebackq" %%a in (`type %TGZDRV%:%TGZDIR%\%BLDVER%\latest.bld`) do set DSTDIR=%%a
xcopy /S /Y %TGZDRV%:%TGZDIR%\%DSTDIR% %RELDRV%:%RELDIR%\%BLDVER%
goto :EOF
:NOBLDBRA
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
