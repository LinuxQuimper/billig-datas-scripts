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
#RSYNCSOURCE=rsync://ftp5.gwdg.de/pub/linux/archlinux/
RSYNCSOURCE=rsync://mirrors.kernel.org/archlinux/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/repositories/archlinux/

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats \
  --exclude="*.links.tar.gz*" \
  --exclude="/other" \
  --exclude="/sources" \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


# Find a source mirror near you which supports rsync on
#RSYNCSOURCE=rsync://ftp5.gwdg.de/pub/linux/archlinux/extra

# Define where you want the mirror-data to be on your mirror
#BASEDIR=/mnt/external/repositories/archlinux/extra

#if [ ! -d ${BASEDIR} ]; then
#  warn "${BASEDIR} does not exist yet, trying to create it..."
#  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
#fi
#
#rsync --recursive -v --progress --times --links --hard-links --delete \
#  --stats \
#  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."

rm $LOCKSYNC

