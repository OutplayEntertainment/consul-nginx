#!/bin/bash
set -e

if [ "$1" = 'consul-template'  ]; then
    nginx -c /etc/nginx/nginx.conf

    exec consul-template -consul "$2" \
         -template "/nginx.conf.ctmpl:/etc/nginx/nginx.conf:nginx -t && service nginx reload" \
         -retry 20s
fi

exec "$@"
