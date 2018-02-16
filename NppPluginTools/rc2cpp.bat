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
echo ### @brief Generate Config CPP from Resource File...    ###
echo ###                                                     ###
echo ### @see %~n0.readme.txt for details.                 ###
echo ###                                                     ###
echo ### @param %%1 - Resource file                           ###
echo ###                                                     ###
echo ###########################################################
if [%1] equ [] goto :ERROR_NO_RC
if [%~x1] neq [.rc] goto :ERROR_NO_RC
set CYGRES=%~d1
for %%a in ("A:=a" "B:=b" "C:=c" "D:=d" "E:=e" "F:=f" "G:=g" "H:=h" "I:=i" "J:=j" "K:=k" "L:=l" "M:=m" "N:=n" "O:=o" "P:=p" "Q:=q" "R:=r" "S:=s" "T:=t" "U:=u" "V:=v" "W:=w" "X:=x" "Y:=y" "Z:=z") do call set CYGRES=%%CYGRES:%%~a%%
set CYGRES="/cygdrive/%CYGRES%%~p1%~n1%~x1"
set CYGRES=%CYGRES:\=/%
set RCFILE=%~1
set RCTEMP=%RCFILE:.rc=.tmp%
echo ### cygwin path of %1
echo ### is %CYGRES%
echo ###
C:\cygwin64\bin\grep -E "CAPTION ""|COMBOBOX" %CYGRES% > "%RCTEMP%"
set IDDCNT=0
setlocal EnableDelayedExpansion
set CPPOUT=%RCFILE:.rc=.cpp%
for /f "tokens=1,2,3 delims=/" %%a in ("%date:/0=/%") do (set day=%%a && set /a month=%%b && set year=%%c)
if "%month:~0,1%"=="0" set month=%month:~1,1%
for /f "tokens=%month%" %%a in ("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec") do set month=%%a
echo ### ///////////////////////////////////@file %~n1.cpp
echo ///////////////////////////////////@file %~n1.cpp> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### /// Notepad++ Tools Environment Configuration.
echo /// Notepad++ Tools Environment Configuration.>> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### /// Generated by: %~nx0 from %~nx1
echo /// Generated by: %~nx0 from %~nx1>> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### ///                                                                %day%%month% %year%
echo ///                                                                %day%%month% %year%>> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### //////////////////////////////////////////////////////////////////////////////
echo //////////////////////////////////////////////////////////////////////////////>> "%CPPOUT%"
echo ### #include "%~n1.hpp"
echo #include "%~n1.hpp" >> "%CPPOUT%"
echo ### #include "SettingsDlg.h"
echo #include "SettingsDlg.h" >> "%CPPOUT%"
set RCFILE=%~n1
set RCFILE=%RCFILE:NppPlugin="%
set RCFILE=%RCFILE:Resource="%
echo ### const TCHAR NPP_PLUGIN_NAME[] = TEXT(%RCFILE:Environment= Environment%);
echo const TCHAR NPP_PLUGIN_NAME[] = TEXT(%RCFILE:Environment= Environment%); >> "%CPPOUT%"
for /f "usebackq tokens=1,2,3,4,5,6,7,8,9" %%a in ("%RCTEMP%") do call :GENERATE_CPP %%a %%b %%c %%d %%e %%f %%g %%h %%i
echo ###    { -1, -1, -1, NULL, NULL, NULL }
echo     { -1, -1, -1, NULL, NULL, NULL }>> "%CPPOUT%"
echo ### };
echo }; >> "%CPPOUT%"
echo ### const int nbFunc = %IDDCNT%;
echo const int nbFunc = %IDDCNT%; >> "%CPPOUT%"
echo ### FuncItem funcItem[nbFunc];
echo FuncItem funcItem[nbFunc]; >> "%CPPOUT%"
echo ### ENVSET envsetlst[] =
echo ENVSET envsetlst[] = >> "%CPPOUT%"
echo ### {
echo { >> "%CPPOUT%"
set IDDINC=0
:IDDCNT
set IDDVAR=!IDDVAR[%IDDINC%]!
set IDDVAR=%IDDVAR: =_%
set IDDVAR=%IDDVAR:"=%
echo ###    { TEXT(!IDDVAR[%IDDINC%]!), SettingsDlg(IDD_%IDDVAR%, ENVVAR_%IDDVAR%) },
echo     { TEXT(!IDDVAR[%IDDINC%]!), SettingsDlg(IDD_%IDDVAR%, ENVVAR_%IDDVAR%) }, >> "%CPPOUT%"
set /a IDDINC+=1
if "%IDDINC%" neq "%IDDCNT%" goto :IDDCNT
echo ### };
echo }; >> "%CPPOUT%"
goto :EOF
:GENERATE_CPP
    if "%1" equ "CAPTION" goto :CAPTION
    if "%1" equ "COMBOBOX" goto :COMBOBOX
    exit /b 0
:CAPTION
    set IDDVAR[%IDDCNT%]=%2
    if "%IDDCNT%" equ "0" goto :CAPTION1
    echo ###    { -1, -1, -1, NULL, NULL, NULL }
    echo     { -1, -1, -1, NULL, NULL, NULL }>> "%CPPOUT%"
    echo ### };
    echo }; >> "%CPPOUT%"
:CAPTION1
    set IDDVAR=!IDDVAR[%IDDCNT%]!
    set IDDVAR=%IDDVAR: =_%
    set IDDVAR=%IDDVAR:"=%
    echo ### ENVVAR ENVVAR_%IDDVAR%[] =
    echo ENVVAR ENVVAR_%IDDVAR%[] =>> "%CPPOUT%"
    echo ### {
    echo { >> "%CPPOUT%"
    set /a IDDCNT+=1
    set ENVVAR=""
    exit /b
:COMBOBOX
    echo %1 %2 %3 %4 %5 %6 %7 %8 %9
    set ENVVAR=%2
    if "%ENVVAR:~10,1%" equ "C" goto :CBOX
    if "%ENVVAR:~10,1%" equ "D" goto :DBOX
    if "%ENVVAR:~10,1%" equ "F" goto :FBOX
    exit /b
:CBOX
    echo ###    { %ENVVAR%, -1, -1, "%ENVVAR:~3,6%", NULL, NULL },
    echo     { %ENVVAR%, -1, -1, "%ENVVAR:~3,6%", NULL, NULL },>> "%CPPOUT%"
    exit /b
:DBOX
    echo ###    { %ENVVAR%, -1, %ENVVAR:DBOX=BTTN%, "%ENVVAR:~3,6%", NULL, "%ENVVAR:~3,3%DRV" },
    echo     { %ENVVAR%, %ENVVAR:DBOX=BTTN%, -1, "%ENVVAR:~3,6%", NULL, "%ENVVAR:~3,3%DRV" },>> "%CPPOUT%"
    exit /b
:FBOX
    echo ###    { %ENVVAR%, %ENVVAR:FBOX=BTTN%, -1, "%ENVVAR:~3,6%", NULL, NULL },
    echo     { %ENVVAR%, -1, %ENVVAR:FBOX=BTTN%, "%ENVVAR:~3,6%", NULL, NULL },>> "%CPPOUT%"
    exit /b
:ERROR_NO_RC
echo ###
echo ###                                                   No Resource File...
echo ###
goto :EOF
