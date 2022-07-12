FROM ghcr.io/flyncodes/nginx-php-for-azure:php8.0

ENV PHP_VERSION=8.0

# Install SourceGuardian loader
RUN cd /tmp && curl -o sourceguardian.tar.gz https://www.sourceguardian.com/loaders/download/loaders.linux-x86_64.tar.gz && \
    tar -xzvf sourceguardian.tar.gz && \
    rm sourceguardian.tar.gz
RUN mkdir -p /usr/lib/php/sourceguardian && \
    cp /tmp/ixed.$PHP_VERSION.lin /usr/lib/php/sourceguardian/.
RUN mkdir -p /etc/php/$PHP_VERSION/fpm/conf.d/ && \
    echo "extension = /usr/lib/php/sourceguardian/ixed.${PHP_VERSION}.lin" \
    > /etc/php/$PHP_VERSION/fpm/conf.d/00-sourceguardian.ini
RUN mkdir -p /etc/php/$PHP_VERSION/cli/conf.d/ && \
    cp /etc/php/$PHP_VERSION/fpm/conf.d/00-sourceguardian.ini /etc/php/$PHP_VERSION/cli/conf.d/00-sourceguardian.ini

COPY default.conf.template /etc/nginx/templates/

# Map Azure App Service directory to inside the container
RUN ln -s /home/site/wwwroot/inside /var/www/html
