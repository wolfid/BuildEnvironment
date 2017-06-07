@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Set Host IP Address...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 12 Aug 2015
echo ###
if [%1] neq [] call %1
if "%LOCADR%" equ "" goto :NOLOCADR
echo ###
echo ###                                        Setting host IP to %LOCADR%...
echo ###
echo on
netsh interface ip set address "%LOCCON%" static %LOCADR% 255.255.255.0 %LOCGAT%
goto :EOF
:NOLOCADR
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
pause