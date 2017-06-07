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
echo ###                                                 @file %~n0%~x0 ###
echo ###                                                                   ###
echo ### @brief Generate resource files for project...                     ###
echo ###                                                                   ###
echo ### @see %~n0.readme.txt for details.                              ###
echo ###                                                                   ###
echo ### @param %%1 - Project file                                          ###
echo ###                                                                   ###
echo #########################################################################
if [%1] equ [] goto :ERROR_NO_PRJ
if [%~x1] neq [.vcxproj] goto :ERROR_NO_PRJ
set VCXPRJ=%1
call D:\Projects\tools\NppPluginTools\lst2rc %VCXPRJ:.vcxproj=Resource.lst%
call D:\Projects\tools\NppPluginTools\rc2hpp %VCXPRJ:.vcxproj=Resource.rc%
call D:\Projects\tools\NppPluginTools\rc2cpp %VCXPRJ:.vcxproj=Resource.rc%
goto :EOF
:ERROR_NO_PRJ
echo ###
echo ###                                              Error No Project File...
echo ###
goto :EOF
