@echo off
echo ###                                                       @file %~n0%~x0
echo ###
echo ### @brief Set value in HTC database...
echo ###
echo ### @param %%1 - Environment setup script
echo ###
echo ###                                                       WXD 11 Dec 2015
echo ###
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :NO_BUILD_ENVIRONMENT
set DELBEG="\"delete from parameters where module_id=(select id from modules where symbol='
set DELMID=') and tag='
set DELEND=' and paramtype_id='1';\""
set INSBEG="\"insert into parameters (module_id, tag, value, paramtype_id) values ((select id from modules where symbol='
set INSMID='),'
set INSNXT=','
set INSEND=','1');\""
setlocal EnableDelayedExpansion
:SET_VALUE
if "!SQLMOD%MODCNT%!" equ "" goto :EOF
if "!SQLTAG%MODCNT%!" equ "" goto :NEXT_VALUE
set SQLMOD=!SQLMOD%MODCNT%!
set SQLVAL=!SQLVAL%MODCNT%!
set SQLTAG=!SQLTAG%MODCNT%!
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %DELBEG%%SQLMOD%%DELMID%%SQLTAG%%DELEND%
"%PLKEXE%" %TGTUSR%@%TGTADR% sqlite3 /%BLDTGT%/%DBSDIR%/%DBSFIL% %INSBEG%%SQLMOD%%INSMID%%SQLTAG%%INSNXT%%SQLVAL%%INSEND%
@echo off
set /a MODCNT+=1
goto :SET_VALUE
:NO_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
