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
RSYNCSOURCE=rsync://download.tuxfamily.org/pub/slitaz/packages/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/repositories/slitaz

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats \
  --exclude=/pxe \
  --exclude=/ubcd \
  --exclude=/boot \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


RSYNCSOURCE=rsync://download.tuxfamily.org/pub/slitaz/pxe/
BASEDIR=/mnt/datas/repositories/slitaz/pxe
if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats --exclude=pxe/ubcd \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."

RSYNCSOURCE=rsync://download.tuxfamily.org/pub/slitaz/boot/
BASEDIR=/mnt/datas/repositories/slitaz/boot
if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."

rm $LOCKSYNC

