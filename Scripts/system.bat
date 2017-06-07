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
echo ### @brief Generic system script...                                   ###
echo ###                                                                   ###
echo ### @param %%1 - System function                                       ###
echo ### @param %%2 - Environment setup script                              ###
echo ###                                                                   ###
echo #########################################################################
if [%1] equ [] goto :ERROR_SYSTEM_FUNCTIOM
if [%2] neq [] call %2
if "%BATDRV%%BATDIR%%BLDTGT%" equ "" goto :ERROR_BUILD_ENVIRONMENT
call "%BATDRV%:%BATDIR%\%BLDTGT%\%1.bat"
goto :EOF
:ERROR_SYSTEM_FUNCTIOM
echo ###
echo ###                                                 NO SYSTEM FUNCTION...
echo ###
goto :EOF
:ERROR_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO ENVIRONMENT SETUP...
echo ###
goto :EOF
