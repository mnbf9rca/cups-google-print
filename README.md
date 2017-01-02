# cups-google-print
> Please log issues on GitHub (https://github.com/mnbf9rca/cups-google-print), not here...

Docker container with CUPS, Apple AirPrint and Google Cloud Print.

At the moment it seems to be working. Only Google Local Print is supported until I can figure out how to allow users to generate config for GCP. If you have a config file, you can store this in the root of your config folder as ```gcp-cups-connector.config.json``` and it'll automatically be used.

## Usage
* Configure mappings:

Type | Container | Client
---|---|---
Path|/dev|/dev
Path|/avahi|/etc/avahi/services
Path|/var/run/dbus|/var/run/dbus
Path|/config|wherever you want CUPS config stored
Port|631|631
Variable|CUPS_USER_ADMIN|admin (or whatever you want - for logging in to CUPS)
Variable|CUPS_USER_PASSWORD|pass (or whatever you want)

* Other requirements
* * Host networking (--net="host") appears to be needed for GCP and Avahi to work
* * privileged (--privileged="true") appears to be needed

Typical startup command might be:
'''docker run -d --name="cups-google-print" --net="host" --privileged="true" -e TZ="UTC" -e HOST_OS="unRAID" -e "CUPS_USER_ADMIN"="admin" -e "CUPS_USER_PASSWORD"="pass" -e "TCP_PORT_631"="631" -v "/mnt/user/appdata/cups-google-print":"/config":rw -v /dev:/dev -v /etc/avahi/services:/avahi -v /var/run/dbus:/var/run/dbus mnbf9rca/cups-google-print'''

- originally from https://github.com/gfjardim/docker-containers/tree/master/cups
- Removed Chrome and Samsung drivers, and incorporated https://github.com/google/cloud-print-connector/wiki/Install
