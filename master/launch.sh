
SCRIPT=`readlink -f $0`
DIR=`dirname $SCRIPT`

VOLUME=openmole_$1
INSTANCE=openmole_$1

PORT=$2

shift
shift

docker volume create --name $VOLUME
docker run --security-opt "seccomp:$DIR/seccomp.json" --name $INSTANCE -h openmole --restart=always -p $PORT:8888 -id -v $VOLUME:/var/openmole -t openmole:latest $@

PORT=`docker inspect --format='{{(index (index .NetworkSettings.Ports "8888/tcp") 0).HostPort}}' $INSTANCE`

echo https://`hostname`:$PORT
