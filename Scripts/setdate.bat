@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Set Linux target date and time...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 30 Oct 2015
echo ###
if [%1] neq [] call %1
if "%TGTADR%" equ "" goto :NOTGTADR
set /a VARCNT=1
setlocal EnableDelayedExpansion
:SET_MISC_ENTRY
if "!MSCVAR%VARCNT%!" equ "" goto :GET_DATE
set !MSCVAR%VARCNT%!=!MSCVAL%VARCNT%!
set /a VARCNT+=1
goto :SET_MISC_ENTRY
:GET_DATE
for /f "tokens=1,2,3 delims=/" %%a in ("%date%") do (set day=%%a && set month=%%b && set year=%%c)
for /f "tokens=1,2 delims=:" %%a in ("%time%") do (set hour=%%a && set /a min=%%b)
set year=%year: =%
set month=%month: =%
set day=%day: =%
set hour=%hour: =%
set min=%min: =%
if %min% lss 10 set min=0%min%
if %hour% lss 10 set hour=0%hour%
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% cp /usr/share/zoneinfo/%LTZCON%/%LTZCIT% /etc/localtime
"%PLKEXE%" %TGTUSR%@%TGTADR% date %month%%day%%hour%%min%%year%
"%PLKEXE%" %TGTUSR%@%TGTADR% hwclock --systohc
goto :EOF
:NOTGTADR
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
