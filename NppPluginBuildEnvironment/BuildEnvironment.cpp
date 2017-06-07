#include "BuildEnvironmentResource.h"
#include "SettingsDlg.h"

const TCHAR NPP_PLUGIN_NAME[] = TEXT("Tools Environment");

int IDD_Directory_Settings = IDDDIR;
ENVVAR ENVVAR_Directory_Settings[] =
{
    { ID_DIRFIL_FBOX, -1, ID_DIRFIL_BTTN, "DIRFIL", NULL, NULL },
    { ID_PRJDIR_DBOX, ID_PRJDIR_BTTN, -1, "PRJDIR", NULL, "PRJDRV" },
    { ID_TLSDIR_DBOX, ID_TLSDIR_BTTN, -1, "TLSDIR", NULL, "TLSDRV" },
    { ID_TMPDIR_DBOX, ID_TMPDIR_BTTN, -1, "TMPDIR", NULL, "TMPDRV" },
    { ID_BATDIR_DBOX, ID_BATDIR_BTTN, -1, "BATDIR", NULL, "BATDRV" },
    { ID_TGZDIR_DBOX, ID_TGZDIR_BTTN, -1, "TGZDIR", NULL, "TGZDRV" },
    { ID_CYGDIR_DBOX, ID_CYGDIR_BTTN, -1, "CYGDIR", NULL, "CYGDRV" },
    { ID_SCRDIR_CBOX, -1, -1, "SCRDIR", NULL, NULL },
    { ID_LUADIR_CBOX, -1, -1, "LUADIR", NULL, NULL },
    { ID_TTLEXE_FBOX, -1, ID_TTLEXE_BTTN, "TTLEXE", NULL, NULL },
    { ID_PLKEXE_FBOX, -1, ID_PLKEXE_DBOX, "PLKEXE", NULL, NULL },
    { ID_PCPEXE_FBOX, -1, ID_PCPEXE_BTTN, "PCPEXE", NULL, NULL },
    { ID_PYTEXE_FBOX, -1, ID_PYTEXE_BTTN, "PYTEXE", NULL, NULL },
    { ID_MAPDRV_CBOX, -1, -1, "MAPDRV", NULL, NULL },
    { ID_HOMDRV_CBOX, -1, -1, "HOMDRV", NULL, NULL },
    { -1, -1, -1, NULL, NULL, NULL }
};

int IDD_Build_Settings = IDDBLD;
ENVVAR ENVVAR_Build_Settings[] =
{
    { ID_BLDFIL_FBOX, -1, ID_BLDFIL_BTTN, "BLDFIL", NULL, NULL },
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
    { ID_DBSHAN_FBOX, -1, ID_DBSHAN_BTTN, "DBSHAN", NULL, NULL },
    { -1, -1, -1, NULL, NULL, NULL }
};

int IDD_Miscellaneous_Settings = IDDMSC;
ENVVAR ENVVAR_Miscellaneous_Settings[] =
{
    { ID_MSCFIL_FBOX, -1, ID_MSCFIL_BTTN, "MSCFIL", NULL, NULL },
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

ENVSET envsetlst[nbFunc] =
{
    { TEXT("Directory Settings"), SettingsDlg(IDD_Directory_Settings, ENVVAR_Directory_Settings) },
    { TEXT("Build Settings"), SettingsDlg(IDD_Build_Settings, ENVVAR_Build_Settings) },
    { TEXT("Miscellaneous Settings"), SettingsDlg(IDD_Miscellaneous_Settings, ENVVAR_Miscellaneous_Settings) }
};
