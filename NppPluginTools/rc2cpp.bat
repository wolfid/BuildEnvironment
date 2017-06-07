@echo off
for /f "tokens=1,2,3 delims=/" %%a in ("%~t0") do (set day=%%a && set /a month=%%b && set year=%%c)
for /f "tokens=%month%" %%a in ("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec") do set month=%%a
echo #########################################################################
echo ###  _     _                                                          ###
echo ### ^| ^|   ^| ^|___ _   ___ ___  ___ _ __  ___                           ###
echo ### ^| ^| _ ^| / _ \ ^| ^| __/ _ \^|__ \ '_ \/ _ \                          ###
echo ### ^| ^|^| ^|^|  (_)  ^|_^| _^|\__^| / _   ^| ^| \__^| ^|                         ###
echo ### ^|___ ___\___/___^|_^| ^|___/\___/_^| ^|_^|___/                          ###
echo ###                ____                                               ###
echo ###               ^|  _ \_   _ _ __  ___  _ ___ _ __                   ###
echo ###               ^| ^| \ \^| ^| ^| '_ \/ __^|^| / _ \ '_ \                  ###
echo ###               ^| ^|_/ /^|_^| ^| ^| ^| \__ /_  (_)  ^| ^| ^|                 ###
echo ###               ^|____/\__'_^|_^| ^|_^|___\__\___/_^| ^|_^|                 ###
echo ###                                                                   ###
echo ### Copyright (c) %year:~0,4% Wolfgang Dunsdon.                              ###
echo ### All rights reserved.                                              ###
echo ###                                                                   ###
echo ###                                                       %day%%month% %year:~0,4% ###
echo ###                                                                   ###
echo ###                                                  @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Generate config source from resource File...               ###
echo ###                                                                   ###
echo ### @see %~n0.readme.txt for details.                               ###
echo ###                                                                   ###
echo ### @param %%1 - Resource file                                         ###
echo ###                                                                   ###
echo #########################################################################
if [%1] equ [] goto :ERROR_NO_RC
if [%~x1] neq [.rc] goto :ERROR_NO_RC
set RCFILE=%~n1
set CPPOUT=%1
set CPPOUT=%CPPOUT:.rc=.cpp%
for /f "tokens=1,2,3 delims=/" %%a in ("%date:/0=/%") do (set day=%%a && set /a month=%%b && set year=%%c)
for /f "tokens=%month%" %%a in ("Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec") do set month=%%a
echo ### ///////////////////////////////////@file %RCFILE%.cpp
echo ///////////////////////////////////@file %RCFILE%.cpp> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### /// Notepad++ Tools Environment Configuration.
echo /// Notepad++ Tools Environment Configuration.>> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### /// Generated by: %~n0%~x0 from %~n1%~x1
echo /// Generated by: %~n0%~x0 from %~n1%~x1>> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### ///                                                                %day%%month% %year%
echo ///                                                                %day%%month% %year%>> "%CPPOUT%"
echo ### ///
echo ///>> "%CPPOUT%"
echo ### //////////////////////////////////////////////////////////////////////////////
echo //////////////////////////////////////////////////////////////////////////////>> "%CPPOUT%"
echo ### #include "%RCFILE%.hpp"
echo #include "%RCFILE%.hpp">> "%CPPOUT%"
set RCFILE=%RCFILE:Resource=%
echo ### #include "SettingsDlg.h"
echo #include "SettingsDlg.h">> "%CPPOUT%"
set RCFILE=%RCFILE:NppPlugin=%
set RCFILE=%RCFILE:Environment= Environment%
echo ### const TCHAR NPP_PLUGIN_NAME[] = TEXT("%RCFILE%");
echo const TCHAR NPP_PLUGIN_NAME[] = TEXT("%RCFILE%");>> "%CPPOUT%"
set IDDCNT=0
setlocal EnableDelayedExpansion
for /f "usebackq tokens=1,2,3,4,5*" %%a in (%1) do call :GENERATE_CPP %%a %%b %%c %%d %%e %%f
echo ###    { -1, -1, -1, NULL, NULL, NULL }
echo     { -1, -1, -1, NULL, NULL, NULL }>> "%CPPOUT%"
echo ### };
echo };>> "%CPPOUT%"
echo ### const int nbFunc = %IDDCNT%;
echo const int nbFunc = %IDDCNT%;>> "%CPPOUT%"
echo ### FuncItem funcItem[nbFunc];
echo FuncItem funcItem[nbFunc];>> "%CPPOUT%"
echo ### ENVSET envsetlst[] =
echo ENVSET envsetlst[] =>> "%CPPOUT%"
echo ### {
echo {>> "%CPPOUT%"
if "%IDDCNT%" equ "0" goto :END
set IDDINC=0
:IDDCNT
echo ###    { TEXT(!IDDSTR[%IDDINC%]!), SettingsDlg(!IDDVAR[%IDDINC%]!, ENVAR_!IDDVAR[%IDDINC%]!) },
echo     { TEXT(!IDDSTR[%IDDINC%]!), SettingsDlg(!IDDVAR[%IDDINC%]!, ENVAR_!IDDVAR[%IDDINC%]!) },>> "%CPPOUT%"
set /a IDDINC+=1
if "%IDDINC%" neq "%IDDCNT%" goto :IDDCNT
:END
echo ### };
echo };>> "%CPPOUT%"
goto :EOF
:GENERATE_CPP
if "%~2" equ "DIALOGEX" goto :DIALOGEX
if "%~1" equ "COMBOBOX" goto :COMBOBOX
if "%~1" equ "CAPTION" goto :CAPTION
exit /b 0
:DIALOGEX
set IDDVAR[%IDDCNT%]=%~1
if "%IDDCNT%" equ "0" goto :DIALOGEX1
echo ###    { -1, -1, -1, NULL, NULL, NULL }
echo     { -1, -1, -1, NULL, NULL, NULL }>> "%CPPOUT%"
echo ### };
echo };>> "%CPPOUT%"
:DIALOGEX1
echo ### ENVVAR ENVAR_!IDDVAR[%IDDCNT%]![] =
echo ENVVAR ENVAR_!IDDVAR[%IDDCNT%]![] =>> "%CPPOUT%"
echo ### {
echo {>> "%CPPOUT%"
set ENVVAR=""
exit /b
:CAPTION
set IDDSTR[%IDDCNT%]=%2
set /a IDDCNT+=1
exit /b
:COMBOBOX
set ENVBOX=%2
set ENVTYP=%ENVBOX:~-4,-3%
set ENVVAR=%ENVBOX:~3,-5%
set ENVDRV=%ENVBOX:~3,3%DRV%ENVBOX:~9,-5%
if "%ENVTYP%" equ "C" goto :CBOX
if "%ENVTYP%" equ "D" goto :DBOX
if "%ENVTYP%" equ "F" goto :FBOX
exit /b
:CBOX
echo ###    { %ENVBOX%, -1, -1, "%ENVVAR%", NULL, NULL },
echo     { %ENVBOX%, -1, -1, "%ENVVAR%", NULL, NULL },>> "%CPPOUT%"
exit /b
:DBOX
echo ###    { %ENVBOX%, -1, %ENVBOX:DBOX=BTTN%, "%ENVVAR%", NULL, "%ENVDRV%" },
echo     { %ENVBOX%, %ENVBOX:DBOX=BTTN%, -1, "%ENVVAR%", NULL, "%ENVDRV%" },>> "%CPPOUT%"
exit /b
:FBOX
echo ###    { %ENVBOX%, %ENVBOX:FBOX=BTTN%, -1, "%ENVVAR%", NULL, NULL },
echo     { %ENVBOX%, -1, %ENVBOX:FBOX=BTTN%, "%ENVVAR%", NULL, NULL },>> "%CPPOUT%"
exit /b
:TOUPPER
for %%i in ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M"
            "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") do call set "%~1=%%%~1:%%~i%%"
exit /b
:ERROR_NO_RC
echo ###
echo ###                                                   No Resource File...
echo ###
goto :EOF
