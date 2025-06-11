#!/bin/sh

# Start supervisor services (ginx, php-fpm)
exec supervisord -c /etc/supervisord.conf
