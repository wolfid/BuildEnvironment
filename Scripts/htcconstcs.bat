@echo off
echo %0 %1 %2
if "%~1" equ "" (set HTCPARAM="htcparam.csv") else set HTCPARAM="%~1"
if "%~2" equ "" (set HTCPATH=".") else set HTCPATH=%~2
set HTCCONST=htcconst
set HTCSYMBOL=htcsymbol
call :INITALL
for /f "usebackq tokens=1,2,3,4,5,6,7 delims=," %%a in (%HTCPARAM%) do call :GENERATE_CODE %%a %%b %%c %%d %%e %%f %%g
call :ENDALL
goto :EOF
:GENERATE_CODE
    if "%~1" equ "module_id" exit /b 0
    if "%~1" equ "ALL" exit /b 0
    if "%~1" equ "DOXYGEN_COMMENT" exit /b 0
    if "%~2" equ "1" goto :PARAM
    goto :SYMBOL
    exit /b 0
:PARAM
    call :APPEND "    public const String %%4 = "%%3";" "%HTCPATH%\%HTCCONST%.cs"
    exit /b 0
:SYMBOL
    call :APPEND "        { "%%1", "%%2", "%%3", "%%4" }," "%HTCPATH%\%HTCSYMBOL%.cs"
    exit /b 0
:INITALL
    if exist "%HTCPATH%\%HTCCONST%.cs" del "%HTCPATH%\%HTCCONST%.cs"
    call :APPEND "/// @file %HTCCONST%" "%HTCPATH%\%HTCCONST%.cs"
    call :APPEND "/// This is a generated file so beware if editing..." "%HTCPATH%\%HTCCONST%.cs"
    call :APPEND "public static class HTCCONST" "%HTCPATH%\%HTCCONST%.cs"
    call :APPEND "{" "%HTCPATH%\%HTCCONST%.cs"
    if exist "%HTCPATH%\%HTCSYMBOL%.cs" del "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "/// @file %HTCSYMBOL%.cs" "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "/// This is a generated file so beware if editing..." "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "public static class %HTCSYMBOL%" "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "{" "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "    public const String list[][] =" "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "    {" "%HTCPATH%\%HTCSYMBOL%.cs"
    exit /b 0
:ENDALL
    call :APPEND "}" "%HTCPATH%\%HTCCONST%.cs"
    call :APPEND "        { "", "", "", "" }" "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "    };" "%HTCPATH%\%HTCSYMBOL%.cs"
    call :APPEND "}" "%HTCPATH%\%HTCSYMBOL%.cs"
    exit /b 0
:APPEND
    echo %~1 >> %2
    exit /b 0
