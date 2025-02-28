FROM dunglas/frankenphp:php8.3-alpine

COPY ./Caddyfile /etc/caddy/Caddyfile
COPY . /app

WORKDIR /app

RUN install-php-extensions @composer intl

RUN composer install \
    --ignore-platform-reqs \
    --optimize-autoloader \
    --prefer-dist \
    --no-interaction \
    --no-progress \
    --no-scripts \
    --no-suggest \
    --no-dev

RUN php artisan storage:link

ARG USER=${USER}

RUN \
    # Use "adduser -D ${USER}" for alpine based distros
    adduser -D ${USER}; \
    # Add additional capability to bind to port 80 and 443
    setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/frankenphp; \
    # Give write access to /data/caddy and /config/caddy
    chown -R ${USER}:${USER} /data/caddy && chown -R ${USER}:${USER} /config/caddy && chown -R ${USER}:${USER} /app

USER ${USER}

