FROM dunglas/frankenphp:php8.4-alpine

COPY ./Caddyfile /etc/frankenphp/Caddyfile

WORKDIR /app

RUN install-php-extensions @composer intl

# Copy only dependency files first for better layer caching
# This layer is only rebuilt when composer.json or composer.lock changes
COPY composer.json composer.lock /app/

RUN composer install \
    --optimize-autoloader \
    --prefer-dist \
    --no-interaction \
    --no-progress \
    --no-scripts \
    --no-dev

# Now copy the rest of the application
COPY . /app

# Run post-install steps that require the full app to be present
RUN php artisan package:discover --ansi
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
