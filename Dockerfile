FROM php:8.3.1-apache
ARG DEBIAN_FRONTEND=noninteractive
RUN docker-php-ext-install mysqli
# Include alternative DB driver
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql

RUN rm -vf /var/lib/apt/lists/*
RUN apt-get -y update 

COPY a2enmod-fix.sh ./fix.sh
RUN chmod +x ./fix.sh && ./fix.sh

RUN apt-get install -y git git-svn subversion wget unzip apache2
#RUN apt-get install -y perl sqlite3
# RUN mkdir -p /root/.cpan/build/Alien-SVN-v1.8.11.0-0/src/subversion/sqlite-amalgamation && wget -O ./sqlite.zip http://www.sqlite.org/sqlite-amalgamation-3071501.zip && unzip -j ./sqlite.zip -d /root/.cpan/build/Alien-SVN-v1.8.11.0-0/src/subversion/sqlite-amalgamation && rm ./sqlite.zip
# RUN apt-get install -y cpanminus
# RUN apt-get install -y libapr1-dev libaprutil1-dev
# RUN cpan SVN::Core

RUN apt-get install -y sendmail libpng-dev \
    && apt-get install -y libzip-dev \
    && apt-get install -y zlib1g-dev \
    && apt-get install -y libonig-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install zip 

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt-get install -y libicu-dev  libmagickwand-dev libmagickcore-dev \
    && docker-php-ext-configure intl

RUN set -xe \
    && git clone https://github.com/Imagick/imagick \
    && cd imagick \
    && git checkout master && git pull \
    && phpize && ./configure && make && make install \
    && cd .. && rm -Rf imagick \
    && docker-php-ext-enable imagick



RUN docker-php-ext-install intl opcache intl zip calendar dom mbstring gd

RUN apt-get -yqq install ffmpeg exiftool ghostscript
RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif

RUN a2enmod rewrite

WORKDIR /var/www/html/
RUN svn co https://svn.resourcespace.com/svn/rs/releases/10.5_RC/ .

EXPOSE 80