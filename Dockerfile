FROM php:8.2-cli-alpine

# php extention installer 
ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install PM2 and Node.js
RUN apk add --no-cache nodejs npm bash nginx

# Install pm2 globally
RUN npm install -g pm2

# Copy PM2 config
COPY system/ecosystem.config.js /app/ecosystem.config.js

# install basic required php extentions 
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
    gd \
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

WORKDIR /app

# Copy source code, config, nginx conf
COPY /nginx/nginx.conf  /app/

# Create nginx log dirs
RUN mkdir -p /var/log/nginx && \
    mkdir -p /run/nginx && \
    touch /var/run/php-fpm.pid# Create nginx log dirs
RUN mkdir -p /var/log/nginx && \
    mkdir -p /run/nginx && \
    touch /var/run/php-fpm.pid

# Copy nginx config to default location
RUN mkdir -p /etc/nginx && cp /app/nginx.conf /etc/nginx/nginx.conf

# Expose HTTP port
EXPOSE 80

# Start PM2 with the provided config file
ENTRYPOINT ["pm2-runtime", "ecosystem.config.js"]