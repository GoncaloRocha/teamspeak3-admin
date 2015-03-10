#!/bin/bash

TS3=/home/teamspeak/teamspeak
STARTSCRIPT=ts3server_startscript.sh
USER=teamspeak
NOW=$(date "+%Y-%m-%d-%H%M%S")

#CORRECT USAGE
if [ $# -ne 1 ] || [ $EUID != 0 ]; then
    echo "USAGE: sudo $0 http://....teamspeak3-server_linux-x86-3.x.xx.x.tar.gz "
        exit
fi


cd $TS3
su $USER -c "$STARTSCRIPT stop"
tar --exclude='./backup' -zcvf backup/backup-$NOW.tar.gz .
wget $1
tar -zxvf ${1##*/} .
rm -rf ${1##*/}
su $USER -c "$STARTSCRIPT start"
