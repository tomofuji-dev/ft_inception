# Use the official Nginx Alpine image as the base image
FROM nginx:alpine

# Copy custom configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copy static content
COPY tools/html /usr/share/nginx/html
COPY ssl/server.crt /etc/nginx/ssl/server.crt
COPY ssl/server.key /etc/nginx/ssl/server.key

# Expose port 443 for HTTPS
EXPOSE 443

# Start Nginx in the foreground to keep the container running
CMD ["nginx", "-g", "daemon off;"]