#!/bin/sh
set -e

# Validate required environment variables before substitution
_required_vars="ATLAS_METRICS_USER ATLAS_METRICS_PASSWORD"
for _var in $_required_vars; do
  eval "_val=\$$_var"
  if [ -z "$_val" ]; then
    echo "ERROR: required environment variable \$$_var is not set" >&2
    exit 1
  fi
done

# Use awk to find and replace the variables natively without needing envsubst
awk '{
  while(match($0, /\${[A-Za-z0-9_]+}/)) {
    var = substr($0, RSTART+2, RLENGTH-3)
    val = ENVIRON[var]
    $0 = substr($0, 1, RSTART-1) val substr($0, RSTART+RLENGTH)
  }
  print
}' /etc/prometheus/prom.template.yml > /tmp/prom.yml

# Start Prometheus as PID 1 so it handles shutdown signals properly
exec /bin/prometheus --config.file=/tmp/prom.yml --storage.tsdb.path=/prometheus