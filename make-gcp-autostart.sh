#!/bin/bash

mkdir /etc/service/gcp
cat <<'EOT' >/etc/service/gcp/run
#!/bin/sh
rm -f /tmp/cloud-print-connector-monitor.sock
exec /root/go/bin/gcp-cups-connector
EOT
chmod +x /etc/service/gcp/run
