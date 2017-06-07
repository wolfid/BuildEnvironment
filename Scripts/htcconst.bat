@echo off
echo ###                                                      @file %~n0%~x0
echo ###
echo ### @brief Generate HTC code constants...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 11 Dec 2015
echo ###
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :ERROR_NO_ENV
set BLDDIR=/home/%BLDUSR%/%BLDPRJ%/%BLDTGT%/%BLDBRA%
echo on
"%PLKEXE%" %BLDUSR%@%BLDADR% -pw %BLDPWD% cd "%BLDDIR%/src"; ./htcconst.sh ./htcparam.csv ../include/htcconst.hpp
call "%BATDRV%:%BATDIR%\htcconstcs.bat" "%MAPDRV%:\%BLDTGT%\%BLDBRA%\src\htcparam.csv" "%TMPDRV%:%TMPDIR%"
goto :EOF
:ERROR_NO_ENV
echo ###
echo ###                                               NO ENVIRONMENT SETUP...
echo ###
goto :EOF
