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
# https://launchpad.net/ubuntu/+cdmirrors
# rsync://<iso-country-code>.releases.ubuntu.com/releases should always work
#RSYNCSOURCE=rsync://releases.ubuntu.com/releases

#RSYNCSOURCE=rsync://rsync.cdimage.ubuntu.com/cdimage/daily/current/
RSYNCSOURCE=rsync://rsync.cdimage.ubuntu.com/cdimage/daily-live/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/releases_auto/ubuntu-daily/alternate/

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats --exclude=source \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


RSYNCSOURCE=rsync://rsync.cdimage.ubuntu.com/cdimage/daily-live/current/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/releases_auto/ubuntu-daily/desktop/

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi

rsync --recursive -v --progress --times --links --hard-links --delete \
  --stats --exclude=source \
  ${RSYNCSOURCE} ${BASEDIR} || fatal "Failed to rsync from ${RSYNCSOURCE}."


rm $LOCKSYNC

