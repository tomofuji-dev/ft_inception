NGX_DIR			:=	srcs/requirements/nginx
NGX_IMAGE		:=	nginx_img
NGX_CONTAINER	:=	nginx_container
SSL_DIR			:=	$(NGX_DIR)/ssl
SSL_KEY			:=	$(SSL_DIR)/server.key
SSL_CRT			:=	$(SSL_DIR)/server.crt

all:	$(SSL_KEY) $(SSL_CRT) host dir
	make up

$(SSL_KEY):

$(SSL_CRT):	$(SSL_KEY)
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(SSL_KEY) -out $(SSL_CRT) -subj "/C=JA/ST=Tokyo/L=Minato/O=42/CN=tfujiwar.42.fr"

dir:
	mkdir -p ${HOME}/data/wp_vol ${HOME}/data/db_vol

host:
	grep -q tfujiwar.42.fr /etc/hosts || sudo echo "127.0.0.1 tfujiwar.42.fr" | sudo tee -a /etc/hosts

down:
	docker compose -f ./srcs/compose.yaml down --volumes
	rm -rf ${HOME}/data

up:
	docker compose -f ./srcs/compose.yaml up -d --build

clean:
	-docker stop $$(docker ps -qa)
	-docker rm $$(docker container ls -qa)
	-docker image rm $$(docker image ls -qa)
	-docker volume rm $$(docker volume ls -q)
	-docker network rm $$(docker network ls -q) 2> /dev/null
	-rm -rf ${HOME}/data

.PHONY: all host down up clean