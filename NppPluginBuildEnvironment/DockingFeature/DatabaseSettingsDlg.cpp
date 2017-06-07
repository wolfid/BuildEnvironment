//this file is part of notepad++
//Copyright (C)2003 Don HO ( donho@altern.org )
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

#include <stdio.h>
#include "Shlobj.h"
#include "NppPluginBuildEnvironment.h"
#include "DatabaseSettingsDlg.h"

extern NppData nppData;

BOOL CALLBACK DatabaseSettingsDlg::run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam)
{
    static TCHAR tbuf[1024] = { 0 };

    switch(message)
    {
        case WM_COMMAND:
        {
            switch(LOWORD(wParam))
            {
                case IDOK:
                {
                    display(false);

                    return TRUE;
                }
                case IDCANCEL:
                {
                    tbuf[0] = 0;

                    display(false);

                    return TRUE;
                }

                return FALSE;
            }
        }

        default:
        {
            return DockingDlgInterface::run_dlgProc(message, wParam, lParam);
        }
    }
}
