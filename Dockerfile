FROM phusion/baseimage:0.9.16
MAINTAINER mnbf9rca mnbf9rca@gmx.com

## cloned from gfjardim  / https://github.com/gfjardim/docker-containers / <gfjardim@gmail.com>

#########################################
##        ENVIRONMENTAL CONFIG         ##
#########################################
# Set correct environment variables
ENV HOME="/root" LC_ALL="C.UTF-8" LANG="en_US.UTF-8" LANGUAGE="en_US.UTF-8" GIT_REPO="mnbf9rca/cups-google-print" DEBIAN_FRONTEND="noninteractive"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]




#########################################
##         RUN INSTALL SCRIPT          ##
#########################################
# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody && usermod -g 100 nobody && usermod -d /home nobody && chown -R nobody:users /home
# Disable SSH
RUN rm -rf /etc/service/sshd /etc/service/cron /etc/service/syslog-ng /etc/my_init.d/00_regen_ssh_host_keys.sh

# Repositories
# RUN curl -skL http://www.bchemnet.com/suldr/suldr.gpg | apt-key add -
RUN curl -sSkL -o /tmp/suldr-keyring_1_all.deb http://www.bchemnet.com/suldr/pool/debian/extra/su/suldr-keyring_1_all.deb && dpkg -i /tmp/suldr-keyring_1_all.deb
RUN add-apt-repository "deb http://www.bchemnet.com/suldr/ debian extra" && add-apt-repository ppa:ubuntu-lxc/lxd-stable

# Use mirrors
RUN sed -i -e "s#http://[^\s]*archive.ubuntu[^\s]* #mirror://mirrors.ubuntu.com/mirrors.txt #g" /etc/apt/sources.list

# Install Dependencies
# RUN apt-get update -qq && apt-get install -qy --force-yes cups cups-pdf whois hplip suld-driver-4.01.17 python-cups inotify-tools libcups2 libavahi-client3 avahi-daemon libsnmp30 build-essential libcups2-dev libavahi-client-dev git bzr


RUN apt-get update -qq && apt-get install -qy --force-yes \
cups \
cups-pdf \
whois \
hplip \
suld-driver-4.01.17 \
python-cups \
inotify-tools \
libcups2 \
libavahi-client3 \
avahi-daemon \
libsnmp30 \
golang \
build-essential \
libcups2-dev \
libavahi-client-dev \
git \
bzr

## install go (https://golang.org/doc/install)
## RUN wget -nv -O - https://storage.googleapis.com/golang/go1.7.1.linux-amd64.tar.gz | tar -C /usr/local -xzf -

ENV GOPATH=$HOME/go PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

## uncomment if you want to check the version installed...
## RUN go version


## install google print connector
RUN go get github.com/google/cloud-print-connector/...


ADD * /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh && rm /tmp/install.sh

#########################################
##         EXPORTS AND VOLUMES         ##
#########################################
# Export volumes
VOLUME /config /etc/cups/ /var/log/cups /var/spool/cups /var/cache/cups
EXPOSE 631