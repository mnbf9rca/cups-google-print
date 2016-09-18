FROM phusion/baseimage:0.9.16
MAINTAINER mnbf9rca mnbf9rca@gmx.com

## cloned from gfjardim  / https://github.com/gfjardim/docker-containers / <gfjardim@gmail.com>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" GIT_REPO="mnbf9rca/cups-google-print"
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
ADD * /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
# Export volumes
VOLUME /config /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups
EXPOSE 631