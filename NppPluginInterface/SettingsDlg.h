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

#ifndef SETTINGSDLG_H
#define SETTINGSDLG_H

#include "DockingDlgInterface.h"
#include "PluginDefinition.h"

typedef struct _ENVVAR
{
    int id;
    int fldr;
    int file;
    char *name;
    char *value;
    char *drvname;
} ENVVAR;

class SettingsDlg : public DockingDlgInterface
{
public :
    SettingsDlg(int dlgID, ENVVAR *envptr);
    virtual void display(bool toShow = true);
    void setParent(HWND parent2set);

protected :
    virtual INT_PTR CALLBACK run_dlgProc(UINT message, WPARAM wParam, LPARAM lParam);
    void initenv();
    void showenv();
    void saveenv();
    void initlst();
    int chkfldr(int id);
    void getfldr(int id);
    int chkfile(int id);
    void getfile(int id);

private :
    BOOL _bShown;
    ENVVAR *_envlst;
};

typedef struct _ENVSET
{
    LPTSTR txt;
    SettingsDlg dlg;
} ENVSET;

#endif // SETTINGSDLG_H
