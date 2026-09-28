FROM php:8.3-apache

RUN echo "max_input_vars = 5000" > /usr/local/etc/php/conf.d/moodle.ini

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libicu-dev \
    libzip-dev \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    libxslt1-dev \
    libssl-dev \
    libmagickwand-dev \
    unzip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo_mysql \
        gd \
        intl \
        mbstring \
        zip \
        soap \
        exif \
        opcache \
        xml \
        xsl \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && a2enmod rewrite \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www/html
