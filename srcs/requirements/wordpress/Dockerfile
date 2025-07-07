FROM debian:11

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	mariadb-client \
	php-fpm \
	php-mysql \
	php-zip \ 
	php-xml \
	curl && \
	sed -i -e 's/listen =.*/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf


RUN mkdir -p /var/www/html
RUN mkdir -p /run/php

WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --allow-root

EXPOSE 9000

COPY ./conf/wordpress.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["bash", "script.sh"]

CMD [ "php-fpm7.4", "-F" ]