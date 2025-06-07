Here is a complete and professional `README.md` for your **wp-production-stack** Docker container, structured to guide developers through usage, features, configuration, and customization:

---

````markdown
# 🚀 wp-production-stack

A **production-ready PHP-FPM + Nginx Docker container** designed for modern PHP applications such as **WordPress**, **Laravel**, and custom PHP stacks. Lightweight, secure, and built for performance.

---

## 📦 Stack Overview

- **PHP 8.2 (FPM mode)** on Alpine Linux
- **Nginx** with HTTP/1.1, Gzip, and caching
- **Custom entrypoint** for process supervision
- **Pre-installed essential PHP extensions**
- **Logs** redirected to `stdout` / `stderr` (Docker native)
- **Security-focused**: runs with minimal privileges
- **Optimized** for production environments

---

## 📁 Default Directory Structure

```text
/var/www/html            # Application root
/var/www/html/public     # Document root (served by Nginx)
````

By default, the container serves files from `/var/www/html/public`. This is ideal for frameworks like Laravel or custom apps with a `public` directory.

---

## 🛠 PHP Extensions

This image uses the excellent [mlocati/docker-php-extension-installer](https://github.com/mlocati/docker-php-extension-installer) to provide a simple way to install PHP extensions.

### ✅ Installed by default:

* `pdo`, `pdo_mysql`, `mysqli`, `mbstring`, `curl`, `json`, `xml`
* `fileinfo`, `dom`, `phar`, `iconv`, `zip`, `tokenizer`
* `simplexml`, `intl`, `exif`, `soap`, `bcmath`
* `gd`, `imagick`, `opcache`, `redis`, `xdebug`

### ➕ Add custom extensions:

Edit the Dockerfile and add:

```Dockerfile
RUN install-php-extensions pcntl redis zip imagick
```

---

## 🔧 Configuration Highlights

### 🖥️ Nginx

* Default `nginx.conf` is located at `/etc/nginx/nginx.conf`
* Root path is dynamically set to `/var/www/html/public` using:

  ```Dockerfile
  RUN sed -i 's|root /var/www/html;|root /var/www/html/public;|' /etc/nginx/nginx.conf
  ```

### ⚙️ Entrypoint (`/usr/local/bin/entrypoint.sh`)

```sh
#!/bin/sh
echo "Starting PHP-FPM..."
php-fpm -D

echo "Starting Nginx..."
exec nginx -g "daemon off;"
```

---

## 📦 How to Use

### 1. 🐳 Build the Docker Image

```bash
docker build -t wp-production-stack .
```

### 2. 🚀 Run the Container

```bash
docker run -d -p 80:80 wp-production-stack
```

By default, your app should be placed in `/var/www/html/public` (or mount your project there via volume).

### 3. 🔄 Develop with Live Code

Mount your local code:

```bash
docker run -d -p 80:80 -v $(pwd):/var/www/html wp-production-stack
```

---

## ⚙️ Environment-Specific Notes

* Default port: `80`
* PHP-FPM listens on: `127.0.0.1:9000`
* Logs:

  * Nginx access: `/var/log/nginx/access.log` → stdout
  * Nginx error: `/var/log/nginx/error.log` → stderr

---

## 🔐 Production Benefits

* ✅ **Lightweight** (Alpine base)
* ✅ **Secure** (non-root support, hardened config)
* ✅ **Fast** (Opcache, Gzip, static file caching)
* ✅ **Scalable** (drop into any Docker environment)
* ✅ **Developer-friendly** (easy to extend with Composer, Laravel, WordPress, etc.)

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
* Official [PHP Docker images](https://hub.docker.com/_/php)
* [Nginx Docker image](https://hub.docker.com/_/nginx)

---

```

---
