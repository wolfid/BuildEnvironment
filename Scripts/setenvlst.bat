@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Generate complete tools environment...
echo ###
echo ### @param %%1 - Environment directory - defaults to Target directory\env
echo ### @param %%2 - Target file - defaults to Target directory\bldenv.bat
echo ### @param %%3 - Env file - defaults to Target directory\setenv.lst
echo ### @param %%4 - Batch file header generator - defaults to Target directory\genhdr.bat
echo ### @param %%5 - Target directory - defaults to current directory
echo ###
echo ###                                                       WXD 12 Aug 2015
echo ###
if [%5] neq [] set BLDTGT=%~5
if "%BLDTGT%" neq "" goto :BLDTGT
call :setBLDTGT %0
:BLDTGT
if [%4] neq [] set GENHDR=%~4
if "%GENHDR%" neq "" goto :GENHDR
set GENHDR=%BLDTGT%\genhdr.bat
:GENHDR
if [%3] neq [] set ENVLST=%~3
if "%ENVLST%" neq "" goto :ENVLST
set ENVLST=%BLDTGT%\setenv.lst
:ENVLST
if [%2] neq [] set BNVBAT=%~2
if "%BNVBAT%" neq "" goto :BNVBAT
set BNVBAT=%BLDTGT%\bldenv.bat
:BNVBAT
if [%1] neq [] set ENVDIR=%~1
if "%ENVDIR%" neq "" goto :ENVDIR
set ENVDIR=%BLDTGT%\env
:ENVDIR
if exist "%ENVLST%" goto :GENENV
copy "%ENVLST:lst=def%" "%ENVLST%"
echo ###
echo ### Copied default environment list to %ENVLST%
echo ### - it will most probably need modifying...
echo ###
:GENENV
echo ###
echo ### Generating tools environment...
echo ###
echo on
if not exist "%ENVDIR%" md "%ENVDIR%"
if exist "%GENHDR%" call "%GENHDR%" "%BNVBAT%" "Set Build Environment..."
echo set ENVDIR=%ENVDIR%>> "%BNVBAT%"
for /f "usebackq eol=; tokens=1,2* delims=," %%a in ("%ENVLST%") do if "%%b" equ "[]" (call :genENVLST %%a "%%c") else (call :genENVBAT %%a %%b)
echo set>> "%BNVBAT%"
goto :EOF
:genENVBAT
    echo ### set %1=%~2
    echo set %1="%~2"> "%ENVDIR%\set%1.bat"
    echo set %1=%%%1:^"=%%>> "%ENVDIR%\set%1.bat"
    echo call "%%ENVDIR%%\set%1.bat">> "%BNVBAT%"
    exit /b 0
:genENVLST
    echo ### set %1=%~2
    echo set ENVVAR=%1 1> "%ENVDIR%\set%1.bat"
    echo set ENVVAR=%%ENVVAR: =%%>> "%ENVDIR%\set%1.bat"
    echo set /a ARRDEX=1 1>> "%ENVDIR%\set%1.bat"
    echo call :ARRDEX %2 1>> "%ENVDIR%\set%1.bat"
    echo goto :EOF 1>> "%ENVDIR%\set%1.bat"
    echo :ARRDEX 1>> "%ENVDIR%\set%1.bat"
    echo for /f "tokens=1* delims=," %%%%a in (%%1) do ( 1>> "%ENVDIR%\set%1.bat"
    echo set %%ENVVAR%%[%%ARRDEX%%]=%%%%a 1>> "%ENVDIR%\set%1.bat"
    echo set /a ARRDEX+=1 1>> "%ENVDIR%\set%1.bat"
    echo if "%%%%b" neq "" call :ARRDEX "%%%%b" 1>> "%ENVDIR%\set%1.bat"
    echo ) 1>> "%ENVDIR%\set%1.bat"
    echo exit /b 0 1>> "%ENVDIR%\set%1.bat"
    echo call "%%ENVDIR%%\set%1.bat">> "%BNVBAT%"
    exit /b 0
:setBLDTGT
    set BLDTGT=%1
    set BLDTGT=%BLDTGT:"=%
    set BLDTGT=%BLDTGT: =_%
    set BLDTGT=%BLDTGT:\=;%
    set /a TKNCNT=0 
    for %%a in (%BLDTGT%) do set /a TKNCNT+=1 
    if [%TKNCNT%] equ [1] goto :NOPATH
    set BLDTGT=%1
    for /f "tokens=%TKNCNT% delims=\" %%a in (%BLDTGT%) do set BATNAM=%%a
    call set BLDTGT=%%BLDTGT:\%BATNAM%=%%
    set BLDTGT=%BLDTGT:" =%
    set BLDTGT=%BLDTGT:"=%
    exit /b 0
:NOPATH
    set BLDTGT=.
    set BATNAM=%1
    exit /b 0
