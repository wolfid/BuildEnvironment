@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Generate version...
echo ###
echo ### @param %%1 - Version template file
echo ###
echo ###                                                       WXD 18 Jan 2016
echo ###
if [%1] equ [] goto :ERROR_VERSION_TEMPLATE
for /f "usebackq eol=/ tokens=1,2,3,4,5" %%a in (%1) do call :GENERATE_VERSION %%a %%b %%c %%d %%e
set BLDVER=%BLDVER:"=%
set BLDVER=%BLDVER:release:=%
echo ###
echo ### Target version: %BLDVER%
echo ###
goto :EOF
:ERROR_VERSION_TEMPLATE
echo ###
echo ###                                                NO VERSION TEMPLATE...
echo ###
goto :EOF
:GENERATE_VERSION
if "%3" equ "APP_MAJOR" (set BLDVER=%4) else (
if "%3" equ "APP_MINOR" (set BLDVER=%BLDVER%_%4) else (
if "%3" equ "APP_RELEASE" (set BLDVER=%BLDVER%_%4) else (
if "%3" equ "APP_QUALIFIER" (set BLDVER=%BLDVER%_%4))))
exit /b 0
