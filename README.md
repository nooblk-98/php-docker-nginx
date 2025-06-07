# 🚀 wp-production-stack

A **production-ready PHP-FPM + Nginx Docker container** designed for modern PHP applications such as **WordPress**, **Laravel**, and custom PHP stacks. Lightweight, secure, and built for performance.

---

## 📦 Stack Overview

* **PHP 8.2 (FPM mode)** on Alpine Linux
* **Nginx** with HTTP/1.1, Gzip, and caching
* **Custom entrypoint** for process supervision
* **Pre-installed essential PHP extensions**
* **Logs** redirected to `stdout` / `stderr` (Docker native)
* **Security-focused**: runs with minimal privileges
* **Optimized** for production environments

---

## 📁 Default Directory Structure

```text
/var/www/html             # Document root (served by Nginx)
```

By default, the container serves files from `/var/www/html`, but it supports `/var/www/html/public`, which is ideal for frameworks like Laravel or apps with a `public` directory.

---

## 🛠 PHP Extensions

This image uses the excellent [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer) for simplified extension management.

### ✅ Installed by Default

* `pdo`, `pdo_mysql`, `mysqli`, `mbstring`, `curl`, `json`, `xml`
* `fileinfo`, `dom`, `phar`, `iconv`, `zip`, `tokenizer`
* `simplexml`, `intl`, `exif`, `soap`, `bcmath`
* `gd`, `imagick`, `opcache`, `redis`, `xdebug`

### ➕ Add Custom Extensions

To add additional extensions, modify the Dockerfile:

```Dockerfile
RUN install-php-extensions pcntl redis zip imagick
```

---

## 🔧 Configuration Highlights

### 🖥️ Nginx

* Default config: `/etc/nginx/nginx.conf`
* Document root: `/var/www/html`

To change the default root (e.g., for Laravel):

```Dockerfile
RUN sed -i 's|root /var/www/html;|root /var/www/html/public;|' /etc/nginx/nginx.conf
```

### ⚙️ Entrypoint: `/usr/local/bin/entrypoint.sh`

```sh
#!/bin/sh
echo "Starting PHP-FPM..."
php-fpm -D

echo "Starting Nginx..."
exec nginx -g "daemon off;"
```

---

## 🚀 How to Use

### 1. Build the Docker Image

```bash
docker build -t wp-production-stack .
```

### 2. Run the Container

```bash
docker run -d -p 80:80 wp-production-stack
```

Place your app inside `/var/www/html/public` or mount your project directory.

### 3. Run with Mounted Code (for local development)

```bash
docker run -d -p 80:80 -v $(pwd):/var/www/html wp-production-stack
```

Or use this as a base image for your production-ready Laravel or WordPress container.

---

## ⚙️ Environment Notes

* **Exposed Port:** `80`
* **PHP-FPM Listener:** `127.0.0.1:9000`
* **Logs:**

  * Access log → `stdout`
  * Error log → `stderr`

---

## 🔐 Production Benefits

✅ Lightweight (Alpine base)
✅ Secure (non-root, hardened)
✅ Fast (Opcache, Gzip)
✅ Scalable (Docker-native)
✅ Developer-friendly (WordPress, Laravel, Composer-ready)

---

## 👨‍💻 Maintainer

**Liyanage L.S.**
📬 `liyanagelsofficial@gmail.com`

---

## 📄 License

MIT — free to use and modify.

---

## 🌐 Credits

* [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer)
* [Official PHP Docker image](https://hub.docker.com/_/php)
* [Official Nginx Docker image](https://hub.docker.com/_/nginx)

