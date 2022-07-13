FROM ubuntu:20.04


RUN mkdir php-code

WORKDIR php-code

COPY . /php-code/

RUN apt-get update

RUN apt-get install -y nginx-full curl net-tools supervisor libpcre3-dev php-pear

RUN curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | bash

RUN apt-get install -y unzip php7.4 php7.4-dev php7.4-bcmath php7.4-cli php7.4-common php7.4-curl php7.4-fpm php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-pgsql php7.4-readline php7.4-xml  php7.4-zip php7.4-phalcon

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php

RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN composer install

RUN mkdir -p /var/run/php
RUN mkdir -p /var/log/php-fpm

RUN chmod -R 777 var/cache var/logs

RUN service nginx stop

EXPOSE 8080