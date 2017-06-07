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

#include "BuildEnvironmentDlg.h"
#include "NppPluginBuildEnvironment.h"

extern NppData nppData;

BuildEnvironmentDlg::BuildEnvironmentDlg() : DockingDlgInterface(IDD_BUILD_ENVIRONMENT)
{
    initenv(bldlst, _hSelf);

    _bShown = false;
}

BOOL CALLBACK BuildEnvironmentDlg::run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam)
{
    switch (message)
    {
        case WM_COMMAND:
        {
            switch((wParam))
            {
                case IDBROWSE_BUILD_ENVFIL:
                {
                    getfile(bldlst[(wParam) - IDBROWSE_BUILD_BASE]->id, _hSelf);

                    return TRUE;
                }
                case IDSAVE:
                {
                    saveenv(bldlst, _hSelf);

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

        default :
        return DockingDlgInterface::run_dlgProc(message, wParam, lParam);
    }
}

void BuildEnvironmentDlg::display(bool toShow)
{
    DockingDlgInterface::display(toShow);

    if(toShow)
    {
        showenv(bldlst, _hSelf);

        if(false == _bShown)
        {
            initlst(bldlst, _hSelf);

            _bShown = true;
        }

        ::SetFocus(::GetDlgItem(_hSelf, bldlst[0]->id));
    }
};

void BuildEnvironmentDlg::setParent(HWND parent2set)
{
    _hParent = parent2set;
}
