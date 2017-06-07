@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Upload file...
echo ###
echo ### @param %%1 - File to upload
echo ### @param %%2 - Environment setup script
echo ###
echo ###                                                       WXD 12 Aug 2015
echo ###
if [%1] equ [] goto :ERROR_NO_FILE
if [%2] neq [] call %2
:GET_FILE_NAME
echo on
if "%SCRDIR%" equ "" goto :ERROR_NO_ENV
set SCRDIR=%~1
set SCRDIR=%SCRDIR: =_%
set SCRDIR=%SCRDIR:\=;%
set /a TKNCNT=0 
for %%a in (%SCRDIR%) do set /a TKNCNT+=1 
if [%TKNCNT%] equ [1] goto :NO_FILE_PATH
set SCRDIR=%~1
for /f "tokens=%TKNCNT% delims=\" %%a in ("%SCRDIR%") do set SCRNAM=%%a
goto :UPLOAD_FILE
:NO_FILE_PATH
set SCRNAM=%~1
:UPLOAD_FILE
set SCRDIR=%SCRDIR%
if "%~x1" equ ".lua" set SCRDIR=%BLDTGT%/%DBSDIR%/%LUADIR%
echo on
"%PCPEXE%" %1 %TGTUSR%@%TGTADR%:/%SCRDIR%/%SCRNAM%
goto :EOF
:ERROR_NO_ENV
echo ###
echo ###                                               NO ENVIRONMENT SETUP...
echo ###
goto :EOF
:ERROR_NO_FILE
echo ###
echo ###                                                 No File Specified...
echo ###
goto :EOF
