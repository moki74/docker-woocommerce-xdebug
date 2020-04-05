FROM wordpress:latest

ENV WOOCOMMERCE_VERSION 2.6.1
ENV WOOCOMMERCE_UPSTREAM_VERSION 2.6.1

RUN apt-get update
RUN apt-get install -y --no-install-recommends unzip wget vim

RUN wget https://downloads.wordpress.org/plugin/woocommerce.${WOOCOMMERCE_VERSION}.zip -O /tmp/temp.zip \
    && cd /usr/src/wordpress/wp-content/plugins \
    && unzip /tmp/temp.zip \
    && rm /tmp/temp.zip
RUN curl -o /bin/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
COPY wp-su.sh /bin/wp
RUN chmod +x /bin/wp-cli.phar /bin/wp
RUN pecl install xdebug-beta \
    && docker-php-ext-enable xdebug
