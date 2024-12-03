FROM php:7.2-fpm

#Install dependemcie
RUN apt update && apt install -y \
        libpng-dev \
        libonig-dev \
        libxml2-dev \
        zip \
        unzip \
        && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

#install composer install
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
        && composer self-update --2

WORKDIR /var/www/html/

COPY . .

RUN composer update && composer install

RUN chmod 775 -R storage/* bootstrap/cache/*  public/* \
        && chown -R www-data:www-data /var/www/html \
	&& chown -R www-data:www-data storage/* \
	&& chown -R www-data:www-data bootstrap/cache* 

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh && chown www-data /usr/local/bin/start.sh

USER www-data

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/start.sh"]              

