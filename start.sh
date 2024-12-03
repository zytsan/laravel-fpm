#!/bin/bash

#copy file .env.example ke .env

cp .env.example .env

php artisan key:generate

sed -i 's/DB_HOST=.*/DB_HOST=mydb/' .env
sed -i 's/DB_DATABASE=.*/DB_DATABASE=perpusku_gc/' .env
sed -i 's/DB_USERNAME=.*/DB_USERNAME=sansanstudy/' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=tsaniajuara1/' .env

php artisan migrate
php artisan db:seed

#Clear cache log laravel
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

mkdir -p /var/www/html/storage/logs/
chmod 775 /var/www/html/storage/logs/
chown -R www-data:www-data /var/www/html/storage/logs/

php-fpm
