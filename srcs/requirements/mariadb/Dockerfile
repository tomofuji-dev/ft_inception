# ベースイメージを指定
FROM alpine:3.17

# 必要なパッケージをインストール
RUN apk update && \
    apk add --no-cache mariadb mariadb-client

# MariaDB の設定ファイルをコピー
COPY conf/my.cnf /etc/mysql/my.cnf

# MariaDB のデータディレクトリを作成
RUN rm -rf /var/lib/mysql && \
	mkdir -p /var/lib/mysql /run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

# ユーザーを mysql に変更
USER mysql

# MariaDB のデータディレクトリをボリュームとして指定
VOLUME /var/lib/mysql

# ポートを公開
EXPOSE 3306

# エントリーポイントを指定
COPY tools/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# コンテナ起動時に実行されるコマンドを設定
CMD ["mysqld"]