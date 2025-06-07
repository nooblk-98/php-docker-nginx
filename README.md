# wp-production-stack
Production-ready WordPress Docker setup with Nginx and Linux-based containers.Production-ready WordPress Docker setup with Nginx and Linux-based containers.

sources - https://github.com/mlocati/docker-php-extension-installer


# Replace root path directly
RUN sed -i 's|root /var/www/html;|root /var/www/html/public;|' /etc/nginx/nginx.conf


