
FROM tutum/lamp

RUN apt-get update ; \
	apt-get upgrade -q -y ;\
	apt-get install -q -y curl php5-gd php5-ldap php5-imap; apt-get clean ; \
	php5dismod imap

RUN rm -rf /app 
ADD limesurvey.tar.bz2 /
RUN mv limesurvey app; \
# si on monte le volume /app/upload sur le système host, on perdra le contenu du dossier /app/upload (en effet, en utilisant l'option -v /dossier/sur/host:/app/upload, le dossier /app/upload est recouvert par le volume monté). On copie donc le contenu de /app/upload dans /uploadstruct, on monte le volume, et on redéplace le contenu de /uploadstruct dans /app/upload. De cette manière, la structure originale de /app/upload sera toujours présente, et un quelconque futur changement sera répliqué entre le host et le container, peu importe la source du changement.
	mkdir -p /uploadstruct; \
	chown -R www-data:www-data /app

RUN cp -r /app/upload/* /uploadstruct ; \
	chown -R www-data:www-data /uploadstruct

RUN chown www-data:www-data /var/lib/php5

ADD apache_default /etc/apache2/sites-available/000-default.conf
ADD start.sh /

RUN chmod +x /start.sh

VOLUME /app/upload

EXPOSE 80 3306
CMD ["/start.sh"]