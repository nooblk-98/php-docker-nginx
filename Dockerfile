FROM php:8.2-fpm-alpine

# Install nginx and required packages
RUN apk add --no-cache nginx bash curl nano  wget

# PHP extension installer
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install required PHP extensions
RUN install-php-extensions gd \
    xdebug \
    redis \
    mysqli \
    pdo \
    pdo_mysql \
    mbstring \
    curl \
    xml \
    zip \
    json \
    fileinfo \
    dom \
    opcache \
    phar \
    iconv \
    tokenizer \
    simplexml \
    intl \
    exif \
    imagick \
    soap \
    bcmath

# Copy nginx config
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Create working directory
WORKDIR /var/www/html

# copy sample
COPY sample/index.html index.html

# Copy custom entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose web port
EXPOSE 80

# Use custom entrypoint to launch both services
ENTRYPOINT ["entrypoint.sh"]
