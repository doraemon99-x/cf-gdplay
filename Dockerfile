# Menggunakan image PHP resmi dengan Apache
FROM php:8.1-apache

# Menginstal ekstensi PHP yang dibutuhkan
RUN docker-php-ext-install pdo pdo_mysql

# Mengatur direktori kerja di dalam container
WORKDIR /var/www/html

# Menyalin file aplikasi dari repository ke dalam container
COPY . .

# Mengatur izin untuk direktori penyimpanan sementara dan log
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Mengatur konfigurasi Apache
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Mengaktifkan mod_rewrite untuk Apache
RUN a2enmod rewrite

# Menyalin dan menginstal Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Menginstal dependensi Composer
RUN composer install --no-interaction --no-dev --prefer-dist

# Menyalin file environment
COPY .env.example .env

# Menjalankan perintah untuk mengatur kunci aplikasi dan menjalankan migrasi
RUN php artisan key:generate && php artisan migrate --force

# Mengekspos port 80
EXPOSE 80

# Menjalankan Apache dalam mode foreground
CMD ["apache2-foreground"]
