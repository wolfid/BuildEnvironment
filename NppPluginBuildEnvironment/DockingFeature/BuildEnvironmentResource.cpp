#include "BuildEnvironmentResource.h" 
#include "SettingsDlg.h" 
const TCHAR NPP_PLUGIN_NAME[] = TEXT("Tools Environment"); 
ENVVAR ENVVAR_Build_Settings[] =
{ 
    { ID_BLDFIL_FBOX, ID_BLDFIL_BTTN, -1, "BLDFIL", NULL, NULL },
    { ID_BLDBRA_CBOX, -1, -1, "BLDBRA", NULL, NULL },
    { ID_BLDUSR_CBOX, -1, -1, "BLDUSR", NULL, NULL },
    { ID_BLDPWD_CBOX, -1, -1, "BLDPWD", NULL, NULL },
    { ID_BLDADR_CBOX, -1, -1, "BLDADR", NULL, NULL },
    { ID_TGTVER_CBOX, -1, -1, "TGTVER", NULL, NULL },
    { ID_TGTDIR_CBOX, -1, -1, "TGTDIR", NULL, NULL },
    { ID_TGTPFM_CBOX, -1, -1, "TGTPFM", NULL, NULL },
    { ID_TGTTGZ_CBOX, -1, -1, "TGTTGZ", NULL, NULL },
    { ID_TGTUSR_CBOX, -1, -1, "TGTUSR", NULL, NULL },
    { ID_TGTADR_CBOX, -1, -1, "TGTADR", NULL, NULL },
    { ID_TGTFIL_CBOX, -1, -1, "TGTFIL", NULL, NULL },
    { ID_DBSHAN_FBOX, ID_DBSHAN_BTTN, -1, "DBSHAN", NULL, NULL },
    { -1, -1, -1, NULL, NULL, NULL }
}; 
ENVVAR ENVVAR_Directory_Settings[] =
{ 
    { ID_DIRFIL_FBOX, ID_DIRFIL_BTTN, -1, "DIRFIL", NULL, NULL },
    { ID_PRJDIR_DBOX, -1, ID_PRJDIR_BTTN, "PRJDIR", NULL, "PRJDRV" },
    { ID_TMPDIR_DBOX, -1, ID_TMPDIR_BTTN, "TMPDIR", NULL, "TMPDRV" },
    { ID_TLSDIR_DBOX, -1, ID_TLSDIR_BTTN, "TLSDIR", NULL, "TLSDRV" },
    { ID_BATDIR_DBOX, -1, ID_BATDIR_BTTN, "BATDIR", NULL, "BATDRV" },
    { ID_TGZDIR_DBOX, -1, ID_TGZDIR_BTTN, "TGZDIR", NULL, "TGZDRV" },
    { ID_CYGDIR_DBOX, -1, ID_CYGDIR_BTTN, "CYGDIR", NULL, "CYGDRV" },
    { ID_SCRDIR_CBOX, -1, -1, "SCRDIR", NULL, NULL },
    { ID_LUADIR_CBOX, -1, -1, "LUADIR", NULL, NULL },
    { ID_TTLEXE_FBOX, ID_TTLEXE_BTTN, -1, "TTLEXE", NULL, NULL },
    { ID_PLKEXE_FBOX, ID_PLKEXE_BTTN, -1, "PLKEXE", NULL, NULL },
    { ID_PCPEXE_FBOX, ID_PCPEXE_BTTN, -1, "PCPEXE", NULL, NULL },
    { ID_PYTEXE_FBOX, ID_PYTEXE_BTTN, -1, "PYTEXE", NULL, NULL },
    { ID_MAPDRV_CBOX, -1, -1, "MAPDRV", NULL, NULL },
    { ID_HOMDRV_CBOX, -1, -1, "HOMDRV", NULL, NULL },
    { -1, -1, -1, NULL, NULL, NULL }
}; 
ENVVAR ENVVAR_Miscellaneous_Settings[] =
{ 
    { ID_MSCFIL_FBOX, ID_MSCFIL_BTTN, -1, "MSCFIL", NULL, NULL },
    { ID_DBSDIR_CBOX, -1, -1, "DBSDIR", NULL, NULL },
    { ID_DBSFIL_CBOX, -1, -1, "DBSFIL", NULL, NULL },
    { ID_LTZCON_CBOX, -1, -1, "LTZCON", NULL, NULL },
    { ID_LTZCIT_CBOX, -1, -1, "LTZCIT", NULL, NULL },
    { ID_LOGDIR_CBOX, -1, -1, "LOGDIR", NULL, NULL },
    { ID_MOVLOG_CBOX, -1, -1, "MOVLOG", NULL, NULL },
    { -1, -1, -1, NULL, NULL, NULL }
}; 
const int nbFunc = 3; 
FuncItem funcItem[nbFunc]; 
ENVSET envsetlst[] = 
{ 
    { TEXT("Build Settings"), SettingsDlg(IDD_Build_Settings, ENVVAR_Build_Settings) }, 
    { TEXT("Directory Settings"), SettingsDlg(IDD_Directory_Settings, ENVVAR_Directory_Settings) }, 
    { TEXT("Miscellaneous Settings"), SettingsDlg(IDD_Miscellaneous_Settings, ENVVAR_Miscellaneous_Settings) }, 
}; 
