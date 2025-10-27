
# PHP Docker Nginx Stack

<div align="center">

[![Build Status](https://img.shields.io/github/actions/workflow/status/nooblk-98/php-docker-nginx/build-all-php.yml?branch=main&style=for-the-badge&logo=github)](https://github.com/nooblk-98/php-docker-nginx/actions)
[![Docker Pulls](https://img.shields.io/docker/pulls/nooblk-98/php-docker-nginx?style=for-the-badge&logo=docker)](https://hub.docker.com/r/nooblk-98/php-docker-nginx)
[![License](https://img.shields.io/github/license/nooblk-98/php-docker-nginx?style=for-the-badge)](LICENSE)
[![GitHub Stars](https://img.shields.io/github/stars/nooblk-98/php-docker-nginx?style=for-the-badge&logo=github)](https://github.com/nooblk-98/php-docker-nginx/stargazers)

**Production-ready PHP-FPM + Nginx Docker containers for modern web applications**

*Supporting WordPress, Laravel, Symfony, CodeIgniter, and any PHP application*

[**Quick Start**](#quick-start) • [**Available Images**](#available-php-versions) • [**Usage**](#usage-examples) • [**Performance**](#performance-optimizations)

</div>

---

## **Why Choose This Stack?**

**Production-Ready** → Optimized for high-traffic applications with enterprise-grade security  
**High Performance** → Pre-configured with OPcache, Gzip compression, and optimized Nginx  
**Zero Configuration** → Works out-of-the-box for most PHP applications  
**Multi-Architecture** → Native support for AMD64 and ARM64 (Apple Silicon, AWS Graviton)  
**Auto-Updated** → Monthly security updates and latest patches  
**Framework Agnostic** → Perfect for WordPress, Laravel, Symfony, or custom PHP apps  

---

## **Available PHP Versions**

| Version | Status | Base Image | Size | Multi-Arch |
|---------|--------|------------|------|------------|
| **PHP 8.3** | Latest | `php:8.3-fpm-alpine` | ~150MB | AMD64/ARM64 |
| **PHP 8.2** | Stable | `php:8.2-fpm-alpine` | ~150MB | AMD64/ARM64 |
| **PHP 8.1** | LTS | `php:8.1-fpm-alpine` | ~150MB | AMD64/ARM64 |
| **PHP 7.4** | Legacy | `php:7.4-fpm-alpine` | ~145MB | AMD64/ARM64 |
| **PHP 7.2** | Legacy | `php:7.2-fpm-alpine` | ~140MB | AMD64/ARM64 |
| **PHP 5.6** | EOL | `php:5.6-fpm-alpine` | ~130MB | AMD64/ARM64 |

### **Pull Commands**

```bash
# Latest (PHP 8.3)
docker pull ghcr.io/nooblk-98/php-docker-nginx:latest
docker pull nooblk-98/php-docker-nginx:latest

# Specific versions
docker pull ghcr.io/nooblk-98/php-docker-nginx:php83
docker pull ghcr.io/nooblk-98/php-docker-nginx:php82
docker pull ghcr.io/nooblk-98/php-docker-nginx:php81
docker pull ghcr.io/nooblk-98/php-docker-nginx:php74
docker pull ghcr.io/nooblk-98/php-docker-nginx:php72
docker pull ghcr.io/nooblk-98/php-docker-nginx:php56
```

---

## **Quick Start**

### **Launch a Web Server**
```bash
# Start with your project files
docker run -d -p 80:80 -v $(pwd):/var/www/html ghcr.io/nooblk-98/php-docker-nginx:latest

# Access your application at http://localhost
```

### **Use as Base Image**
```dockerfile
FROM ghcr.io/nooblk-98/php-docker-nginx:php82

# Copy your application
COPY . /var/www/html

# Install Composer dependencies (if needed)
RUN composer install --no-dev --optimize-autoloader

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html
```

---

## **Complete Feature Set**

### **Built-in Components**
- **Nginx** - High-performance web server with optimized configuration
- **PHP-FPM** - FastCGI Process Manager for superior performance  
- **Supervisor** - Process management and auto-restart capabilities
- **Security** - Non-root user, minimal attack surface
- **Logging** - Structured logs to stdout/stderr for container orchestration

### **Pre-installed PHP Extensions**

#### **Core Extensions**
```
PDO, PDO_MySQL, MySQLi    → Database connectivity
MBString, Iconv           → Multi-byte string handling  
cURL, JSON, XML           → API integrations
Zip, FileInfo            → File processing
Tokenizer, SimpleXML     → XML/Token parsing
```

#### **Advanced Extensions**
```
GD, Imagick              → Image processing & manipulation
OPcache                  → Performance optimization
Redis                    → Caching and session storage
XDebug                   → Development and debugging
SOAP, BCMath             → Web services & calculations
Intl, EXIF               → Internationalization & metadata
```

#### **Framework-Specific**
```
DOM, PHAR                → Laravel, Symfony support
PCNTL                    → Process control for queues
OpenSSL                  → Encryption & certificates
```

---

## **Performance Optimizations**

### **PHP Optimizations**
- **OPcache** enabled with production-ready settings
- **Memory limits** optimized for web applications
- **Process management** tuned for concurrent requests
- **Error handling** configured for production

### **Nginx Optimizations**  
- **Gzip compression** for faster page loads
- **Browser caching** headers for static assets
- **Worker processes** optimized for container environment
- **Keep-alive connections** for reduced latency

### **Container Optimizations**
- **Alpine Linux** base for minimal footprint
- **Multi-stage builds** for smaller images
- **Layer caching** for faster deployments
- **Health checks** for orchestration platforms

---

## **Usage Examples**

### **WordPress Application**
```bash
# Run WordPress with persistent data
docker run -d \
  -p 80:80 \
  -v wordpress_data:/var/www/html \
  -e WORDPRESS_DB_HOST=db \
  -e WORDPRESS_DB_NAME=wordpress \
  ghcr.io/nooblk-98/php-docker-nginx:php81
```

### **Laravel Application**
```dockerfile
FROM ghcr.io/nooblk-98/php-docker-nginx:php82

# Set document root for Laravel
RUN sed -i 's|root /var/www/html;|root /var/www/html/public;|' /etc/nginx/nginx.conf

# Copy application
COPY . /var/www/html

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
```

### **Production Docker Compose**
```yaml
version: '3.8'
services:
  web:
    image: ghcr.io/nooblk-98/php-docker-nginx:php82
    ports:
      - "80:80"
    volumes:
      - ./app:/var/www/html
    environment:
      - PHP_MEMORY_LIMIT=256M
    depends_on:
      - database
      - redis

  database:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: secure_password
      MYSQL_DATABASE: app_db
    volumes:
      - db_data:/var/lib/mysql

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data

volumes:
  db_data:
  redis_data:
```

---

## **Development Workflow**

### **Local Development**
```bash
# Hot-reload development
docker run -d -p 80:80 \
  -v $(pwd):/var/www/html \
  -e PHP_DISPLAY_ERRORS=On \
  ghcr.io/nooblk-98/php-docker-nginx:php82
```

### **Testing Environment**
```bash
# Run with XDebug enabled
docker run -d -p 80:80 -p 9003:9003 \
  -v $(pwd):/var/www/html \
  -e XDEBUG_MODE=debug \
  -e XDEBUG_CLIENT_HOST=host.docker.internal \
  ghcr.io/nooblk-98/php-docker-nginx:php82
```

### **CI/CD Pipeline**
```yaml
# GitHub Actions example
- name: Test Application
  run: |
    docker run --rm -v ${{ github.workspace }}:/var/www/html \
      ghcr.io/nooblk-98/php-docker-nginx:php82 \
      php vendor/bin/phpunit
```

---

## **Security Features**

### **Container Security**
- **Non-root execution** - Runs as `www-data` user
- **Minimal base image** - Alpine Linux with security updates
- **No unnecessary packages** - Reduced attack surface
- **Read-only filesystem** support

### **PHP Security**
- **Disabled dangerous functions** - `exec`, `shell_exec`, etc.
- **Error disclosure protection** - No sensitive info in errors
- **File upload restrictions** - Size and type limitations
- **Session security** - Secure cookie settings

### **Nginx Security**
- **Hidden server tokens** - No version disclosure
- **Request size limits** - Protection against DoS
- **Security headers** - HSTS, Content-Type, etc.
- **Access log sanitization** - No sensitive data logging

---

## **Monitoring & Observability**

### **Health Checks**
```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1
```

### **Logging**
```bash
# View application logs
docker logs container_name

# Real-time log monitoring
docker logs -f container_name

# JSON structured logs
docker logs container_name 2>&1 | jq '.'
```

### **Debugging**
```bash
# Access container shell
docker exec -it container_name sh

# Check PHP configuration
docker exec container_name php -i

# Monitor processes
docker exec container_name ps aux
```

---

## **Production Deployment**

### **Kubernetes**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: php-app
  template:
    metadata:
      labels:
        app: php-app
    spec:
      containers:
      - name: php-app
        image: ghcr.io/nooblk-98/php-docker-nginx:php82
        ports:
        - containerPort: 80
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

### **Docker Swarm**
```yaml
version: '3.8'
services:
  app:
    image: ghcr.io/nooblk-98/php-docker-nginx:php82
    deploy:
      replicas: 3
      update_config:
        parallelism: 1
        delay: 10s
      restart_policy:
        condition: on-failure
    ports:
      - "80:80"
    networks:
      - app-network
```

---

## **Performance Benchmarks**

### **Speed Metrics**
- **Cold start**: < 2 seconds
- **Memory usage**: ~80MB baseline
- **Requests/second**: 1000+ (simple PHP script)
- **Image pull time**: ~30 seconds (cached layers)

### **Comparison**
| Metric | This Image | Official PHP | LAMP Stack |
|--------|------------|--------------|------------|
| Size | 150MB | 500MB+ | 1GB+ |
| Boot Time | 2s | 5s | 15s |
| Memory | 80MB | 200MB | 400MB |
| Security | Hardened | Basic | Complex |

---

## **Automated Updates**

### **Monthly Releases**
- **Automatic builds** on the 1st of every month
- **Security patches** from upstream images  
- **Extension updates** with latest versions
- **Vulnerability scanning** before release

### **Tagging Strategy**
- `latest` → PHP 8.3 (bleeding edge)
- `php83` → PHP 8.3.x (latest minor)
- `php82` → PHP 8.2.x (stable LTS)
- `php81` → PHP 8.1.x (extended support)

---

## **Contributing**

### **Report Issues**
- [GitHub Issues](https://github.com/nooblk-98/php-docker-nginx/issues)
- Include PHP version, error logs, and reproduction steps

### 💡 **Feature Requests**
- [GitHub Discussions](https://github.com/nooblk-98/php-docker-nginx/discussions)
- Propose new PHP extensions or optimizations

### 🔧 **Development**
```bash
# Clone repository
git clone https://github.com/nooblk-98/php-docker-nginx.git

# Build specific version
docker build -t test-image ./php82/

# Test the build
docker run -d -p 80:80 test-image
```

---

## 📞 **Support & Community**

### 💬 **Get Help**
- 📧 **Email**: [liyanagelsofficial@gmail.com](mailto:liyanagelsofficial@gmail.com)
- 🐛 **Issues**: [GitHub Issues](https://github.com/nooblk-98/php-docker-nginx/issues)
- 💭 **Discussions**: [GitHub Discussions](https://github.com/nooblk-98/php-docker-nginx/discussions)

### 🌟 **Show Your Support**
If this project helps you, please consider:
- ⭐ **Starring** the repository
- 🍴 **Forking** for your modifications  
- 📢 **Sharing** with your network
- 💰 **Sponsoring** future development

---

## 📄 **License**

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## 🙏 **Acknowledgments**

### 🔧 **Built With**
- [**Official PHP Images**](https://hub.docker.com/_/php) - Solid foundation
- [**mlocati/docker-php-extension-installer**](https://github.com/mlocati/docker-php-extension-installer) - Simplified extension management
- [**Alpine Linux**](https://alpinelinux.org/) - Secure and lightweight base
- [**Nginx**](https://nginx.org/) - High-performance web server
- [**Supervisor**](http://supervisord.org/) - Process management

### 👨‍💻 **Maintainer**
**Liyanage L.S.**  
Senior DevOps Engineer & Docker Specialist  
📧 liyanagelsofficial@gmail.com

---

<div align="center">

**⭐ Star this repository if it helped you! ⭐**

</div>
