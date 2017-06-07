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

#ifndef ENVIRONMENTSETTINGSDLG_H
#define ENVIRONMENTSETTINGSDLG_H

#include "DockingDlgInterface.h"
#include "BuildEnvironmentResource.h"

class EnvironmentSettingsDlg : public DockingDlgInterface
{
public :
    EnvironmentSettingsDlg() : DockingDlgInterface(IDD_BUILD_ENVIRONMENT_SETTINGS)
    {
    };

    virtual void display(bool toShow = true)
    {
        DockingDlgInterface::display(toShow);

        if(toShow)
        {
            HWND hwnd = ::GetDlgItem(_hSelf, ID_ENVIRONMENT_DIRECTORY_TEXTBOX);

            if(NULL != ENVDIR.value)
            {
                TCHAR *env = new TCHAR[strlen(ENVDIR.value) + 1];
                size_t csize = 0;
                mbstowcs_s(&csize, env, strlen(ENVDIR.value) + 1, ENVDIR.value, 1024);
                ::SendMessage(hwnd, WM_SETTEXT, 0, (LPARAM)env);
                delete[] env;
            }

            ::SetFocus(hwnd);
        }
    };

    void setParent(HWND parent2set)
    {
        _hParent = parent2set;
    };

protected :
    virtual BOOL CALLBACK run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam);

private :
};

#endif // ENVIRONMENTSETTINGSDLG_H
