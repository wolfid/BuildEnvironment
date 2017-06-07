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

#include "NppPluginBuildEnvironment.h"
#include "MiscellaneousSettingsDlg.h"

extern NppData nppData;

MiscellaneousSettingsDlg::MiscellaneousSettingsDlg() : DockingDlgInterface(IDD_BUILD_ENVIRONMENT_MISCELLANEOUS)
{
    initenv(msclst, _hSelf);

    _bShown = false;
}

BOOL CALLBACK MiscellaneousSettingsDlg::run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam)
{
    switch(message)
    {
        case WM_COMMAND:
        {
            switch((wParam))
            {
                case IDBROWSE_MISCELLANEOUS_ENVFIL:
                case IDBROWSE_MISCELLANEOUS_DBSHAN:
                {
                    getfile(msclst[(wParam) - IDBROWSE_MISCELLANEOUS_BASE]->id, _hSelf);

                    return TRUE;
                }
                case IDSAVE:
                {
                    saveenv(msclst, _hSelf);

                    display(false);

                    return TRUE;
                }
                case IDLOSE:
                {
                    display(false);

                    return TRUE;
                }
            }

            return FALSE;
        }

        default:
        {
            return DockingDlgInterface::run_dlgProc(message, wParam, lParam);
        }
    }
}

void MiscellaneousSettingsDlg::display(bool toShow)
{
    DockingDlgInterface::display(toShow);

    if(toShow)
    {
        showenv(msclst, _hSelf);

        if(false == _bShown)
        {
            initlst(msclst, _hSelf);

            _bShown = true;
        }

        ::SetFocus(::GetDlgItem(_hSelf, msclst[0]->id));
    }
};

void MiscellaneousSettingsDlg::setParent(HWND parent2set)
{
    _hParent = parent2set;
}
