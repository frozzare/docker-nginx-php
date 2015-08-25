FROM ubuntu:trusty
MAINTAINER Fredrik Forsmo <fredrik.forsmo@gmail.com>

# Install python-software-properties
RUN apt-get update && \
		apt-get -y install \
			software-properties-common \
			python-software-properties

# Import key
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4F4EA0AAE5267A6C

# Configure repos
RUN add-apt-repository -y ppa:nginx/stable && \
		add-apt-repository -y ppa:ondrej/php5-5.6

# Install base packages
RUN apt-get update && \
    apt-get -y install \
				python-setuptools \
        curl \
				php5-fpm \
        php5-mysql \
        php5-mcrypt \
        php5-gd \
        php5-curl \
        php-pear \
        php-apc \
				php5-json \
        nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini

ADD sites-enabled/ /etc/nginx/sites-enabled/
ADD app/ /app/

# Supervisord
RUN easy_install supervisor
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 80

CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
