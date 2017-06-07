@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Target Database Check...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 11 Dec 2015
echo ###
if [%1] neq [] call %1
:DBCHK_CSV
if "%DBSCSV%" equ "" goto :ERROR_DATABASE_CSV
set REDOUT="%TMPDRV%:%TMPDIR%\red.out"
set CHKBEG="\"select id from parameters where module_id=(select id from modules where symbol='
set CHKTAG=') and tag='
set CHKSYM=' and symbol='
set CHKPRM=' and paramtype_id='
set CHKEND=' collate binary;\""
echo ###
echo ### Comparing %TGTUSR%@%TGTADR%:/%BLDTGT%/%DBSDIR%/%DBSFIL% against %DBSCSV%
echo ###
set /a NIDCNT=0 
for /f "usebackq tokens=1,2,3,4" %%a in (%DBSCSV%) do call :DBCHK_ENTRY %%a %%b %%c %%d
echo ###
echo ### %NIDCNT% entries not in %TGTUSR%@%TGTADR%:/%BLDTGT%/%DBSDIR%/%DBSFIL%...
echo ###
goto :EOF
:DBCHK_ENTRY
if [%1] equ [module_id] exit /b 0
if [%1] equ [COMMON] exit /b 0
if [%1] equ [DOXYGEN_COMMENT] exit /b 0
if [%2] equ [1] goto :DBCHK_PARAM
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %CHKBEG%%1%CHKTAG%%3%CHKSYM%%4%CHKPRM%%2%CHKEND% > %REDOUT% 2>&1
goto :DBCHK_ID
:DBCHK_PARAM
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %CHKBEG%%1%CHKTAG%%3%CHKPRM%%2%CHKEND% > %REDOUT% 2>&1
:DBCHK_ID
set ID=
for /f "usebackq tokens=1" %%e in (%REDOUT%) do call set ID=%%e
if [%ID%] neq [] exit /b 0
if [%NIDCNT%] equ [0] call :DBCHK_NO_ID
echo ### %1, %2, %3, %4
set /a NIDCNT+=1 
exit /b 0
:DBCHK_NO_ID
echo ### No DB entry for:
exit /b 0
:ERROR_DATABASE_CSV
echo ###
echo ###                                               NO DATABASE CSV FILE...
echo ###
goto :EOF
