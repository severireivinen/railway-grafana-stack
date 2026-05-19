#!/bin/sh
set -e # Exit immediately if a command fails

# 1. Create the working config from the template
cp /etc/prometheus/prom.yml.template /etc/prometheus/prom.yml

# 2. Perform the substitution
DELIM=$(printf '\001')
sed -i "s${DELIM}\${ATLAS_METRICS_USER}${DELIM}${ATLAS_METRICS_USER}${DELIM}g" /etc/prometheus/prom.yml
sed -i "s${DELIM}\${ATLAS_METRICS_PASSWORD}${DELIM}${ATLAS_METRICS_PASSWORD}${DELIM}g" /etc/prometheus/prom.yml

# 3. Start Prometheus
exec /bin/prometheus "$@"
