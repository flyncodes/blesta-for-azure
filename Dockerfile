FROM ghcr.io/flyncodes/nginx-php-for-azure:php8.3

ENV PHP_VERSION=8.3
ARG NGINX_ROOT
ENV NGINX_ROOT=${NGINX_ROOT:-/usr/local/cachedapp/wwwroot}

# Download & install ioncube loader
RUN cd /tmp && curl -o ioncube.tar.gz https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz && \
    tar -xzvf ioncube.tar.gz && \
    rm ioncube.tar.gz
RUN mkdir -p /usr/lib/php/ioncube && \
    cp /tmp/ioncube/ioncube_loader_lin_$PHP_VERSION.so /usr/lib/php/ioncube/ioncube_loader_lin_$PHP_VERSION.so && \
    rm -r /tmp/ioncube
# Add ioncube loader to PHP config
RUN mkdir -p /etc/php/$PHP_VERSION/fpm/conf.d/ && \
    echo "zend_extension = /usr/lib/php/ioncube/ioncube_loader_lin_${PHP_VERSION}.so" \
    > /etc/php/$PHP_VERSION/fpm/conf.d/00-ioncube.ini
RUN mkdir -p /etc/php/$PHP_VERSION/cli/conf.d/ && \
    cp /etc/php/$PHP_VERSION/fpm/conf.d/00-ioncube.ini /etc/php/$PHP_VERSION/cli/conf.d/00-ioncube.ini

# Make a directory on the local disk to copy the code from Azure shared storage to this
RUN mkdir -p $NGINX_ROOT

# Copy scripts to be ran on docker startup
COPY default.conf.template /etc/nginx/templates/
COPY docker-entrypoint.d/ /docker-entrypoint.d/
RUN chmod -v +x /docker-entrypoint.d/*.sh

USER nginx
CMD ["nginx","-g","daemon off"]
