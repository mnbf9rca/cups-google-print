#!/bin/bash


mkdir -p /etc/my_init.d
cat <<'EOT' >/etc/my_init.d/avahi.sh
#!/bin/bash

service avahi-daemon start

EOT
chmod +x /etc/my_init.d/avahi.sh

## # Add cups to runit
## mkdir /etc/service/cups
## cat <<'EOT' >/etc/service/cups/run
## #!/bin/sh
## if [ -n "$CUPS_USER_ADMIN" ]; then
##   if [ $(grep -ci $CUPS_USER_ADMIN /etc/shadow) -eq 0 ]; then
##     useradd $CUPS_USER_ADMIN --system -G root,lpadmin --no-create-home --password $(mkpasswd $CUPS_USER_PASSWORD)
##   fi
## fi
## exec /usr/sbin/cupsd -f -c /config/cups/cupsd.conf
## EOT
## chmod +x /etc/service/cups/run