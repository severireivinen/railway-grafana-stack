#!/bin/sh

# Use 'envsubst' if you can get it to work, BUT 
# here is the 100% shell-safe way using 'sed' with a unique delimiter:
# We use ASCII character \001 as a delimiter because it's never in a password.

DELIM=$(printf '\001')

sed -i "s${DELIM}\${VOIMA_METRICS_USER}${DELIM}${VOIMA_METRICS_USER}${DELIM}g" /etc/prometheus/prom.yml
sed -i "s${DELIM}\${VOIMA_METRICS_PASSWORD}${DELIM}${VOIMA_METRICS_PASSWORD}${DELIM}g" /etc/prometheus/prom.yml

exec /bin/prometheus "$@"
