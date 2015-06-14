FROM ubuntu:14.04
MAINTAINER linh.mtran168@live.com

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Add php 5.6 repo
RUN apt-get update -y && \
  apt-get install -y python-software-properties software-properties-common

RUN add-apt-repository ppa:ondrej/php5-5.6 && \
  apt-get update -y

# Install php and some dependencies
RUN apt-get update -y && \
  apt-get install -y git curl php5-fpm php5-dev php5-cli php5-json php5-curl php5-intl php5-pgsql php5-sqlite php5-gd php5-mcrypt

# Install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

COPY ./config/php_cli.ini /etc/php5/cli/php.ini
COPY ./config/php_fpm.ini /etc/php5/fpm/php.ini
COPY ./config/www.conf /etc/php5/fpm/pool.d/

EXPOSE 9000

CMD ["/usr/sbin/php5-fpm", "-F"]
