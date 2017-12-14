FROM ubuntu:latest
# we base this on ubuntu

# dovecot imap/pop3-server

# set env. replace right most column with values specific to your environment
ENV DOVECOT_FQDN example.com
ENV DOVECOT_BANLIST shared_banlist.txt
ENV	DOVECOT_PROTOCOLS "imap imaps"
ENV	DOVECOT_IP_ADDRESS '*'
ENV	DOVECOT_PORT 993
ENV	DOVECOT_LOG_PATH /var/log/dovecot/
ENV	DOVECOT_CERT_FILE /external_mount/${DOVECOT_FQDN}_cert.pem
ENV	DOVECOT_KEY_FILE /external_mount/${DOVECOT_FQDN}_key.pem
ENV	DOVECOT_USER dovecot 
ENV	DOVECOT_LISTENING_LOGIN_PROCESSES 3
ENV	DOVECOT_MAX_PROCESSES_COUNT 10
ENV	DOVECOT_LOGIN_MAX_CONNECTIONS 10
ENV	DOVECOT_GREET_MESSAGE "Hi!"
ENV	DOVECOT_TRUSTED_NETWORKS "127.0.0.0/24"
ENV	DOVECOT_MAIL_LOCATION /var/dovecot/mail/
ENV	DOVECOT_MAIL_UID 500
ENV	DOVECOT_MAIL_GID 500
ENV	DOVECOT_MAIL_PRIVILEGED_GROUP root
ENV	DOVECOT_MAIL_DEBUG true
ENV	DOVECOT_MAX_MAIL_PROCESSES 10
ENV	DOVECOT_MAX_PROCESS_SIZE 10
ENV	DOVECOT_CACHE_MIN_MAIL_COUNT 10
ENV	DOVECOT_IDLE_CHECK_INTERVAL 3
ENV	DOVECOT_MAX_USERIP_CONNECTIONS 10
ENV	DOVECOT_IMAP_IDLE_NOTIFY_INTERVAL 3
ENV	DOVECOT_POP3_MAX_USERIP_CONNECTIONS 10
ENV	DOVECOT_AUTH_PROCESS_SIZE 20
ENV	DOVECOT_AUTH_WORKER_MAX_COUNT 10
ENV	DOVECOT_DENY_LOGIN_FILE /external_mount/${DOVECOT_BANLIST}
ENV	DOVECOT_DICT_DB_CONFIG /usr/share/example/bk/dict.conf

LABEL maintainer=dansta

# add proxies, in case you are rebuilding on a system behind a proxy
#ADD files/apt.conf /etc/apt/apt.conf

# update and install packages
RUN apt-get update
RUN apt-get install -y dovecot-imapd dovecot-pop3d
RUN apt-get install -y rsyslog
ADD files/etc/dovecot.conf /etc/dovecot/dovecot.conf
ADD files/replace_dovecotconf.sh /usr/local/bin/replace_dovecotconf
ADD files/value.awk /usr/local/bin/value.awk
ADD files/key.awk /usr/local/bin/key.awk
RUN chmod +rx /usr/local/bin/replace_dovecotconf
RUN /usr/local/bin/replace_dovecotconf

# document port usage for docker in case you are going to use it as a service
EXPOSE ${DOVECOT_PORT}/tcp

# logging for debug. logging should be handled by your support team
RUN service rsyslog start

# test dovecot for build, run in foreground
CMD /usr/sbin/dovecot
