

# 🚀 php-production-stack

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

## 🖥️ Platform Support

✅ **Supports both ARM64 and AMD64 architectures**
This image is built with multi-architecture support and runs seamlessly on:

* Apple Silicon (M1/M2)
* AWS Graviton
* Intel/AMD-based servers and desktops

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

# Start supervisor services (ginx, php-fpm)
exec supervisord -c /etc/supervisord.conf
```

---

## 🐳 Docker Image Usage

### ✅ Pull the Prebuilt Image

```bash
docker pull ghcr.io/nooblk-98/php-docker-nginx:php82
```

### ▶️ Run the Container Directly

```bash
docker run -d -p 80:80 ghcr.io/nooblk-98/php-docker-nginx:php82
```

You can mount your project directory:

```bash
docker run -d -p 80:80 -v $(pwd):/var/www/html ghcr.io/nooblk-98/php-docker-nginx:php82
```

### 🧱 Use as a Base Image in Your Dockerfile

```Dockerfile
FROM ghcr.io/nooblk-98/php-docker-nginx:php82

# Copy your application code
COPY . /var/www/html

# Customize if needed
```

---

## 🚀 Build & Run from Source

### 1. Build the Docker Image

```bash
docker build -t wp-production-stack .
```

### 2. Run the Container

```bash
docker run -d -p 80:80 wp-production-stack
```

### 3. Run with Mounted Code (for Local Development)

```bash
docker run -d -p 80:80 -v $(pwd):/var/www/html wp-production-stack
```

---

## ⚙️ Environment Notes

* **Exposed Port:** `80`
* **PHP-FPM Listener:** `127.0.0.1:9000`
* **Logs:**

  * Access log → `stdout`
  * Error log → `stderr`

---

## 🔐 Production Benefits

- ✅ Lightweight (Alpine base)  
- ✅ Secure (non-root, hardened)  
- ✅ Fast (Opcache, Gzip)  
- ✅ Scalable (Docker-native)  
- ✅ Developer-friendly (WordPress, Laravel, Composer-ready)  
- ✅ Multi-architecture (ARM & AMD)

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
---
