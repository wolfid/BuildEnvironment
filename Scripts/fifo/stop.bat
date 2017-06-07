@echo off
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
echo ### Copyright (c) 2016 Wolfgang Dunsdon.                              ###
echo ### All rights reserved.                                              ###
echo ###                                                                   ###
echo ###                                                       25 Apr 2016 ###
echo ###                                                                   ###
echo ###                                                  @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Stop system...                                             ###
echo ###                                                                   ###
echo ### @param %%1 - Environment setup script                              ###
echo ###                                                                   ###
echo #########################################################################
if [%1] neq [] call %1
if "%BLDBRA%" equ "" goto :NO_BUILD_ENVIRONMENT
:STOP
echo on
"%PLKEXE%" %TGTUSR%@%TGTADR% %TRMCMD%
goto :EOF
:NO_BUILD_ENVIRONMENT
echo ###
echo ###                                               NO BUILD ENVIRONMENT...
echo ###
goto :EOF
