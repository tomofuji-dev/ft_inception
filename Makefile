SSL_DIR	:=	srcs/requirements/nginx/ssl
SSL_KEY	:=	$(SSL_DIR)/server.key
SSL_CRT	:=	$(SSL_DIR)/server.crt

all:	$(SSL_KEY) $(SSL_CRT)

$(SSL_KEY):

$(SSL_CRT):	$(SSL_KEY)
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout $(SSL_KEY) -out $(SSL_CRT) -subj "/C=JA/ST=Tokyo/L=Minato/O=42/CN=localhost"

