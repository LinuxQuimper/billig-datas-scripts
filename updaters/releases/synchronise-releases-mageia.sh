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
RSYNCSOURCE=rsync://distrib-coffee.ipsl.jussieu.fr/pub/linux/Mageia/iso/4.1/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/releases_auto/mageia/2/

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --exclude='*Africa*' --exclude='*Asia*' --exclude='*DVD*' --exclude='*torrent*' \
  --stats \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


rm $LOCKSYNC

