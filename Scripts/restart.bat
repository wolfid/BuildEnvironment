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
echo ### @brief Restart system...                                          ###
echo ###                                                                   ###
echo ### @param %%1 - Environment setup script                              ###
echo ###                                                                   ###
echo #########################################################################
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :ERROR_BUILD_ENVIRONMENT
:STOP_SYSTEM
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% "%TRMCMD%"
if "%LOGDIR%" equ "" goto :GET_RW_DB
if "%MAPDRV%" equ "" goto :CHECK_LOGS
if exist "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%" goto :GET_LOGS
%MAPDRV%:
md "\%BLDTGT%\%BLDBRA%\%LOGDIR%"
%HOMDRV%:
goto :GET_LOGS
:CHECK_LOGS
if exist "\%BLDTGT%\%BLDBRA%\%LOGDIR%" goto :GET_LOGS
md "\%BLDTGT%\%BLDBRA%\%LOGDIR%"
:GET_LOGS
@echo off
rem echo on
rem "%PCPEXE%" %TGTUSR%@%TGTADR%:/%BLDTGT%/%LOGDIR%/*.log "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%
rem @echo off
:RM_LOGS
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% rm -f /%BLDTGT%/%LOGDIR%/*.log
@echo off
:GET_RW_DB
if "%DBWDIR%/%DBWFIL%" equ "/" goto :GET_TIMED_LOGS
echo on
"%PCPEXE%" %TGTUSR%@%TGTADR%:/%BLDTGT%/%DBWDIR%/%DBWFIL% "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%\%DBWFIL%
"%PLKEXE%" %TGTUSR%@%TGTADR% rm -f /%BLDTGT%/%DBWDIR%/%DBWFIL%
:GET_TIMED_LOGS
@echo off
if "%MOVLOG%" equ "" goto :SET_CONFIG_DB
echo on
"%PCPEXE%" %TGTUSR%@%TGTADR%:/%BLDTGT%/%LOGDIR%/%MOVLOG%/*.log "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%\%MOVLOG%
"%PLKEXE%" %TGTUSR%@%TGTADR% rm -f /%BLDTGT%/%LOGDIR%/%MOVLOG%/*.log
@echo off
:SET_CONFIG_DB
if "%DBSHAN%" equ "" goto :SET_CONFIG_DB_ENTRIES
echo on
"%PCPEXE%" "%DBSHAN%" %TGTUSR%@%TGTADR%:/%BLDTGT%/%DBSDIR%/%DBSFIL%
@echo off
:SET_CONFIG_DB_ENTRIES
if "%SQLMOD1%" equ "" goto :SET_FIRMWARE
set /a MODCNT=1
set DELBEG="\"delete from parameters where module_id=(select id from modules where symbol='
set DELMID=') and tag='
set DELEND=' and paramtype_id='1';\""
set INSBEG="\"insert into parameters (module_id, tag, value, paramtype_id) values ((select id from modules where symbol='
set INSMID='),'
set INSNXT=','
set INSEND=','1');\""
setlocal EnableDelayedExpansion
:SET_CONFIG_DB_ENTRY
set SQLMOD=!SQLMOD%MODCNT%!
set SQLVAL=!SQLVAL%MODCNT%!
set SQLTAG=!SQLTAG%MODCNT%!
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %DELBEG%%SQLMOD%%DELMID%%SQLTAG%%DELEND%
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %INSBEG%%SQLMOD%%INSMID%%SQLTAG%%INSNXT%%SQLVAL%%INSEND%
@echo off
set /a MODCNT+=1
if "!SQLMOD%MODCNT%!" neq "" goto :SET_CONFIG_DB_ENTRY
endlocal
:SET_FIRMWARE
if "%BLDOUT%" equ "" goto :START_SYSTEM
echo on
:BUILD_VERSION
if "%BLDVER:~0,4%" equ "use:" call "%BATDRV%:%BATDIR%\setver.bat" "%MAPDRV%:\%BLDTGT%\%BLDBRA%\src\%BLDVER:~4%"
for /f "tokens=* usebackq" %%a in (`type %TGZDRV%:%TGZDIR%\%BLDVER%\latest.bld`) do set DSTDIR=%%a
"%PCPEXE%" %TGZDRV%:%TGZDIR%\%BLDVER%\%DSTDIR%\%BLDOUT:.tgz=%\%BLDOUT% %TGTUSR%@%TGTADR%:/
"%PLKEXE%" %TGTUSR%@%TGTADR% cd /; tar xzvf /%BLDOUT%
@echo off
:START_SYSTEM
if "%LOGFIL%" neq "" goto :START_SYSTEM_PIPE_OUT
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% "%BEGCMD%"
goto :EOF
:START_SYSTEM_PIPE_OUT
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% touch /%BLDTGT%/%LOGDIR%/%LOGFIL%
"%PLKEXE%" %TGTUSR%@%TGTADR% "%BEGCMD%" > /%BLDTGT%/%LOGDIR%/%LOGFIL% 2>&1 & sleep 2"
"%PLKEXE%" %TGTUSR%@%TGTADR% tail -f /%BLDTGT%/%LOGDIR%/%LOGFIL%
goto :EOF
:ERROR_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
