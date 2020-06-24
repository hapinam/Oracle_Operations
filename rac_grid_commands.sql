su - grid

vi grid_profile

export ORACLE_HOME=/u01/app/18.0.0.0/grid
export ORACLE_SID=+ASM1
export PATH=$ORACLE_HOME/bin:$PATH

. grid_profile

asmcmd

ASMCMD> lsdg
State    Type    Rebal  Sector  Logical_Sector  Block       AU   Total_MB   Free_MB  Req_mir_free_MB  Usable_file_MB  Offline_disks  Voting_files  Name
MOUNTED  NORMAL  N         512             512   4096  4194304    4829184     10920           134144          -61612              0             N  ACFSC2/
MOUNTED  HIGH    N         512             512   4096  4194304  113246464  23045448          6291456         5584608              0             Y  DATAC2/
MOUNTED  HIGH    N         512             512   4096  4194304   26214592    210544          1456352         -415346              0             N  RECOC2/
ASMCMD>


