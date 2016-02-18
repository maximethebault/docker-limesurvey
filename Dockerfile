
FROM tutum/lamp

RUN apt-get update ; \
	apt-get upgrade -q -y ;\
	apt-get install -q -y curl php5-gd php5-ldap php5-imap; apt-get clean ; \
	php5dismod imap

RUN rm -rf /app 
ADD limesurvey.tar.bz2 /
RUN mv limesurvey app; \
	chown -R www-data:www-data /app

RUN chown www-data:www-data /var/lib/php5

ADD apache_default /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /app/upload/
RUN chmod -R u+w,g+w,o+w /app/upload/

VOLUME /app/upload

EXPOSE 80 3306
