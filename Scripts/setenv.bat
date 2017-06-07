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
echo ###                                                  @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Generate complete tools environment...                     ###
echo ###                                                                   ###
echo ### @param %%1 - Environment directory                                 ###
echo ### @param %%2 - Script directory                                      ###
echo ### @param %%3 - Script file name                                      ###
echo ### @param %%4 - Batch file header generator                           ###
echo ### @param %%5 - Env file list                                         ###
echo ###                                                                   ###
echo #########################################################################
:SET_SCRIPT_DIRECTORY
set ENVTYP=%5
if "%ENVTYP%" equ "" goto :NO_ENVIRONMENT_LIST
:SET_HEADER_GENERATOR
set GENHDR=%~4
:SET_SCRIPT_NAME
set BNVBAT=%~3
:SET_SCRIPT_DIRECTORY
set SCRDIR=%~2
:SET_ENVIRONMENT_DIRECTORY
set ENVDIR=%~1
:GENERATE_HEADER
echo ###
echo ### Generating header...
echo ###
if not exist "%ENVDIR%" md "%ENVDIR%"
call "%GENHDR%" "%BNVBAT%" "Set Build Environment..."
echo set ENVDIR=%ENVDIR%>> "%BNVBAT%"
:CHECK_ENVIRONMENT_TYPE
if exist "%ENVDIR%\env%ENVTYP%.lst" goto :GENERATE_TOOLS_ENVIRONMENT
if not exist "%SRCDIR%\env%ENVTYP%.def" goto :NEXT_ENVIRONMENT_TYPE
echo ###
echo ### Copying %ENVDEF%\env%ENVTYP%.def to %ENVDIR%\env%ENVTYP%.lst
echo ### - it will almost certainly need modifying...
echo ###
copy "%SCRDIR%\env%ENVTYP%.def" "%ENVDIR%\env%ENVTYP%.lst" > NUL
:GENERATE_TOOLS_ENVIRONMENT
echo ###
echo ### Generating environment from %ENVDIR%\env%ENVTYP%.lst...
echo ###
for /f "usebackq eol=; tokens=1,2 delims=," %%a in ("%ENVDIR%\env%ENVTYP%.lst") do call :GENERATE_SCRIPTS %%a %%b
:GENERATE_CUSTOM_TAIL
if "%ENVTYP%" neq "cst" goto :NEXT_ENVIRONMENT_TYPE
echo ###
echo ### Generating tail for custom variables...
echo ###
echo set /a CSTCNT=1 1>> "%BNVBAT%"
echo goto :CHK_CSTVAR>> "%BNVBAT%"
echo :SET_CSTVAR>> "%BNVBAT%"
echo set CSTVAR=!CSTVAR%%CSTCNT%%!>> "%BNVBAT%"
echo set CSTVAL=!CSTVAL%%CSTCNT%%!>> "%BNVBAT%"
echo endlocal ^& set %%CSTVAR%%=%%CSTVAL%%>> "%BNVBAT%"
echo set /a CSTCNT+=1 1>> "%BNVBAT%"
echo :CHK_CSTVAR>> "%BNVBAT%"
echo setlocal EnableDelayedExpansion>> "%BNVBAT%"
echo if "!CSTVAR%%CSTCNT%%!" neq "" goto :SET_CSTVAR>> "%BNVBAT%"
:NEXT_ENVIRONMENT_TYPE
shift
if "%5" equ "" goto :EOF
set ENVTYP=%5
goto :CHECK_ENVIRONMENT_TYPE
:GENERATE_SCRIPTS
if "%~2" equ "[]" exit /b 0
echo ### set %1=%~2
echo set %1="%~2"> "%ENVDIR%\set%1.bat"
echo set %1=%%%1:^"=%%>> "%ENVDIR%\set%1.bat"
echo call "%%ENVDIR%%\set%1.bat">> "%BNVBAT%"
exit /b 0
:NO_ENVIRONMENT_LIST
echo ###                                                                   ###
echo ###                                               No Environment List ###
echo ###                                                                   ###
goto :EOF
