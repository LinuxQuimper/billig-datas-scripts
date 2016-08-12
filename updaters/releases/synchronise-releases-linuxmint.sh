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
RSYNCSOURCE=rsync://ftp5.gwdg.de/pub/linux/debian/mint/stable/17.1/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/releases_auto/linuxmint

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


rm $LOCKSYNC

