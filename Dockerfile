# Dockerfile

# 1st stage : build js & css
FROM node:current-alpine3.15 as builder

ENV NODE_ENV=production
WORKDIR /app

ADD package.json yarn.lock webpack.config.js ./
ADD assets ./assets

RUN mkdir -p public && \
    NODE_ENV=development yarn install && \
    export NODE_OPTIONS=--openssl-legacy-provider && \
    yarn run build

FROM chibyjade/php-8.0:latest

# 2nd stage : build the real app container
EXPOSE 80
WORKDIR /app

# Default APP_VERSION, real version will be given by the CD server
ARG APP_VERSION=prod
ARG GIT_COMMIT=main
ARG POSTGRES_SERVER_VERSION=13
ARG POSTGRES_CHARSET=utf8
ARG POSTGRES_DRIVER=pdo_pgsql
ARG POSTGRES_HOST=database
ARG POSTGRES_PORT=5432
ARG POSTGRES_DB=main
ARG POSTGRES_USER=main
ARG POSTGRES_PASSWORD=main
ARG MESSENGER_TRANSPORT_DSN="doctrine://default?auto_setup=0"
ARG APP_MAINTENANCE=0
ARG APP_ENV=prod
ARG APP_SECRET=secret
ARG MAILER_DSN=smtp://localhost
ARG SLACK_DSN=default

ENV APP_VERSION=$APP_VERSION
ENV GIT_COMMIT=$GIT_COMMIT
ENV POSTGRES_SERVER_VERSION=$POSTGRES_SERVER_VERSION
ENV POSTGRES_CHARSET=$POSTGRES_CHARSET
ENV POSTGRES_DRIVER=$POSTGRES_DRIVER
ENV POSTGRES_HOST=$POSTGRES_HOST
ENV POSTGRES_PORT=$POSTGRES_PORT
ENV POSTGRES_DB=$POSTGRES_DB
ENV POSTGRES_USER=$POSTGRES_USER
ENV POSTGRES_PASSWORD=$POSTGRES_PASSWORD
ENV MESSENGER_TRANSPORT_DSN=$MESSENGER_TRANSPORT_DSN
ENV APP_MAINTENANCE=$APP_MAINTENANCE
ENV APP_ENV=$APP_ENV
ENV APP_SECRET=$APP_SECRET
ENV MAILER_DSN=$MAILER_DSN
ENV SLACK_DSN=$SLACK_DSN

COPY . /app
COPY --from=builder /app/public/build /app/public/build

RUN mkdir -p var && \
    composer install --prefer-dist --optimize-autoloader --classmap-authoritative --no-interaction --no-ansi --no-dev && \
    chmod +x bin/console && \
    bin/console cache:clear --no-warmup && \
    bin/console cache:warmup && \
    # We don't use DotEnv component as docker-compose will provide real environment variables
    echo "<?php return [];" > .env.local.php && \
    mkdir -p var/storage && \
    chown -R www-data:www-data var && \
    # Reduce container size
    rm -rf assets /root/.composer /tmp/* node_modules