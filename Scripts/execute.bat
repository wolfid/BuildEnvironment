@echo off
echo ###                                                        @file %~n0%~x0
echo ###
echo ### @brief Execute file...
echo ###
echo ### @param %%1 - File to execute
echo ### @param %%2 - Environment setup script
echo ###
echo ###                                                       WXD 12 Aug 2015
echo ###
if [%1] equ [] goto :NOSCRIPT
if [%2] neq [] call %2
if "%BLDBRA%" equ "" goto :NOBLDBRA
if "%~x1" equ ".TTL" goto :TTL
if "%~x1" neq ".ttl" goto :NOTTTL
:TTL
if "%TTLEXE%" equ "" goto :NOTTL
echo on
"%TTLEXE%" %1
goto :EOF
:NOTTL
echo ###
echo ###                                                 No TTL ENVIRONMENT...
echo ###
goto :EOF
:NOTTTL
if "%~x1" equ ".PY" goto :PYT
if "%~x1" neq ".py" goto :NOTPYT
:TTL
if "%PYTEXE%" equ "" goto :NOPYT
echo on
"%PYTEXE%" %1
goto :EOF
:NOPYT
echo ###
echo ###                                              No Python ENVIRONMENT...
echo ###
goto :EOF
:NOTPYT
if "%~x1" equ ".XXX" goto :XXX
if "%~x1" neq ".xxx" goto :NOTXXX
:XXX
if "%XXXEXE%" equ "" goto :NOXXX
echo on
"%XXXEXE%" %1
goto :EOF
:NOXXX
echo ###
echo ###                                                 No XXX ENVIRONMENT...
echo ###
goto :EOF
:NOTXXX
echo ###
echo ###                                              Unsupported File Type...
echo ###
goto :EOF
:NOBLDBRA
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
:NOSCRIPT
echo ###
echo ###                                                No Script Specified...
echo ###
goto :EOF
