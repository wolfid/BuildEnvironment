@echo off
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
echo ###                                                       25 Apr 2016 ###
echo ###                                                                   ###
echo ###                                                   @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Build system...                                            ###
echo ###                                                                   ###
echo ### @param %%1 - Environment setup script                              ###
echo ###                                                                   ###
echo #########################################################################
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :ERROR_BUILD_ENVIRONMENT
set REDOUT="%TMPDRV%:%TMPDIR%\red.out"
set BLDDIR=/home/%BLDUSR%/%BLDPRJ%/%BLDTGT%/%BLDBRA%
:SYNC_SOURCE
if not exist "%FFSDRV%:%FFSDIR%\SyncSettings.%BLDBRA%.ffs_batch" goto :BUILD_TARGET
"%FFSEXE%" "%FFSDRV%:%FFSDIR%\SyncSettings.%BLDBRA%.ffs_batch"
:BUILD_TARGET
if exist %MAPDRV%:\%BLDTGT%\%BLDBRA%\docker\Makefile goto :BUILD_DOCKER
:COMPILE
echo on
"%PLKEXE%" -t %BLDUSR%@%BLDADR% -pw %BLDPWD% cd "%BLDDIR%/src"; sb2 make PLATFORM=%BLDPFM% > %REDOUT% 2>&1
@echo off
if %ERRORLEVEL% neq 0 goto :ERROR_COMPILE
type %REDOUT%
echo on
"%PLKEXE%" -t %BLDUSR%@%BLDADR% -pw %BLDPWD% cd "%BLDDIR%/src"; make dist > %REDOUT% 2>&1
@echo off
goto :BUILD_CHECK
:BUILD_DOCKER
echo on
"%PLKEXE%" %BLDUSR%@%BLDADR% -pw %BLDPWD% cd %BLDDIR%; make -C docker %BLDPFM% > %REDOUT% 2>&1
@echo off
:BUILD_CHECK
if %ERRORLEVEL% neq 0 goto :ERROR_BUILD_DISTRIBUTION
type %REDOUT%
set CYGOUT="\cygdrive\%REDOUT:"=%"
set CYGOUT=%CYGOUT:\=/%
for %%i in ("A:=a" "B:=b" "C:=c" "D:=d" "E:=e" "F:=f" "G:=g" "H:=h" "I:=i" "J:=j" "K:=k" "L:=l" "M:=m" "N:=n" "O:=o" "P:=p" "Q:=q" "R:=r" "S:=s" "T:=t" "U:=u" "V:=v" "W:=w" "X:=x" "Y:=y" "Z:=z") do call set CYGOUT=%%CYGOUT:%%~i%%
for /f "tokens=3" %%a in ('%CYGDRV%:%CYGDIR%\bin\grep -m 1 "mkdir -p ../%BLDPFM%/%BLDTGT%_" %CYGOUT%') do set DSTDIR=%%a
set DSTDIR=%DSTDIR:../=%
set DSTDIR=%DSTDIR:/=\%
echo on
if "%TGZDIR%\%TGTFIL%" equ "\" goto :EOF
@echo off
:BUILD_VERSION
if "%BLDVER:~0,4%" equ "use:" call "%BATDRV%:%BATDIR%\setver.bat" "%MAPDRV%:\%BLDTGT%\%BLDBRA%\src\%BLDVER:~4%"
%TGZDRV%:
if exist "%TGZDRV%:%TGZDIR%\%BLDVER%" goto :BUILD_SAVE
md "%TGZDIR%\%BLDVER%"
:BUILD_SAVE
md "%TGZDIR%\%BLDVER%\%DSTDIR%"
%HOMDRV%:
echo on
xcopy /S /Y %MAPDRV%:\%BLDTGT%\%BLDBRA%\%DSTDIR% %TGZDRV%:%TGZDIR%\%BLDVER%\%DSTDIR%
echo %DSTDIR%>%TGZDRV%:%TGZDIR%\%BLDVER%\latest.bld
goto :EOF
:ERROR_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO ENVIRONMENT SETUP...
echo ###
goto :EOF
:ERROR_COMPILE
echo ###
echo ###                                                      Compile Error...
echo ###
type %REDOUT%
goto :EOF
:ERROR_BUILD_DISTRIBUTION
echo ###
echo ###                                                         Dist Error...
echo ###
type %REDOUT%
goto :EOF
