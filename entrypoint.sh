#!/bin/sh

# Start php-fpm and nginx via supervisor
mkdir -p /run/nginx

# Start php-fpm in background
php-fpm &

# Start nginx in foreground
nginx -g "daemon off;"
