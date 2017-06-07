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
echo ###                                                       22 May 2016 ###
echo ###                                                                   ###
echo ###                                                   @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Run setup for project...                                   ###
echo ###                                                                   ###
echo ### @see %~n0.readme.txt for details.                                ###
echo ###                                                                   ###
echo ### @param %%1 - Project directory                                     ###
echo ###                                                                   ###
echo #########################################################################
if [%1] equ [] goto :ERROR_NO_PRJ
%~1setup\Output\setup.exe
goto :EOF
:ERROR_NO_PRJ
echo ###
echo ###                                          Error No Project Directory...
echo ###
goto :EOF
