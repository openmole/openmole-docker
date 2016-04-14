
VOLUME=openmole_$1
INSTANCE=openmole_$1

docker volume create --name $VOLUME
docker run --name $INSTANCE -h openmole --restart=always -p 8888 -id -v $VOLUME:/var/openmole -t openmole:latest

PORT=`docker inspect --format='{{(index (index .NetworkSettings.Ports "8888/tcp") 0).HostPort}}' $INSTANCE`

echo https://`hostname`:$PORT
