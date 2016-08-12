#!/bin/bash

. /usr/local/bin/check-process-once.sh


## Setting variables with explanations.

#
# Don't touch the user's keyring, have our own instead
#
export GNUPGHOME=/home/mirrorkeyring

# Arch=         -a      # Architecture. For Ubuntu can be i386, powerpc or amd64.
# sparc, only starts in dapper, it is only the later models of sparc.
#
arch=i386,amd64

# Minimum Ubuntu system requires main, restricted
# Section=      -s      # Section (One of the following - main/restricted/universe/multiverse).
# You can add extra file with $Section/debian-installer. ex: main/debian-installer,universe/debian-installer,multiverse/debian-installer,restricted/debian-installer
#
section=updates/main,updates/contrib,updates/non-free

# Release=      -d      # Release of the system (Dapper, Edgy, Feisty, Gutsy, Hardy, Intrepid), and the -updates and -security ( -backports can be added if desired)
#
#release=hardy,hardy-updates,hardy-security,jaunty,jaunty-updates,jaunty-security,intrepid,intrepid-updates,intrepid-security
#release=jaunty,jaunty-updates,jaunty-security
release=jessie

# Server=       -h      # Server name, minus the protocol and the path at the end
# CHANGE "*" to equal the mirror you want to create your mirror from. au. in Australia  ca. in Canada.
# This can be found in your own /etc/apt/sources.list file, assuming you have Ubuntu installed.
#
server=security.debian.org

# Dir=          -r      # Path from the main server, so http://my.web.server/$dir, Server dependant
#
inPath=/debian-security

# Proto=        -e      # Protocol to use for transfer (http, ftp, hftp, rsync)
# Choose one - http is most usual the service, and the service must be avaialbe on the server you point at.
#
proto=http

# Outpath=              # Directory to store the mirror in
# Make this a full path to where you want to mirror the material.
#
outPath=/mnt/datas/repositories/debian-security/

# The --nosource option only downloads debs and not deb-src's
# The --progress option shows files as they are downloaded
# --source \ in the place of --no-source \ if you want sources also.
# --nocleanup  Do not clean up the local mirror after mirroring is complete. Use this option to keep older repository
# Start script
#


CMD="debmirror --i18n -a $arch --ignore-missing-release --no-source -s $section -h $server -d $release -r $inPath -v --progress --precleanup -e $proto --ignore-release-gpg $outPath"

echo "Lancement de la commande : "
echo $CMD

${CMD}


#### End script to automate building of Ubuntu mirror ####
rm $LOCKSYNC

