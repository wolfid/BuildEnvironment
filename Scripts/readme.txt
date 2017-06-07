This is a collection of some useful build scripts and various test tools.

Set-up is initialised by running setenv.bat which derives settings from
system dependent *.lst files that you to create.  There are *.def which
may be used as an example you can copy to - do not check these files in
- especially if it contains sensitive information.

setenv.bat creates bldenv.bat which may then be used to create the build
environment.  Its use depends on how the scripts are launched, it can be
called from other scripts or run first in a command window then the script of
your choice.  The directory to where environment details are stored may be
specified otherwise it defaults to this directory\Env.

build.bat compiles and creates a target distribution.

restart.bat restarts the target downloading any specified configuration
details in between stopping and starting.

                                                    WXD 07 Jan 2016