# Usa una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    zip unzip \
    && docker-php-ext-install pdo pdo_sqlite

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia el código al contenedor
COPY . /var/www/html

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Configura Apache para usar public como root
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Copia archivo .htaccess si no existe
COPY ./public/.htaccess /var/www/html/public/.htaccess

# Instalar dependencias de PHP con Composer
RUN composer install --no-dev --optimize-autoloader

# Puerto para Render
EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
