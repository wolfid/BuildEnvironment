@echo off
echo ###########################################################
echo ###      _      __  ___                   __            ###
echo ###     ^| ^| /^| / / / _ \__ _____  ___ ___/ /__  ___     ###
echo ###     ^| ^|/ ^|/ / / // / // / _ \(_-^</ _  / _ \/ _ \    ###
echo ###     ^|__/^|__(_)____/\_,_/_//_/___/\_,_/\___/_//_/    ###
echo ###                                                     ###
echo ###                                          %~nx0 ###
echo ###                                    %~t0 ###
echo ###                                                     ###
echo ### @brief Generate Config HPP from Resource File...    ###
echo ###                                                     ###
echo ### @see %~n0.readme.txt for details.                 ###
echo ###                                                     ###
echo ### @param %%1 - Resource file                           ###
echo ###                                                     ###
echo ###########################################################
if [%1] equ [] goto :ERROR_NO_RC
if [%~x1] neq [.rc] goto :ERROR_NO_RC
set NPPPLUGIN=NppPlugin
set RESOURCE=Resource
set CPPEXTN=cpp
set HPPEXTN=hpp
set SENTINEL=%NPPPLUGIN%%RESOURCE%
call :TOUPPER SENTINEL
set SENTINEL=__%SENTINEL%__
set HPPOUT=%~p1\%NPPPLUGIN%%RESOURCE%.%HPPEXTN%
echo ### ////////////////////////////////////////////////////@file %NPPPLUGIN%%RESOURCE%.%HPPEXTN%
echo ////////////////////////////////////////////////////@file %NPPPLUGIN%%RESOURCE%.%HPPEXTN%> "%HPPOUT%"
echo ### ///
echo ///>> "%HPPOUT%"
echo ### /// Notepad++ Plugin Configuration.
echo /// Notepad++ Plugin Configuration.>> "%HPPOUT%"
echo ### ///
echo ///>> "%HPPOUT%"
echo ### /// Generated by: %~nx0 from %~nx1
echo /// Generated by: %~nx0 from %~nx1>> "%HPPOUT%"
echo ### ///
echo ///>> "%HPPOUT%"
echo ### ///                                                                %date%
echo ///                                                                %date%>> "%HPPOUT%"
echo ### ///
echo ///>> "%HPPOUT%"
echo ### //////////////////////////////////////////////////////////////////////////////
echo //////////////////////////////////////////////////////////////////////////////>> "%HPPOUT%"
echo ### #ifndef %SENTINEL%
echo #ifndef %SENTINEL%>> "%HPPOUT%"
echo ### #define %SENTINEL%
echo #define %SENTINEL%>> "%HPPOUT%"
echo ### #ifndef IDC_STATIC
echo #ifndef IDC_STATIC>> "%HPPOUT%"
echo ### #define IDC_STATIC -1
echo #define IDC_STATIC -1>> "%HPPOUT%"
echo ### #endif
echo #endif>> "%HPPOUT%"
set IDDCNT=1
setlocal EnableDelayedExpansion
for /f "usebackq tokens=1,2,3,4,5,6,7,8,9" %%a in (%1) do call :GENERATE_HPP %%a %%b %%c %%d %%e %%f %%g %%h %%i
endlocal
echo ### #endif
echo #endif>> "%HPPOUT%"
goto :EOF
:GENERATE_HPP
if "%~2" equ "DIALOGEX" goto :DIALOGEX
if "%~1" equ "COMBOBOX" goto :COMBOBOX
if "%~1" equ "LTEXT" goto :LTEXT
if "%~1" equ "DEFPUSHBUTTON" goto :DEFPUSHBUTTON
exit /b 0
:DIALOGEX
set IDDINC=0
set /a IDDCNT+=1
set IDDVAR=%~1
echo ### #define %IDDVAR% %IDDCNT%000
echo #define %IDDVAR% %IDDCNT%000>> "%HPPOUT%"
exit /b
:COMBOBOX
set /a IDDINC+=1
echo ### #define %2 (%IDDVAR% + %IDDINC%)
echo #define %2 (%IDDVAR% + %IDDINC%)>> "%HPPOUT%"
exit /b
:LTEXT
set /a IDDINC+=1
echo ### #define %3 (%IDDVAR% + %IDDINC%)
echo #define %3 (%IDDVAR% + %IDDINC%)>> "%HPPOUT%"
exit /b
:DEFPUSHBUTTON
if "%3" equ "IDCANCEL" exit /b
if "%3" equ "IDOK" exit /b
set /a IDDINC+=1
echo ### #define %3 (%IDDVAR% + %IDDINC%)
echo #define %3 (%IDDVAR% + %IDDINC%)>> "%HPPOUT%"
exit /b
:TOUPPER
for %%i in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") do call set "%~1=%%%~1:%%~i%%"
exit /b
:ERROR_NO_RC
echo ###
echo ###                                                   No Resource File...
echo ###
goto :EOF
