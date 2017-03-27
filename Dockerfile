FROM ubuntu

ENV APACHE_RUN_USER    www-data
ENV APACHE_RUN_GROUP   www-data
ENV APACHE_PID_FILE    /var/run/apache2.pid
ENV APACHE_RUN_DIR     /var/run/apache2
ENV APACHE_LOCK_DIR    /var/lock/apache2
ENV APACHE_LOG_DIR     /var/log/apache2

RUN apt-get -y update && apt-get install -y subversion apache2 libapache2-mod-svn libapache2-svn libsvn-dev
RUN /usr/sbin/a2enmod dav
RUN /usr/sbin/a2enmod dav_svn
RUN service apache2 restart

VOLUME /svn
VOLUME /config

# Set permissions
RUN addgroup subversion
RUN usermod -a -G subversion www-data
RUN chown -R www-data:subversion /svn
RUN chmod -R g+rws /svn

COPY config/apache-default.conf /etc/apache2/sites-available/000-default.conf

# Configure Apache to serve up Subversion
RUN /usr/sbin/a2enmod auth_digest

EXPOSE 80

CMD ["/usr/sbin/apache2", "-DFOREGROUND"]