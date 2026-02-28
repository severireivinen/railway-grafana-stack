#!/bin/sh
# Substitute environment variables into the Prometheus config template
envsubst < /etc/prometheus/prom.yml.template > /etc/prometheus/prom.yml

# Start Prometheus with the processed config
exec /bin/prometheus "$@"
