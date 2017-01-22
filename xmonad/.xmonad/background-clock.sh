LOCKFILE=/tmp/background-clock.sh.lock

if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
  echo "already running"
  exit
fi

# make sure the lockfile is removed when we exit and then claim it
trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

while true; do
  convert /home/db/images/background.jpg -gravity SouthWest -font Roboto-Bold -fill "rgba(255,255,255,0.25)" -pointsize 40 -annotate +100+35 "`date +%Y–%m–%d`" -fill "rgba(255,255,255,0.5)" -annotate +370+35 "`date +%H:%M`" /home/db/images/background-clock.jpg
  feh --bg-scale /home/db/images/background-clock.jpg
  sleep 15s
done
