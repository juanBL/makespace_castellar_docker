FROM ubuntu:16.04

# Prepare environment
WORKDIR /var/www
ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV SHELL /bin/bash
ENV APP_ENV dev
ENV APP_ENV_KEY dev
ENV NODE_ENV dev

# Update the package repository
RUN apt-get update && apt-get install -y software-properties-common wget curl git tzdata iputils-ping locales zip unzip build-essential hashdeep

# Configure timezone and locale
RUN echo "Europe/Madrid" > /etc/timezone
RUN export LANGUAGE=es_ES.UTF-8 && export LANG=es_ES.UTF-8 && export LC_ALL=es_ES.UTF-8 && locale-gen es_ES.UTF-8 && dpkg-reconfigure -f noninteractive tzdata locales

RUN LC_ALL=es_ES.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update --option Acquire::Retries=100 --option Acquire::http::Timeout="300"

# Install dependencies
RUN apt-get install -y \
    apache2 \
    php7.1 \
    libapache2-mod-php7.1 \
    php7.1-cli \
    php7.1-common \
    php7.1-mbstring \
    php7.1-gd \
    php7.1-intl \
    php7.1-xml \
    php7.1-mysql \
    php7.1-soap \
    php7.1-mcrypt \
    php7.1-zip \
    php7.1-memcached \
    php7.1-curl \
    php7.1-dev \
    php7.1-igbinary \
    php7.1-redis \
    php7.1-xdebug \
    php-apcu

ADD /rootfs /

# Enable the API and frontend apache virtual hosts
RUN a2dissite 000-default.conf \
    && a2ensite 001-makespacecastellar-landing.conf \
    && a2enmod rewrite actions alias proxy proxy_http headers expires ssl

# Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer \
    && chmod 777 /usr/bin/composer

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install yarn

RUN chmod -v +x /run.sh

EXPOSE 84
CMD ["/run.sh"]
