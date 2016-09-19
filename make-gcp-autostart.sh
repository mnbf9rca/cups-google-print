#!/bin/bash

mkdir /etc/service/gcp
cat <<'EOT' >/etc/service/gcp/run
#!/bin/sh
exec /root/go/bin/gcp-cups-connector
EOT
chmod +x /etc/service/gcp/run