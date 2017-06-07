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
#include "EnvironmentSettingsDlg.h"

extern NppData nppData;
extern void makefilename(const char *name, const char *suffix, char *filename);
extern void tmakefilename(const char *name, const char *suffix, TCHAR *filename);

BOOL CALLBACK EnvironmentSettingsDlg::run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam)
{
    static TCHAR tbuf[1024] = { 0 };

    switch(message)
    {
        case WM_COMMAND:
        {
            switch(wParam)
            {
                case IDBROWSE:
                {
                    BROWSEINFO bi;
                    bi.hwndOwner = _hSelf;
                    bi.ulFlags = BIF_RETURNONLYFSDIRS;
                    bi.pidlRoot = NULL;
                    bi.lpszTitle = TEXT("Select Folder");
                    bi.iImage = 0;
                    LPCITEMIDLIST pidl = ::SHBrowseForFolder(&bi);

                    if(NULL == pidl)
                    {
                        return TRUE;
                    }

                    if(0 != ::SHGetPathFromIDList(pidl, tbuf))
                    {
                        SendMessage(
                            ::GetDlgItem(
                            _hSelf,
                            ID_ENVIRONMENT_DIRECTORY_TEXTBOX),
                            WM_SETTEXT,
                            0,
                            (LPARAM)tbuf);
                    }

                    CoTaskMemFree((LPVOID)pidl);

                    return TRUE;
                }
                case IDOK:
                {
                    if(0 != tbuf[0])
                    {
                        if(NULL != ENVDIR.value)
                        {
                            delete[] ENVDIR.value;
                        }
                        ENVDIR.value = new char[wcslen(tbuf) + 1];

                        char *o = ENVDIR.value;
                        TCHAR *i = tbuf;

                        for(; *o++ = (char)(*i++ & 0xff););
                        tbuf[0] = 0;

                        char buf[1024];
                        makefilename(ENVDIR.name, ".ini", buf);
                        FILE *pFile;
                        pFile = fopen(buf, "w");
                        if(NULL != pFile)
                        {
                            fwrite(ENVDIR.value, 1, strlen(ENVDIR.value), pFile);

                            fclose(pFile);
                        }
                    }

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
