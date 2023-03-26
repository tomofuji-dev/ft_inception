#!/bin/sh
set -eu -o pipefail
# wp config create \
# 	--dbname="${DB_NAME}" \
# 	--dbuser="${DB_USER}" \
# 	--dbpass="${DB_PASS}" \
# 	--dbhost="${DB_HOST}" \
# 	--path="${WP_PATH}" \
# 	--allow-root
# wp db create
# wp core install \
# 	--url="${WP_URL}" \
# 	--title="${WP_TITLE}" \
# 	--admin_user="${WP_ADMIN_USER}" \
# 	--admin_password="${WP_ADMIN_PASS}" \
# 	--admin_email="${WP_ADMIN_EMAIL}" \
# 	--path="${WP_PATH}" \
# 	--allow-root
# wp user create \
# 	"${WP_EDITOR_USER}" \
# 	"${WP_EDITOR_EMAIL}" \
# 	--user_pass="${WP_EDITOR_PASS}" \
# 	--role=editor \
# 	--path="${WP_PATH}" \
# 	--allow-root
exec "$@"