docker pull jsperf/jsperf.com:master
. /etc/environment
dbservice=$(docker ps --filter name=db  --format "{{.Names}}")
timestamp=$(date +'%Y%m%d-%H-%M-%S')
services=$(docker ps --filter name=web  --format "{{.Names}}")
enum=1
for service in $services; do
  docker stop $service
  docker rm $service
  docker run -d --name 'jsperfcom_web_'$timestamp'_'$enum -P \
    --link jsperfcom_db_1:db \
    --env-file /home/docker/.pam_environment \
    jsperf/jsperf.com:master
  enum=$((enum+1))
done
