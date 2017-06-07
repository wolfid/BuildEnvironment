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
echo ### @brief Start system...                                            ###
echo ###                                                                   ###
echo ### @param %%1 - Environment setup script                              ###
echo ###                                                                   ###
echo #########################################################################
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :NO_BUILD_ENVIRONMENT
:START
echo on
if "%LOGFIL%" neq "" goto :START_PIPE_OUT
"%PLKEXE%" %TGTUSR%@%TGTADR% %BEGCMD%
goto :EOF
:START_PIPE_OUT
"%PLKEXE%" %TGTUSR%@%TGTADR% touch /%BLDTGT%/%LOGDIR%/%LOGFIL%
"%PLKEXE%" %TGTUSR%@%TGTADR% "%BEGCMD% > /%BLDTGT%/%LOGDIR%/htc.log 2>&1 & sleep 2"
"%PLKEXE%" %TGTUSR%@%TGTADR% tail -f /%BLDTGT%/%LOGDIR%/%LOGFIL%
goto :EOF
:NO_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
