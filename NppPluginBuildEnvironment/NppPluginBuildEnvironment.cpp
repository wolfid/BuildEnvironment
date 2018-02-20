//this file is part of notepad++
//Copyright (C)2003 Don HO <donho@altern.org>
//
//This program is free software; you can redistribute it and/or
//modify it under the terms of the GNU General Public License
//as published by the Free Software Foundation; either
//version 2 of the License, or (at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with this program; if not, write to the Free Software
//Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

//
// put the headers you need here
//
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <Shlobj.h>
#include <time.h>
#include <shlwapi.h>

#include "menuCmdID.h"

#include "NppPluginBuildEnvironmentResource.h"
#include "SettingsDlg.h"

//
// Build environment configuration
//
ENVSET envsetlst[];

//
// The plugin data that Notepad++ needs
//
FuncItem funcItem[];

//
// The data of Notepad++ that you can use in your plugin commands
//
NppData nppData;

//----------------------------------------------//
//-- Generalised dialog command. ---------------//
//----------------------------------------------//
void _settings(unsigned dex)
{
    envsetlst[dex].dlg.setParent(nppData._nppHandle);
    if(!envsetlst[dex].dlg.isCreated())
    {
        tTbData data = { 0 };

        envsetlst[dex].dlg.create(&data);

        // define the default docking behaviour
        data.uMask = DWS_DF_FLOATING;

        data.pszModuleName = envsetlst[dex].dlg.getPluginFileName();

        // the dlgDlg should be the index of funcItem where the current function pointer is
        data.dlgID = dex;
        ::SendMessage(nppData._nppHandle, NPPM_DMMREGASDCKDLG, 0, (LPARAM)&data);
    }

    envsetlst[dex].dlg.display();
}

//----------------------------------------------//
//-- STEP 4. DEFINE YOUR ASSOCIATED FUNCTIONS --//
//----------------------------------------------//
void settings0() { _settings(0); }
void settings1() { _settings(1); }
void settings2() { _settings(2); }
void settings3() { _settings(3); }
void settings4() { _settings(4); }
void settings5() { _settings(5); }
void settings6() { _settings(6); }
void settings7() { _settings(7); }
void settings8() { _settings(8); }
void settings9() { _settings(9); }

void(*settingslst[10])() =
{
    settings0,
    settings1,
    settings2,
    settings3,
    settings4,
    settings5,
    settings6,
    settings7,
    settings8,
    settings9
};

//
// Initialize your plugin data here
// It will be called while plugin loading   
void pluginInit(HANDLE hModule)
{
    // Initialize dockable dialogs
    for(unsigned dex = nbFunc; 0 != dex--;)
    {
        envsetlst[dex].dlg.init((HINSTANCE)hModule, NULL);
    }
}

//
// Here you can do the clean up, save the parameters (if any) for the next session
//
void pluginCleanUp()
{
}

//
// Initialization of your plugin commands
// You should fill your plugins commands here
void commandMenuInit()
{
    //--------------------------------------------//
    //-- STEP 3. CUSTOMIZE YOUR PLUGIN COMMANDS --//
    //--------------------------------------------//
    // with function :
    // setCommand(int index,                      // zero based number to indicate the order of command
    //            TCHAR *commandName,             // the command name that you want to see in plugin menu
    //            PFUNCPLUGINCMD functionPointer, // the symbol of function (function pointer) associated with this command. The body should be defined below. See Step 4.
    //            ShortcutKey *shortcut,          // optional. Define a shortcut to trigger this command
    //            bool check0nInit                // optional. Make this menu item be checked visually
    //            );
    for(unsigned dex = nbFunc > 10? 10: nbFunc; 0 != dex--;)
    {
        lstrcpy(funcItem[dex]._itemName, envsetlst[dex].txt);
        funcItem[dex]._pFunc = settingslst[dex];
        funcItem[dex]._init2Check = false;
        funcItem[dex]._pShKey = NULL;
    }
}

//
// Here you can do the clean up (especially for the shortcut)
//
void commandMenuCleanUp()
{
    // Don't forget to deallocate your shortcut here
}
