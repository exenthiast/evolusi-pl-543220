#!/bin/bash
set -e

echo "=== Memulai Proses Deployment ==="

# 1. Mengaktifkan mode pemeliharaan (maintenance mode)
echo "Langkah 1: Mengaktifkan maintenance mode"
php artisan down || true

# 2. Menarik kode terbaru dari repository
echo "Langkah 2: Menarik kode terbaru dari branch main"
git pull origin main

# 3. Menginstal dependensi Composer
echo "Langkah 3: Menginstal dependensi Composer"
composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# 4. Menjalankan migrasi database
echo "Langkah 4: Menjalankan migrasi database"
php artisan migrate --force

# 5. Mengoptimalkan cache konfigurasi
echo "Langkah 5: Melakukan cache konfigurasi"
php artisan config:cache

# 6. Mengoptimalkan cache routing
echo "Langkah 6: Melakukan cache routing"
php artisan route:cache

# 7. Mematikan mode pemeliharaan (aplikasi aktif kembali)
echo "Langkah 7: Mematikan maintenance mode"
php artisan up

echo "=== Deployment Berhasil Selesai ==="
