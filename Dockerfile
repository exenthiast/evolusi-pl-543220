# ==============================================================================
# STAGE 1: BUILDER
# Tahap membangun: Composer, build tools, dan kompilasi ekstensi
# ==============================================================================
FROM php:8.4-cli-alpine AS builder

WORKDIR /var/www/html

# Install build dependencies & compile PHP extensions
RUN apk add --no-cache \
    git \
    curl \
    unzip \
    libzip-dev \
    sqlite-dev \
    && docker-php-ext-install pdo pdo_sqlite zip pcntl

# Copy Composer binary from official image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# -------------------------------------------------------------
# DOCKER LAYER CACHING:
# Salin file dependensi composer terlebih dahulu
# -------------------------------------------------------------
COPY composer.json composer.lock ./

ENV COMPOSER_PROCESS_TIMEOUT=2000

# Install production dependencies only (no dev packages)
RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev --no-scripts

# Salin seluruh sisa source code aplikasi
COPY . .

# Generate optimized autoloader
RUN composer dump-autoload --optimize


# ==============================================================================
# STAGE 2: RUNNER (Production Runtime)
# Tahap runtime: Varian alpine ringan dan bersih dari tools build
# ==============================================================================
FROM php:8.4-cli-alpine AS runner

WORKDIR /var/www/html

# Install hanya runtime libraries minimal yang dibutuhkan aplikasi & healthcheck
RUN apk add --no-cache \
    curl \
    sqlite-libs \
    libzip

# Salin konfigurasi dan ekstensi PHP yang sudah terkompilasi dari stage builder
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/

# Salin source code aplikasi dan dependensi vendor dari stage builder
COPY --from=builder /var/www/html /var/www/html

# Konfigurasi runtime Laravel (.env, key, sqlite, permissions)
RUN cp .env.example .env \
    && php artisan key:generate --force \
    && touch database/database.sqlite \
    && chown -R www-data:www-data storage bootstrap/cache database .env \
    && chmod -R 775 storage bootstrap/cache database

# Keamanan: Jalankan container sebagai user non-root (bukan root)
USER www-data

EXPOSE 8000

# Pemantauan: Cek kesehatan container secara berkala
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD curl -f http://127.0.0.1:8000/ || exit 1

# Jalankan migrasi database & seeder otomatis, lalu jalankan server Laravel
CMD ["sh", "-c", "php artisan migrate --force --seed && php artisan serve --host=0.0.0.0 --port=8000"]
