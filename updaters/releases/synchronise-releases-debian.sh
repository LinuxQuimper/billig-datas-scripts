#/bin/dash

. /usr/local/bin/check-process-once.sh


fatal() {
  echo "$1"
  exit 1
}

warn() {
  echo "$1"
}

# Find a source mirror near you which supports rsync on
#RSYNCSOURCE=rsync://debian.med.univ-tours.fr/debian-cd/current/
#RSYNCSOURCE=rsync://ftp.informatik.uni-frankfurt.de/debian-cd/current/
RSYNCSOURCE=rsync://mirrors.kernel.org/debian-cd/current/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/releases_auto/debian

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --block-size=8192 --delete \
  --exclude=source/ --exclude=iso-dvd --exclude=iso-bd --exclude=armel --exclude=list-dvd --exclude=bt-dvd --exclude=jigdo* --exclude=bt-cd* --exclude=list-cd* --exclude=multi-arch/ --exclude=alpha/ --exclude=arm/ --exclude=hppa/ --exclude=hurd/ --exclude=m68k/ --exclude=mips/ --exclude=mipsel/ --exclude=powerpc/ --exclude=s390/ --exclude=sh/ --exclude=sparc/ --include='*businesscard*.iso' --include='*netinst*.iso' --include='*CD-1.iso' --exclude='*.iso'  \
  --exclude=arm64/ --exclude=armhf/ --exclude=ppc64el/ --exclude=s390x/ \
  --stats \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


rm $LOCKSYNC

