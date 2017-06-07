@echo off
for /f "tokens=1,2,3 delims=/" %%a in ("%~t0") do (set day=%%a && set /a month=%%b && set year=%%c)
for /f "tokens=%month%" %%a in ("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec") do set month=%%a
echo #########################################################################
echo ###  _     _                                                          ###
echo ### ^| ^|   ^| ^|___ _   ___ ___  ___ _ __  ___                           ###
echo ### ^| ^| _ ^| / _ \ ^| ^| __/ _ \^|__ \ '_ \/ _ \                          ###
echo ### ^| ^|^| ^|^|  (_)  ^|_^| _^|\__^| / _   ^| ^| \__^| ^|                         ###
echo ### ^|___ ___\___/___^|_^| ^|___/\___/_^| ^|_^|___/                          ###
echo ###                ____                                               ###
echo ###               ^|  _ \_   _ _ __  ___  _ ___ _ __                   ###
echo ###               ^| ^| \ \^| ^| ^| '_ \/ __^|^| / _ \ '_ \                  ###
echo ###               ^| ^|_/ /^|_^| ^| ^| ^| \__ /_  (_)  ^| ^| ^|                 ###
echo ###               ^|____/\__'_^|_^| ^|_^|___\__\___/_^| ^|_^|                 ###
echo ###                                                                   ###
echo ### Copyright (c) 2016 Wolfgang Dunsdon.                              ###
echo ### All rights reserved.                                              ###
echo ###                                                                   ###
echo ###                                                       %day%%month% %year:~0,4% ###
echo ###                                                                   ###
echo ###                                                   @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Generate version...                                        ###
echo ###                                                                   ###
echo ### @param %%1 - Environment setup script                              ###
echo ###                                                                   ###
echo #########################################################################
if [%1] neq [] call %1
if "%BLDVER%" equ "" goto :ERROR_BUILD_ENVIRONMENT
if "%BLDVER:~0,4%" neq "use:" goto :TARGET_VERSION
for /f "usebackq eol=/ tokens=1,2,3,4,5" %%a in ("%MAPDRV%:\%BLDTGT%\%BLDBRA%\src\%BLDVER:~4%") do call :GENERATE_VERSION %%a %%b %%c %%d %%e
set BLDVER=%BLDVER:"=%
set BLDVER=%BLDVER:release:=%
:TARGET_VERSION
echo ###
echo ### Target version: %BLDVER%
echo ###
goto :EOF
:ERROR_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO ENVIRONMENT SETUP...
echo ###
goto :EOF
:GENERATE_VERSION
if "%3" equ "APP_MAJOR" (set BLDVER=%4) else (
if "%3" equ "APP_MINOR" (set BLDVER=%BLDVER%_%4) else (
if "%3" equ "APP_RELEASE" (set BLDVER=%BLDVER%_%4) else (
if "%3" equ "APP_QUALIFIER" (set BLDVER=%BLDVER%_%4))))
exit /b 0
