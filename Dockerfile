FROM php:8.2-fpm-alpine

# --------------------------
# Metadata Labels
# --------------------------
LABEL maintainer="liyanagelsofficial@gmail.com"
LABEL version="1.0.0"
LABEL description="Production-ready PHP-FPM + Nginx image"

# Install nginx and required packages
RUN apk add --no-cache nginx bash curl nano  wget

# PHP extension installer
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install required PHP extensions
RUN install-php-extensions gd \
    xdebug \
    pcntl \
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

RUN mkdir -p /var/log/nginx /run/nginx /var/log/php && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Create working directory
WORKDIR /var/www/html

# copy sample
COPY sample/index.html ./index.html

# Copy custom entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN addgroup -S www && adduser -S www -G www
RUN chown -R www:www /var/www/html

RUN rm -rf /var/cache/apk/*


# Expose web port
EXPOSE 80

# Use custom entrypoint to launch both services
ENTRYPOINT ["entrypoint.sh"]
