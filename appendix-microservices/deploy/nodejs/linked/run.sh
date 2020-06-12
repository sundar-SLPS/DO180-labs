#!/bin/sh
sudo rm -rf work

if [ ! -d "work" ]; then
  echo -n "• Creating database volume: "
  mkdir -p work/init work/data
  cp db.sql work/init
  sudo semanage fcontext -a -t container_file_t $PWD'/work(/.*)?'
  sudo chown -R 27:27 work
  sudo restorecon -R $PWD/work
else
  sudo rm -fr work/init
fi
echo "OK"

echo -n "• Launching database: "
sudo podman run -d \
  --name mysql \
  -e MYSQL_DATABASE=items \
  -e MYSQL_USER=user1 \
  -e MYSQL_PASSWORD=mypa55 \
  -e MYSQL_ROOT_PASSWORD=r00tpa55 \
  -v $PWD/work/data:/var/lib/mysql/data \
  -v $PWD/work/init:/var/lib/mysql/init \
  -p 30306:3306 \
  rhscl/mysql-57-rhel7 &>/dev/null
echo "OK"

echo -n "• Importing database: "
until sudo podman exec -it mysql bash -c "mysql -u root -e 'show databases;'" &>/dev/null; do
  sleep 2
done

sudo podman exec mysql bash \
  -c "cat /var/lib/mysql/init/db.sql | mysql -u root items"
echo "OK"

echo -n "• Retrieving database container internal IP: "
MYSQL_SERVICE_HOST=$(sudo podman inspect mysql -f "{{.NetworkSettings.IPAddress}}") && \
echo "OK: ${MYSQL_SERVICE_HOST}"

echo -n "• Launching To Do application: "
sudo podman run -d \
  --name todoapi \
  -p 30080:30080 \
  -e MYSQL_DATABASE=items \
  -e MYSQL_USER=user1 \
  -e MYSQL_PASSWORD=mypa55 \
  -e MYSQL_SERVICE_HOST="${MYSQL_SERVICE_HOST}" \
  -e MYSQL_SERVICE_PORT=3306 \
  do180/todonodejs &>/dev/null

sudo podman run -d \
  --name todo_frontend \
  -p 30000:80 \
  do180/todo_frontend &>/dev/null
echo "OK"
