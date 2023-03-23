# ベースイメージの選択
FROM alpine:3.17

# 環境変数の設定
ENV WORDPRESS_VERSION 5.8.3
ENV WORDPRESS_SHA1 c0cda8da15ac9e1c58d90f26e92ff2f1e99cf27d

# 必要なパッケージのインストールと設定
RUN apk update && \
    apk add --no-cache \
        curl \
        php \
        php-fpm \
        php-json \
        php-mbstring \
        php-mysqli \
        php-phar \
        php-tokenizer \
        php-openssl \
        php-curl \
        mariadb-client

ENV WP_CLI_GPG_KEY 63AF7AA15067C05616FDDD88A3A2E8F226F0BC06
ENV WP_CLI_VERSION 2.7.1
ENV WP_PATH /var/www/html

# WordPressのダウンロードと展開
RUN apk add --no-cache --virtual .fetch-deps gnupg && \
    mkdir -p /var/www/ && \
	curl -o /usr/local/bin/wp.gpg -fL "https://github.com/wp-cli/wp-cli/releases/download/v${WP_CLI_VERSION}/wp-cli-${WP_CLI_VERSION}.phar.gpg" && \
	GNUPGHOME="$(mktemp -d)" && export GNUPGHOME && \
	gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "$WP_CLI_GPG_KEY" && \
	gpg --batch --decrypt --output /usr/local/bin/wp /usr/local/bin/wp.gpg && \
	gpgconf --kill all && \
	rm -rf "$GNUPGHOME" /usr/local/bin/wp.gpg && unset GNUPGHOME && apk del --no-network .fetch-deps && \
	chmod +x /usr/local/bin/wp && \
    chown -R nobody:nobody /var/log/php81 && \
    wp core download --allow-root --path="${WP_PATH}"

# PHP-FPMの設定
COPY conf/php-fpm.conf /etc/php81/php-fpm.d/www.conf

# ポートとユーザーを指定
EXPOSE 9000
USER nobody

# エントリーポイントを指定
COPY tools/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# PHP-FPMを実行
CMD ["php-fpm81", "-F"]
