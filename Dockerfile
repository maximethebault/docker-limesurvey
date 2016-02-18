FROM tutum/lamp

RUN apt-get update ; \
	apt-get upgrade -q -y ;\
	apt-get install -q -y curl php5-gd php5-ldap php5-imap; apt-get clean ; \
	php5dismod imap

# make way for our webapp
RUN rm -rf /app 
ADD limesurvey.tar.bz2 /
RUN mv limesurvey app; \
    chown -R www-data:www-data /app
# si on monte le volume /app/upload sur le système host, on perdra le contenu du dossier /app/upload (en effet, en utilisant l'option -v /dossier/sur/host:/app/upload, le dossier /app/upload est recouvert par le volume monté). On copie donc le contenu de /app/upload dans /uploadstruct, on monte le volume, et on redéplace le contenu de /uploadstruct dans /app/upload. De cette manière, la structure originale de /app/upload sera toujours présente, et un quelconque futur changement sera répliqué entre le host et le container, peu importe la source du changement.
RUN mkdir -p /uploadstruct

RUN cp -pR /app/upload/* /uploadstruct ; \
	chown -R www-data:www-data /uploadstruct

# on va faire de même pour app/application/config
RUN mkdir -p /configstruct

RUN cp -pR /app/application/config/* /configstruct ; \
	chown -R www-data:www-data /configstruct

RUN chown www-data:www-data /var/lib/php5

ADD apache_default /etc/apache2/sites-available/000-default.conf

ADD run-ls.sh /run-ls.sh
RUN chmod 755 /run-ls.sh

VOLUME ["/app/upload", "/app/application/config"]

EXPOSE 80 3306
CMD ["/run-ls.sh"]