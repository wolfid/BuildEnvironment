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
#include "DirectorySettingsDlg.h"

extern NppData nppData;
extern void makefilename(const char *name, const char *suffix, char *filename);
extern void tmakefilename(const char *name, const char *suffix, TCHAR *filename);

DirectorySettingsDlg::DirectorySettingsDlg() : DockingDlgInterface(IDD_BUILD_ENVIRONMENT_DIRECTORIES)
{
    initenv(dirlst, _hSelf);
};

BOOL CALLBACK DirectorySettingsDlg::run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam)
{
    switch(message)
    {
        case WM_COMMAND:
        {
            switch((wParam))
            {
                case IDBROWSE_DIRECTORIES_PRJDIR:
                case IDBROWSE_DIRECTORIES_TMPDIR:
                case IDBROWSE_DIRECTORIES_TLSDIR:
                case IDBROWSE_DIRECTORIES_BATDIR:
                case IDBROWSE_DIRECTORIES_TGZDIR:
                case IDBROWSE_DIRECTORIES_CYGDIR:
                {
                    getfldr(dirlst[(wParam) - IDBROWSE_DIRECTORIES_BASE]->id, _hSelf);

                    return TRUE;
                }
                case IDBROWSE_DIRECTORIES_ENVFIL:
                case IDBROWSE_DIRECTORIES_TTLEXE:
                case IDBROWSE_DIRECTORIES_PLKEXE:
                case IDBROWSE_DIRECTORIES_PCPEXE:
                case IDBROWSE_DIRECTORIES_PYTEXE:
                {
                    getfile(dirlst[(wParam) - IDBROWSE_DIRECTORIES_BASE]->id, _hSelf);

                    return TRUE;
                }
                case IDSAVE:
                {
                    saveenv(dirlst, _hSelf);

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

void DirectorySettingsDlg::display(bool toShow)
{
    DockingDlgInterface::display(toShow);

    if(toShow)
    {
        showenv(dirlst, _hSelf);

        ::SetFocus(::GetDlgItem(_hSelf, dirlst[0]->id));
    }
}

void DirectorySettingsDlg::setParent(HWND parent2set)
{
    _hParent = parent2set;
};

