# ベースイメージの選択
FROM alpine:3.17

# 環境変数の設定
ENV WORDPRESS_VERSION 5.8.3
ENV WORDPRESS_SHA1 c0cda8da15ac9e1c58d90f26e92ff2f1e99cf27d

# 必要なパッケージのインストールと設定
RUN apk update && \
    apk add curl \
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

# WordPressのダウンロードと展開
RUN curl -O https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz && \
    tar -xzf wordpress-${WORDPRESS_VERSION}.tar.gz && \
    rm wordpress-${WORDPRESS_VERSION}.tar.gz && \
    mkdir -p /var/www/ && \
    mv wordpress /var/www/html && \
    chown -R nobody:nobody /var/www/html && \
    chown -R nobody:nobody /var/log/php81

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
