FROM php:8.1-fpm-alpine

# --------------------------
# Metadata Labels
# --------------------------
LABEL maintainer="liyanagelsofficial@gmail.com"
LABEL version="1.0.3"
LABEL description="Production-ready PHP-FPM + Nginx image"

# Install nginx and required packages
# Use --no-scripts to avoid QEMU emulation issues in multi-arch builds
RUN apk add --no-cache --no-scripts nginx bash curl nano wget supervisor && \
    # Manually create nginx user and directories since we skipped scripts
    addgroup -g 101 -S nginx 2>/dev/null || true && \
    adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx 2>/dev/null || true && \
    mkdir -p /var/lib/nginx /var/log/nginx /run/nginx && \
    chown -R nginx:nginx /var/lib/nginx /var/log/nginx /run/nginx

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

# Create supervisor directories
RUN mkdir -p /etc/supervisor/conf.d

# Copy supervisor configs
COPY supervisor/supervisord.conf /etc/supervisord.conf
COPY supervisor/conf.d/*.conf /etc/supervisor/conf.d/

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

RUN chown -R www-data:www-data /var/www/html


RUN rm -rf /var/cache/apk/*


# Expose web port
EXPOSE 80

# Use custom entrypoint to launch both services
ENTRYPOINT ["entrypoint.sh"]
