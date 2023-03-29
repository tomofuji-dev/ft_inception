#!/bin/sh
set -eu -o pipefail
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

docker_temp_server_start() {
  mysqld -uroot &
  local i
  for i in {10..0}; do
    if echo 'SELECT 1;' | mysql > /dev/null 2>&1; then
      break
    fi
    sleep 1
  done
}

docker_temp_server_start

if [ ! -d "/var/lib/mysql/wordpress" ]; then
  mysql << EOF
    CREATE DATABASE $DB_NAME;
    CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';
    GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%';
    ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';
    FLUSH PRIVILEGES;
EOF
fi

mysqladmin shutdown

exec "$@"