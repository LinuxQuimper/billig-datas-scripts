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
#HTTPSOURCE=http://surfnet.dl.sourceforge.net/project/manjarolinux/release/
#HTTPSOURCE=http://skylink.dl.sourceforge.net/project/manjarolinux/release/
HTTPSOURCE=http://freefr.dl.sourceforge.net/project/manjarolinux/release/

# Define where you want the mirror-data to be on your mirror
BASEDIR=/mnt/datas/releases_auto/manjaro

if [ ! -d ${BASEDIR} ]; then
  warn "${BASEDIR} does not exist yet, trying to create it..."
  mkdir -p ${BASEDIR} || fatal "Creation of ${BASEDIR} failed."
fi



cd ${BASEDIR}
wget -N -e robots=off --relative -m -np -nH --cut-dir=3 -p ${HTTPSOURCE}

rm $LOCKSYNC
