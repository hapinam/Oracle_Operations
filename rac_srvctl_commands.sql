srvctl stop database -d HARPEODS
srvctl start database -d HARPEODS
srvctl stop listener

srvctl config vip -n qnbp01rep01
srvctl config database -v