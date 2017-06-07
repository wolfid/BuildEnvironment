@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Set logging parameters in HTC configuration database...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 11 Dec 2015
echo ###
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :NOBLDBRA
if "%LOGCNT%" equ "" goto :EOF
"%PLKEXE%" %TGTUSR%@%TGTADR% /%BLDTGT%/htcstop.sh
if exist "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%" goto :LOGDIR
%MAPDRV%:
md "\%BLDTGT%\%BLDBRA%\%LOGDIR%"
%TLSDRV%:
:LOGDIR
"%PCPEXE%" %TGTUSR%@%TGTADR%:/%BLDTGT%/%LOGDIR%/*.log "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%
"%PLKEXE%" %TGTUSR%@%TGTADR% rm /%BLDTGT%/%LOGDIR%/*.log
if "%MOVLOG%" equ "" goto :NOMOVLOG
"%PCPEXE%" %TGTUSR%@%TGTADR%:/%BLDTGT%/%LOGDIR%/%MOVLOG%/*.log "%MAPDRV%:\%BLDTGT%\%BLDBRA%\%LOGDIR%\%MOVLOG%
"%PLKEXE%" %TGTUSR%@%TGTADR% rm /%BLDTGT%/%LOGDIR%/%MOVLOG%/*.log
:NOMOVLOG
set SQLBEG="\"UPDATE parameters SET value='
set SQLMID=' WHERE module_id=(SELECT id FROM modules WHERE symbol='
set SQLEND=') AND tag='DEBUG_LEVEL';\""
setlocal EnableDelayedExpansion
set /a MODCNT=1
:MODCNT
set LOGMOD=!LOGMOD[%MODCNT%]!
set LOGVAL=!LOGVAL[%MODCNT%]!
if "%LOGMOD%" equ "" goto :EOF
if "%LOGVAL%" equ "" goto :EOF
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %SQLBEG%%LOGVAL%%SQLMID%%LOGMOD%%SQLEND%
@echo off
if "%LOGCNT%" equ "%MODCNT%" goto :START
set /a MODCNT+=1
goto :MODCNT
:START
if "%LOGFIL%" neq "" goto :LOGFIL
"%PLKEXE%" %TGTUSR%@%TGTADR% /%BLDTGT%/htcstart.sh
goto :EOF
:LOGFIL
"%PLKEXE%" %TGTUSR%@%TGTADR% touch /%BLDTGT%/%LOGDIR%/%LOGFIL%
"%PLKEXE%" %TGTUSR%@%TGTADR% "/%BLDTGT%/htcstart.sh > /%BLDTGT%/%LOGDIR%/htc_out.log 2>&1 & sleep 2"
"%PLKEXE%" %TGTUSR%@%TGTADR% tail -f /%BLDTGT%/%LOGDIR%/%LOGFIL%
goto :EOF
:NOBLDBRA
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
