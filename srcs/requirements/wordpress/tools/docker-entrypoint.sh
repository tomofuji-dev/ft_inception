#!/bin/sh
set -eu -o pipefail

wait_db_start() {
  local i
  for i in {10..0}; do
    echo 'SELECT 1;' | mysql -h mariadb -u"${DB_USER}" -p"${DB_PASS}" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
		break
    fi
    sleep 5
  done
}

install_wp() {
	wp config create \
		--dbname="${DB_NAME}" \
		--dbuser="${DB_USER}" \
		--dbpass="${DB_PASS}" \
		--dbhost=mariadb:3306 \
		--path="${WP_PATH}" \
		--allow-root
	wp core install \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASS}" \
		--admin_email="${WP_ADMIN_EMAIL}" \
		--path="${WP_PATH}" \
		--allow-root
	wp user create \
		"${WP_EDITOR_USER}" \
		"${WP_EDITOR_EMAIL}" \
		--user_pass="${WP_EDITOR_PASS}" \
		--role=editor \
		--path="${WP_PATH}" \
		--allow-root
}

wait_db_start

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
  install_wp
fi

exec "$@"