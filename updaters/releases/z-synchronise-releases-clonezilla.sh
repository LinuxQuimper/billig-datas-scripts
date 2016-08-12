#!/bin/bash
#
# Synchronise deux répertoires en utilisant FTP

. /usr/local/bin/check-process-once.sh

HOST="free.nchc.org.tw"
LOCALDIR="/mnt/datas/releases_auto/clonezilla"
REMOTEDIR="/clonezilla-live/stable"
EXCLUDED="*.*~"

function Usage()
{
  echo -e "\n  Synchronise un répertoire local avec un répertoire distant en utilisant FTP";  
  echo -e "\n  USAGE: ftpsync local_dir";
  echo;
}

if [ "$LOCALDIR" = "" ]
then
  echo -e "  ERREUR: Veuillez spécifier un répertoire local";
  Usage;
  exit 1;
fi

if [ -e "$LOCALDIR" ]
then
  lftp -c "set ftp:list-options -a;
  open ftp://$HOST; 
  lcd $LOCALDIR;
  cd $REMOTEDIR;
  mirror --delete \
         --verbose \
         --exclude-glob $EXCLUDED";
fi
