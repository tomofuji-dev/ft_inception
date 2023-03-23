# Use the official Nginx Alpine image as the base image
FROM alpine:3.17

ENV NGINX_VERSION 1.22.1
ENV PKG_RELEASE   0

# Install Nginx with the specified version
RUN set -x \
    && apk add --no-cache nginx=${NGINX_VERSION}-r${PKG_RELEASE} \
    # Forward request and error logs to docker log collector
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Copy custom configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copy static content
# COPY tools/html /usr/share/nginx/html
COPY ssl/server.crt /etc/nginx/ssl/server.crt
COPY ssl/server.key /etc/nginx/ssl/server.key

# Expose port 443 for HTTPS
EXPOSE 443

# Set the stop signal for graceful shutdown
STOPSIGNAL SIGQUIT

# Set entrypoint
COPY tools/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# Start Nginx in the foreground to keep the container running
CMD ["nginx", "-g", "daemon off;"]
