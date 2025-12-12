#!/bin/sh

# Set default values if not provided
PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:-128M}
PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE:-64M}
PHP_POST_MAX_SIZE=${PHP_POST_MAX_SIZE:-64M}
PHP_MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME:-30}
PHP_MAX_INPUT_TIME=${PHP_MAX_INPUT_TIME:-60}

# Create php.ini if it doesn't exist or update values
PHP_INI_DIR="/usr/local/etc/php/conf.d"
mkdir -p $PHP_INI_DIR

# Create custom php.ini with environment variables
cat > $PHP_INI_DIR/zz-custom.ini <<EOF
; Custom PHP Configuration from Environment Variables
memory_limit = ${PHP_MEMORY_LIMIT}
upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}
post_max_size = ${PHP_POST_MAX_SIZE}
max_execution_time = ${PHP_MAX_EXECUTION_TIME}
max_input_time = ${PHP_MAX_INPUT_TIME}
EOF

echo "Applied PHP configuration:"
echo "  memory_limit = ${PHP_MEMORY_LIMIT}"
echo "  upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}"
echo "  post_max_size = ${PHP_POST_MAX_SIZE}"
echo "  max_execution_time = ${PHP_MAX_EXECUTION_TIME}"
echo "  max_input_time = ${PHP_MAX_INPUT_TIME}"

# Start supervisor services (nginx, php-fpm)
exec supervisord -c /etc/supervisord.conf
