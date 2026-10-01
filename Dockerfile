FROM php:8.3-cli-alpine

# Set working directory
WORKDIR /var/www/html

# Install system dependencies & PHP extensions needed by Laravel
RUN apk add --no-cache \
    git \
    curl \
    unzip \
    libzip-dev \
    sqlite-dev \
    && docker-php-ext-install pdo pdo_sqlite zip pcntl

# Copy Composer binary from official Composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# -------------------------------------------------------------
# DOCKER LAYER CACHING:
# 1. Salin HANYA file dependensi composer terlebih dahulu
# -------------------------------------------------------------
COPY composer.json composer.lock ./

# 2. Install dependensi vendor (layer ini di-cache selama composer tidak berubah)
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev --no-scripts

# -------------------------------------------------------------
# 3. Salin seluruh sisa kode aplikasi setelah dependensi diinstall
# -------------------------------------------------------------
COPY . .

# 4. Generate autoloader teroptimasi setelah seluruh kode aplikasi disalin
RUN composer dump-autoload --optimize

# 5. Konfigurasi runtime Laravel (.env, key, sqlite, permissions)
RUN cp .env.example .env \
    && php artisan key:generate --force \
    && touch database/database.sqlite \
    && chown -R www-data:www-data storage bootstrap/cache database \
    && chmod -R 775 storage bootstrap/cache database

EXPOSE 8000

# Jalankan migrasi database & seeder otomatis, lalu jalankan server Laravel
CMD ["sh", "-c", "php artisan migrate --force --seed && php artisan serve --host=0.0.0.0 --port=8000"]
