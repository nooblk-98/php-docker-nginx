#!/bin/sh

# Start supervisor services (e.g., nginx, php-fpm)
exec supervisord -c /etc/supervisord.conf

# # Start PHP-FPM
# echo "Starting PHP-FPM..."
# php-fpm -D

# # Start Nginx in foreground
# echo "Starting Nginx..."
# exec nginx -g "daemon off;"
