#!/bin/bash
DIR=/home/teamspeak/teamspeak/
TS3=ts3server_startscript.sh
USER=teamspeak
NOW=$(date "+%Y-%m-%d-%H%M%S")

#CORRECT USAGE
if [ $# -ne 1 ] || [ $EUID != 0 ]; then
    echo "USAGE: sudo $0 http://....teamspeak3-server_linux-x86-3.x.xx.x.tar.gz "
        exit
fi


cd $DIR && sudo -u $USER ./$TS3 stop
tar --exclude='./backup' -zcvf backup/backup-$NOW.tar.gz . && wget $1 && tar -zxvf ${1##*/} --strip 1 && rm -rf ${1##*/}
sudo -u $USER ./$TS3 start
