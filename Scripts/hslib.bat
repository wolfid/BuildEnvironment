@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Create hslib on new build branch...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 18 Jan 2016
echo ###
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :NOBLDBRA
set BLDDIR=/home/%BLDUSR%/%BLDPRJ%/%BLDTGT%/%BLDBRA%
echo on
"%PLKEXE%" %BLDUSR%@%BLDADR% -pw %BLDPWD% cd %BLDDIR%/hslib/src; sb2 make PLATFORM=%BLDPFM%
"%PLKEXE%" %BLDUSR%@%BLDADR% -pw %BLDPWD% cd %BLDDIR%/DomainLibs/src; sb2 make PLATFORM=%BLDPFM%
"%PLKEXE%" %BLDUSR%@%BLDADR% -pw %BLDPWD% cd %BLDDIR%/%BLDPFM%/usr/lib; ./deletelinks.sh
"%PLKEXE%" %BLDUSR%@%BLDADR% -pw %BLDPWD% cd %BLDDIR%/%BLDPFM%/usr/lib; ./makelinks.sh
goto :EOF
:NOBLDBRA
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
