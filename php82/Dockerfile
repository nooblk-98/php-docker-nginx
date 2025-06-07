# Use PHP 8.2 FPM Alpine image
FROM php:8.2-fpm-alpine

# Environment variables
ENV PHP_MEMORY_LIMIT=256M \
    PHP_UPLOAD_MAX_FILESIZE=64M \
    PHP_POST_MAX_SIZE=64M \
    PHP_MAX_EXECUTION_TIME=300

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    nginx \
    curl \
    curl-dev \
    bash \
    supervisor \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    freetype-dev \
    oniguruma-dev \
    libxml2-dev \
    icu-dev \
    imagemagick-dev \
    pkgconfig \
    autoconf \
    g++ \
    make \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install \
        mysqli \
        pdo \
        pdo_mysql \
        gd \
        mbstring \
        xml \
        curl \
        zip \
        fileinfo \
        tokenizer \
        opcache \
        dom \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del g++ make autoconf pkgconfig

# Set working directory
WORKDIR /var/www/html

# Download and install WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Copy custom entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy custom config files (optional - provide your own if needed)
# COPY nginx.conf /etc/nginx/nginx.conf
# COPY php.ini /usr/local/etc/php/conf.d/custom.ini
# COPY supervisord.conf /etc/supervisord.conf

# Expose HTTP port
EXPOSE 80

# Start the custom entrypoint
CMD ["/entrypoint.sh"]
