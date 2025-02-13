FROM dunglas/frankenphp:php8.3-alpine

COPY .            /app
COPY ./Caddyfile  /etc/caddy/Caddyfile

WORKDIR /app

RUN install-php-extensions @composer pcntl

RUN composer install \
    --ignore-platform-reqs \
    --optimize-autoloader \
    --prefer-dist \
    --no-interaction \
    --no-progress \
    --no-scripts

RUN php artisan storage:link

ENTRYPOINT ["php", "artisan", "octane:frankenphp"]
