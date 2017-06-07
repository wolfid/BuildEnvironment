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

#ifndef NPPLUGINBUILDENVIRONMENTRESOURCE_H
#define NPPLUGINBUILDENVIRONMENTRESOURCE_H

#ifndef IDC_STATIC
#define IDC_STATIC -1
#endif

#define IDDBTN 2000
#define ID_DIRFIL_BTTN (IDDBTN + 1)
#define ID_PRJDIR_BTTN (IDDBTN + 2)
#define ID_TMPDIR_BTTN (IDDBTN + 3)
#define ID_TLSDIR_BTTN (IDDBTN + 4)
#define ID_BATDIR_BTTN (IDDBTN + 5)
#define ID_TGZDIR_BTTN (IDDBTN + 6)
#define ID_CYGDIR_BTTN (IDDBTN + 7)
#define ID_SRCDIR_BTTN (IDDBTN + 8)
#define ID_LUADIR_BTTN (IDDBTN + 9)
#define ID_TTLEXE_BTTN (IDDBTN + 10)
#define ID_PLKEXE_BTTN (IDDBTN + 11)
#define ID_PCPEXE_BTTN (IDDBTN + 12)
#define ID_PYTEXE_BTTN (IDDBTN + 13)
#define ID_BLDFIL_BTTN (IDDBTN + 14)
#define ID_DBSHAN_BTTN (IDDBTN + 15)
#define ID_MSCFIL_BTTN (IDDBTN + 16)

#define IDD_Directory_Settings 3000
#define ID_DIRFIL_TEXT (IDD_Directory_Settings + 1)
#define ID_DIRFIL_FBOX (IDD_Directory_Settings + 2)
#define ID_PRJDIR_TEXT (IDD_Directory_Settings + 3)
#define ID_PRJDIR_DBOX (IDD_Directory_Settings + 4)
#define ID_TMPDIR_TEXT (IDD_Directory_Settings + 5)
#define ID_TMPDIR_DBOX (IDD_Directory_Settings + 6)
#define ID_TLSDIR_TEXT (IDD_Directory_Settings + 7)
#define ID_TLSDIR_DBOX (IDD_Directory_Settings + 8)
#define ID_BATDIR_TEXT (IDD_Directory_Settings + 9)
#define ID_BATDIR_DBOX (IDD_Directory_Settings + 10)
#define ID_CYGDIR_TEXT (IDD_Directory_Settings + 11)
#define ID_CYGDIR_DBOX (IDD_Directory_Settings + 12)
#define ID_TGZDIR_TEXT (IDD_Directory_Settings + 13)
#define ID_TGZDIR_DBOX (IDD_Directory_Settings + 14)
#define ID_SCRDIR_TEXT (IDD_Directory_Settings + 15)
#define ID_SCRDIR_CBOX (IDD_Directory_Settings + 16)
#define ID_LUADIR_TEXT (IDD_Directory_Settings + 17)
#define ID_LUADIR_CBOX (IDD_Directory_Settings + 18)
#define ID_TTLEXE_TEXT (IDD_Directory_Settings + 19)
#define ID_TTLEXE_FBOX (IDD_Directory_Settings + 20)
#define ID_PLKEXE_TEXT (IDD_Directory_Settings + 21)
#define ID_PLKEXE_FBOX (IDD_Directory_Settings + 22)
#define ID_PCPEXE_TEXT (IDD_Directory_Settings + 23)
#define ID_PCPEXE_FBOX (IDD_Directory_Settings + 24)
#define ID_PYTEXE_TEXT (IDD_Directory_Settings + 25)
#define ID_PYTEXE_FBOX (IDD_Directory_Settings + 26)
#define ID_MAPDRV_TEXT (IDD_Directory_Settings + 27)
#define ID_MAPDRV_CBOX (IDD_Directory_Settings + 28)
#define ID_HOMDRV_TEXT (IDD_Directory_Settings + 29)
#define ID_HOMDRV_CBOX (IDD_Directory_Settings + 30)

#define IDD_Build_Settings 4000
#define ID_BLDFIL_TEXT (IDD_Build_Settings + 1)
#define ID_BLDFIL_FBOX (IDD_Build_Settings + 2)
#define ID_BLDBRA_CBOX (IDD_Build_Settings + 3)
#define ID_BLDBRA_TEXT (IDD_Build_Settings + 4)
#define ID_BLDUSR_CBOX (IDD_Build_Settings + 5)
#define ID_BLDUSR_TEXT (IDD_Build_Settings + 6)
#define ID_BLDPWD_CBOX (IDD_Build_Settings + 7)
#define ID_BLDPWD_TEXT (IDD_Build_Settings + 8)
#define ID_BLDADR_CBOX (IDD_Build_Settings + 9)
#define ID_BLDADR_TEXT (IDD_Build_Settings + 10)
#define ID_TGTVER_CBOX (IDD_Build_Settings + 11)
#define ID_TGTVER_TEXT (IDD_Build_Settings + 12)
#define ID_TGTDIR_CBOX (IDD_Build_Settings + 13)
#define ID_TGTDIR_TEXT (IDD_Build_Settings + 14)
#define ID_TGTPFM_CBOX (IDD_Build_Settings + 15)
#define ID_TGTPFM_TEXT (IDD_Build_Settings + 16)
#define ID_TGTTGZ_CBOX (IDD_Build_Settings + 17)
#define ID_TGTTGZ_TEXT (IDD_Build_Settings + 18)
#define ID_TGTUSR_CBOX (IDD_Build_Settings + 19)
#define ID_TGTUSR_TEXT (IDD_Build_Settings + 20)
#define ID_TGTADR_CBOX (IDD_Build_Settings + 21)
#define ID_TGTADR_TEXT (IDD_Build_Settings + 22)
#define ID_TGTFIL_CBOX (IDD_Build_Settings + 23)
#define ID_TGTFIL_TEXT (IDD_Build_Settings + 24)

#define IDD_Miscellaneous_Settings 5000
#define ID_MSCFIL_TEXT (IDD_Miscellaneous_Settings + 1)
#define ID_MSCFIL_FBOX (IDD_Miscellaneous_Settings + 2)
#define ID_DBSHAN_TEXT (IDD_Miscellaneous_Settings + 3)
#define ID_DBSHAN_FBOX (IDD_Miscellaneous_Settings + 4)
#define ID_DBSDIR_TEXT (IDD_Miscellaneous_Settings + 5)
#define ID_DBSDIR_CBOX (IDD_Miscellaneous_Settings + 6)
#define ID_DBSFIL_TEXT (IDD_Miscellaneous_Settings + 7)
#define ID_DBSFIL_CBOX (IDD_Miscellaneous_Settings + 8)
#define ID_LTZCON_TEXT (IDD_Miscellaneous_Settings + 9)
#define ID_LTZCON_CBOX (IDD_Miscellaneous_Settings + 10)
#define ID_LTZCIT_TEXT (IDD_Miscellaneous_Settings + 11)
#define ID_LTZCIT_CBOX (IDD_Miscellaneous_Settings + 12)
#define ID_LOGDIR_TEXT (IDD_Miscellaneous_Settings + 13)
#define ID_LOGDIR_CBOX (IDD_Miscellaneous_Settings + 14)
#define ID_MOVLOG_TEXT (IDD_Miscellaneous_Settings + 15)
#define ID_MOVLOG_CBOX (IDD_Miscellaneous_Settings + 16)

#endif // NPPLUGINBUILDENVIRONMENTRESOURCE_H
