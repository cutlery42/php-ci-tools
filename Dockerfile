FROM php:8.2-cli as deps
RUN apt-get -y update \
&& apt-get install -y libicu-dev zlib1g-dev  libzip-dev  unzip \
&& docker-php-ext-configure intl \
&& docker-php-ext-install bcmath intl zip

WORKDIR /app
ENV COMPOSER_ALLOW_SUPERUSER=1
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY composer.json composer.lock /app/
RUN composer install

COPY . /app/
RUN vendor/bin/psalm