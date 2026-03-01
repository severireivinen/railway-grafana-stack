#!/bin/sh
# Use sed to replace variables. 
# Note: This is a simple replacement. If your passwords have special characters like '/', 
# you might need to use a different delimiter or stick to Option 2.
sed -i "s/\${VOIMA_METRICS_USER}/$VOIMA_METRICS_USER/g" /etc/prometheus/prom.yml.template
sed -i "s/\${VOIMA_METRICS_PASSWORD}/$VOIMA_METRICS_PASSWORD/g" /etc/prometheus/prom.yml.template

cp /etc/prometheus/prom.yml.template /etc/prometheus/prom.yml

exec /bin/prometheus "$@"
