NGX_DIR			:=	srcs/requirements/nginx
NGX_IMAGE		:=	nginx_img
NGX_CONTAINER	:=	nginx_container
SSL_DIR			:=	$(NGX_DIR)/ssl
SSL_KEY			:=	$(SSL_DIR)/server.key
SSL_CRT			:=	$(SSL_DIR)/server.crt

all:	$(SSL_KEY) $(SSL_CRT)

$(SSL_KEY):

$(SSL_CRT):	$(SSL_KEY)
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(SSL_KEY) -out $(SSL_CRT) -subj "/C=JA/ST=Tokyo/L=Minato/O=42/CN=localhost"

rm_nginx:
	docker container rm -f $(NGX_CONTAINER)
	docker image rm -f $(NGX_IMAGE)

nginx:	$(SSL_KEY) $(SSL_CRT)
	docker build -t $(NGX_IMAGE) $(NGX_DIR)
	docker run -d --name $(NGX_CONTAINER) -p 443:443 $(NGX_IMAGE)
