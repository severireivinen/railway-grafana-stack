#!/bin/sh

# Use awk to find and replace the variables natively without needing envsubst
awk '{
  while(match($0, /\${[A-Za-z0-9_]+}/)) {
    var = substr($0, RSTART+2, RLENGTH-3)
    val = ENVIRON[var]
    $0 = substr($0, 1, RSTART-1) val substr($0, RSTART+RLENGTH)
  }
  print
}' /etc/prometheus/prom.template.yml > /etc/prometheus/prom.yml

# Start Prometheus as PID 1 so it handles shutdown signals properly
exec /bin/prometheus --config.file=/etc/prometheus/prom.yml --storage.tsdb.path=/prometheus