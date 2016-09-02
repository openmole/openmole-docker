
INSTANCE=openmole_$1

PORT=`docker inspect --format='{{(index (index .NetworkSettings.Ports "8888/tcp") 0).HostPort}}' $INSTANCE`

echo $PORT
