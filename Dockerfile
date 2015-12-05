FROM ubuntu:14.04

MAINTAINER Roma Sokolov "roma.sokolov@outplay.com"

# Install Nginx & wget
RUN apt-get update && \
    apt-get install -y nginx wget tar && \
    chown -R www-data:www-data /var/lib/nginx

RUN rm -f /etc/nginx/sites-available/default
# setup error via config
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN mkdir -p /var/www/default/htdocs

# Install consul-template
RUN wget https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_amd64.tar.gz && \
    tar -zxf consul-template_0.10.0_linux_amd64.tar.gz && \
    mv consul-template_0.10.0_linux_amd64/consul-template /usr/local/bin/ && \
    rm -rf /var/lib/apt/lists/*

VOLUME ["/var/cache/nginx"]

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY nginx.conf.ctmpl /nginx.conf.ctmpl
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 80 443
