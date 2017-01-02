#!/bin/bash

mkdir /etc/service/gcp
cat <<'EOT' >/etc/service/gcp/run
#!/bin/sh
rm -f /tmp/cloud-print-connector-monitor.sock
if [ -r /config/gcp-cups-connector.config.json ]
  then
    exec /root/go/bin/gcp-cups-connector --config-filename /config/gcp-cups-connector.config.json
  else
    exec /root/go/bin/gcp-cups-connector
fi
EOT
chmod +x /etc/service/gcp/run
