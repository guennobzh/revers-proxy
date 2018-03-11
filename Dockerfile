FROM debian:stable
MAINTAINER Guenno < guenno@tybihan.net >

RUN apt-get update && apt-get install -y\
	apt-utils\
	apache2\
	openssl


ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

RUN a2enmod rewrite\
	expires\
	headers\
	cgi\
	ssl\
	proxy\
	proxy_http 

RUN mkdir /var/www-sites


COPY httpd-foreground /usr/local/bin/
RUN chmod +x /usr/local/bin/httpd-foreground
 
EXPOSE 80
EXPOSE 443

CMD ["/usr/local/bin/httpd-foreground"]
