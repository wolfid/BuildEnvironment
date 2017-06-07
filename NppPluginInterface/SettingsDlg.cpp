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
#include <stdlib.h>
#include <shlobj.h>
#include <shlwapi.h>

#include "SettingsDlg.h"

static const size_t BUFSIZE = 1024;

//----------------------------------------------//
//-- CTOR. -------------------------------------//
//----------------------------------------------//
SettingsDlg::SettingsDlg(int dlgID, ENVVAR *envptr) : _envlst(envptr), DockingDlgInterface(dlgID)
{
    initenv();
};

//----------------------------------------------//
//-- Message pump. -----------------------------//
//----------------------------------------------//
BOOL CALLBACK SettingsDlg::run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam)
{
    switch(message)
    {
        case WM_COMMAND:
        {
            int id = chkfldr(wParam);
            if(-1 != id)
            {
                getfldr(id);

                return TRUE;
            }
            id = chkfile(wParam);
            if(-1 != id)
            {
                getfile(id);

                return TRUE;
            }

            switch(wParam)
            {
                case IDOK:
                {
                    saveenv();

                    display(false);

                    return TRUE;
                }
                case IDCANCEL:
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

//----------------------------------------------//
//-- Display dialog. ---------------------------//
//----------------------------------------------//
void SettingsDlg::display(bool toShow)
{
    DockingDlgInterface::display(toShow);

    if(toShow)
    {
        showenv();

        if(false == _bShown)
        {
            initlst();

            _bShown = true;
        }

        ::SetFocus(::GetDlgItem(_hSelf, _envlst[0].id));
    }
}

//----------------------------------------------//
//-- Set parent handle. ------------------------//
//----------------------------------------------//
void SettingsDlg::setParent(HWND parent2set)
{
    _hParent = parent2set;
};

const char *appdata = "APPDATA";
const char *configdir = "\\Notepad++\\plugins\\config\\";

//----------------------------------------------//
//-- Create config file name. ------------------//
//----------------------------------------------//
void makeconfigfilename(const char *name, const char *suffix, char *filename)
{
    size_t size;
    char *env;

    if(0 == _dupenv_s(&env, &size, appdata))
    {
        const char *i;
        const TCHAR *t;
        char *o = filename;

        for(i = env; *o++ = *i++;);
        for(--o, i = configdir; *o++ = *i++;);
        for(--o, t = NPP_PLUGIN_NAME; *t; t++)
        {
            if(' ' != *t)
            {
                *o++ = *(char *)t;
            }
        }
        for(*o++ = '\\', i = name; *o++ = *i++;);
        for(--o, i = suffix; *o++ = *i++;);
    }
}

//----------------------------------------------//
//-- Compare buffers. --------------------------//
//----------------------------------------------//
int comparebuf(const char *buf, const wchar_t *tbuf)
{
    if(NULL == buf && NULL == tbuf)
    {
        return 0;
    }

    if(NULL == buf)
    {
        return -1;
    }

    if(NULL == tbuf)
    {
        return 1;
    }

    wchar_t *temp = new wchar_t[strlen(buf) + 1];
    size_t csize = 0;
    mbstowcs_s(&csize, temp, strlen(buf) + 1, buf, BUFSIZE);
    int ret = wcscmp(temp, tbuf);
    delete[] temp;

    return ret;
}

//----------------------------------------------//
//-- Initialise respective environment. --------//
//----------------------------------------------//
void SettingsDlg::initenv()
{
    unsigned envdex = 0;

    for(; -1 != _envlst[envdex].id; ++envdex)
    {
        char buf[BUFSIZE];
        FILE *pFile;

        makeconfigfilename(_envlst[envdex].name, ".ini", buf);

        if(0 == fopen_s(&pFile, buf, "r"))
        {
            int i = fread(buf, 1, BUFSIZE, pFile);

            _envlst[envdex].value = new char[i + 1];

            memcpy(_envlst[envdex].value, buf, i);

            _envlst[envdex].value[i] = 0;

            fclose(pFile);

            if(i > 0)
            {
                makeconfigfilename(_envlst[envdex].name, ".lst", buf);

                if (0 != fopen_s(&pFile, buf, "r"))
                {
                    if (0 == fopen_s(&pFile, buf, "w"))
                    {
                        fwrite(_envlst[envdex].value, 1, i, pFile);
                        fwrite("\n", 1, 1, pFile);
                        fclose(pFile);
                    }
                }
                else
                {
                    fclose(pFile);
                }
            }
        }
    }
}

//----------------------------------------------//
//-- Show environment. -------------------------//
//----------------------------------------------//
void SettingsDlg::showenv()
{
    unsigned envdex = 0;

    for(; -1 != _envlst[envdex].id; ++envdex)
    {
        if(NULL != _envlst[envdex].value)
        {
            wchar_t *env = new wchar_t[strlen(_envlst[envdex].value) + 1];
            size_t csize = 0;
            mbstowcs_s(&csize, env, strlen(_envlst[envdex].value) + 1, _envlst[envdex].value, BUFSIZE);
            ::SendMessage(::GetDlgItem(_hSelf, _envlst[envdex].id), WM_SETTEXT, 0, (LPARAM)env);
            delete[] env;
        }
    }
}

//----------------------------------------------//
//-- Initialise lists. -------------------------//
//----------------------------------------------//
void SettingsDlg::initlst()
{
    unsigned envdex = 0;

    for(; -1 != _envlst[envdex].id; ++envdex)
    {
        char buf[BUFSIZE];
        FILE *pFile;

        makeconfigfilename(_envlst[envdex].name, ".lst", buf);
        if(0 == fopen_s(&pFile, buf, "r"))
        {
            while(NULL != fgets(buf, BUFSIZE, pFile))
            {
                size_t csize = strlen(buf);

                if(csize > 0 && '\n' != buf[0])
                {
                    wchar_t *env = new wchar_t[++csize];

                    for(; 0 != csize--;)
                    {
                        env[csize] = (wchar_t)buf[csize];
                    }

                    ::SendMessage(
                        ::GetDlgItem(
                            _hSelf,
                            _envlst[envdex].id),
                            CB_ADDSTRING,
                            0,
                            (LPARAM)env);

                    delete[] env;
                }
            }

            fclose(pFile);
        }
    }
}

//----------------------------------------------//
//-- Save respective environment. --------------//
//----------------------------------------------//
void SettingsDlg::saveenv()
{
    FILE *pFile = NULL;
    unsigned envdex = 0;
    char buf[BUFSIZE];
    wchar_t tbuf[BUFSIZE];

    for(; -1 != _envlst[envdex].id; ++envdex)
    {
        int i = ::SendMessage(
            ::GetDlgItem(
                _hSelf,
                _envlst[envdex].id),
                WM_GETTEXT,
                BUFSIZE,
                (LPARAM)tbuf);

        if(0 != i)
        {
            if(0 != comparebuf(_envlst[envdex].value, tbuf))
            {
                i = wcslen(tbuf);

                if(i > 0)
                {
                    if(NULL != _envlst[envdex].value)
                    {
                        bool gotit = false;

                        makeconfigfilename(_envlst[envdex].name, ".lst", buf);
                        if(0 == fopen_s(&pFile, buf, "r"))
                        {
                            while(NULL != fgets(buf, BUFSIZE, pFile))
                            {
                                if(0 == comparebuf(buf, tbuf))
                                {
                                    gotit = true;
                                    break;
                                }
                            }

                            if(true == gotit)
                            {
                                fclose(pFile);
                                pFile = NULL;
                            }
                            else
                            {
                                makeconfigfilename(_envlst[envdex].name, ".lst", buf);
                                freopen_s(&pFile, buf, "a", pFile);
                            }
                        }
                        else
                        {
                            if(0 == fopen_s(&pFile, buf, "w"))
                            {
                                fwrite(_envlst[envdex].value, 1, strlen(_envlst[envdex].value), pFile);
                                fwrite("\n", 1, 1, pFile);
                            }
                        }

                        delete[] _envlst[envdex].value;
                    }

                    if((char)tbuf[i - 1] == '\n')
                    {
                        tbuf[--i] = 0;
                    }

                    _envlst[envdex].value = new char[i + 1];

                    char *o = _envlst[envdex].value;
                    wchar_t *t = tbuf;

                    for(; *o++ = (char)(*t++ & 0xff););

                    if(NULL != pFile)
                    {
                        fwrite(_envlst[envdex].value, 1, strlen(_envlst[envdex].value), pFile);
                        fwrite("\n", 1, 1, pFile);
                        fclose(pFile);
                        pFile = NULL;

                        tbuf[i] = '\n';
                        tbuf[i + 1] = '\0';

                        ::SendMessage(
                            ::GetDlgItem(
                            _hSelf,
                            _envlst[envdex].id),
                            CB_ADDSTRING,
                            0,
                            (LPARAM)tbuf);
                    }
                }
                else if(NULL != _envlst[envdex].value)
                {
                    delete[] _envlst[envdex].value;
                }

                makeconfigfilename(_envlst[envdex].name, ".ini", buf);
                if(0 == fopen_s(&pFile, buf, "w"))
                {
                    if(i > 0)
                    {
                        fwrite(_envlst[envdex].value, 1, strlen(_envlst[envdex].value), pFile);
                    }

                    fclose(pFile);
                    pFile = NULL;
                }
            }
        }
        else
        {
            if(NULL != _envlst[envdex].value)
            {
                delete[] _envlst[envdex].value;
                _envlst[envdex].value = NULL;
            }

            makeconfigfilename(_envlst[envdex].name, ".ini", buf);
            if (0 == fopen_s(&pFile, buf, "w"))
            {
                fclose(pFile);
                pFile = NULL;
            }
        }
    }

    if(NULL != _envlst[0].value)
    {
        if(0 == fopen_s(&pFile, _envlst[0].value, "w"))
        {
            for(envdex = 1; -1 != _envlst[envdex].id; ++envdex)
            {
                if(NULL != _envlst[envdex].value && 0 != strlen(_envlst[envdex].value))
                {
                    if(NULL != _envlst[envdex].drvname && strlen(_envlst[envdex].value) > 1 && ':' == _envlst[envdex].value[1])
                    {
                        fwrite(_envlst[envdex].drvname, 1, strlen(_envlst[envdex].drvname), pFile);
                        fwrite(",\"", 1, 2, pFile);
                        fwrite(_envlst[envdex].value, 1, 1, pFile);
                        fwrite("\"\n", 1, 2, pFile);
                        fwrite(_envlst[envdex].name, 1, strlen(_envlst[envdex].name), pFile);
                        fwrite(",\"", 1, 2, pFile);
                        fwrite(_envlst[envdex].value + 2, 1, strlen(_envlst[envdex].value) - 2, pFile);
                        fwrite("\"\n", 1, 2, pFile);
                    }
                    else
                    {
                        fwrite(_envlst[envdex].name, 1, strlen(_envlst[envdex].name), pFile);
                        fwrite(",\"", 1, 2, pFile);
                        fwrite(_envlst[envdex].value, 1, strlen(_envlst[envdex].value), pFile);
                        fwrite("\"\n", 1, 2, pFile);
                    }
                }
            }

            fclose(pFile);
        }
    }
}

//----------------------------------------------//
//-- Check for folder dialog. ------------------//
//----------------------------------------------//
int SettingsDlg::chkfldr(int id)
{
    unsigned envdex = 0;

    for(; -1 != _envlst[envdex].id; ++envdex)
    {
        if(id == _envlst[envdex].fldr)
        {
            return _envlst[envdex].id;
        }
    }

    return -1;
}

//----------------------------------------------//
//-- Get folder dialog. ------------------------//
//----------------------------------------------//
void SettingsDlg::getfldr(int id)
{
    TCHAR tbuf[MAX_PATH];
    BROWSEINFO bi;
    bi.hwndOwner = _hSelf;
    bi.ulFlags = BIF_RETURNONLYFSDIRS;
    bi.pidlRoot = NULL;
    bi.lpszTitle = TEXT("Select Folder");
    bi.pszDisplayName = tbuf;
    bi.iImage = 0;
    bi.lpfn = NULL;
    bi.lParam = NULL;
    LPCITEMIDLIST pidl = ::SHBrowseForFolder(&bi);

    if(NULL != pidl)
    {
        if(0 != ::SHGetPathFromIDList(pidl, tbuf))
        {
            ::SendMessage(
                ::GetDlgItem(_hSelf, id),
                WM_SETTEXT,
                0,
                (LPARAM)tbuf);
        }

        CoTaskMemFree((LPVOID)pidl);
    }
}

//----------------------------------------------//
//-- Check for file dialog. --------------------//
//----------------------------------------------//
int SettingsDlg::chkfile(int id)
{
    unsigned envdex = 0;

    for(; -1 != _envlst[envdex].id; ++envdex)
    {
        if(id == _envlst[envdex].file)
        {
            return _envlst[envdex].id;
        }
    }

    return -1;
}

//----------------------------------------------//
//-- Get file dialog. --------------------------//
//----------------------------------------------//
void SettingsDlg::getfile(int id)
{
    IFileOpenDialog *pfd;
    HRESULT hr = CoCreateInstance(
        CLSID_FileOpenDialog,
        NULL,
        CLSCTX_INPROC_SERVER,
        IID_PPV_ARGS(&pfd));

    if(SUCCEEDED(hr))
    {
        hr = pfd->Show(NULL);
        if(SUCCEEDED(hr))
        {
            IShellItem *psiResult;
            hr = pfd->GetResult(&psiResult);

            if(SUCCEEDED(hr))
            {
                PWSTR pszFilePath = NULL;
                hr = psiResult->GetDisplayName(
                    SIGDN_FILESYSPATH,
                    &pszFilePath);

                if(SUCCEEDED(hr))
                {
                    ::SendMessage(
                        ::GetDlgItem(_hSelf, id),
                        WM_SETTEXT,
                        0,
                        (LPARAM)pszFilePath);

                    CoTaskMemFree(pszFilePath);
                }

                psiResult->Release();
            }

            pfd->Release();
        }
    }
}
