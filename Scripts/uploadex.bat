@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Upload and execute file ...
echo ###
echo ### @param %%1 - File to upload and execute
echo ### @param %%2 - Environment setup script
echo ###
echo ###                                                       WXD 12 Aug 2015
echo ###
if [%1] equ [] goto :NOSCRIPT
if [%2] neq [] call %2
if "%SCRDIR%" equ "" goto :NOSCRDIR
set BLDTGT=%~1
set BLDTGT=%BLDTGT: =_%
set BLDTGT=%BLDTGT:\=;%
set /a TKNCNT=0 
for %%a in (%BLDTGT%) do set /a TKNCNT+=1 
if [%TKNCNT%] equ [1] goto :NOPATH
set BLDTGT=%~1
for /f "tokens=%TKNCNT% delims=\" %%a in ("%BLDTGT%") do set SCRNAM=%%a
goto :SCRNAM
:NOPATH
set SCRNAM=%~1
:SCRNAM
set BLDTGT=%SCRDIR%
echo on
"%PCPEXE%" %1 %TGTUSR%@%TGTADR%:/%BLDTGT%/%SCRNAM%
"%PLKEXE%" %TGTUSR%@%TGTADR% chmod +x /%BLDTGT%/%SCRNAM%
"%PLKEXE%" %TGTUSR%@%TGTADR% /%BLDTGT%/%SCRNAM%
goto :EOF
:NOSCRDIR
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
:NOSCRIPT
echo ###
echo ###                                                No Script Specified...
echo ###
goto :EOF
