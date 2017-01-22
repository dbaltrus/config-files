LOCKFILE=/tmp/go-to-bed.sh.lock

if [ -e ${LOCKFILE} ] && kill -0 `cat ${LOCKFILE}`; then
  echo "already running"
  exit
fi

# make sure the lockfile is removed when we exit and then claim it
trap "rm -f ${LOCKFILE}; exit" INT TERM EXIT
echo $$ > ${LOCKFILE}

while true; do
  H=`date +%k`
  if ((22 <= H || H <= 4)); then
    systemctl hibernate
  fi
  sleep 15m
done
