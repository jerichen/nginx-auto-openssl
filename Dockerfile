FROM nginx
MAINTAINER JeriChen<jeri.chen0110@gmail.com>

ENV TZ=Asia/Taipei

RUN mkdir -p /etc/nginx/ssl

RUN apt-get update; apt-get install -y openssl; apt-get install -y vim

# RUN openssl req -nodes -new -x509 -keyout /etc/nginx/ssl/gitlab.key -out /etc/nginx/ssl/gitlab.crt -subj "/C=US/ST=NY/L=NYC/O=Dis/CN=NGINX"
RUN openssl genrsa -out "/etc/nginx/ssl/nginx.key" 2048 \
    && openssl req -new -key "/etc/nginx/ssl/nginx.key" -out "/etc/nginx/ssl/nginx.csr" -subj "/CN=NGINX/O=Dis/C=UK" \
    && openssl x509 -req -days 365 -in "/etc/nginx/ssl/nginx.csr" -signkey "/etc/nginx/ssl/nginx.key" -out "/etc/nginx/ssl/nginx.crt"

RUN rm /etc/nginx/conf.d/default.conf

COPY ./scripts/make_ssl.sh /make_ssl.sh
RUN chmod a+x /make_ssl.sh

VOLUME /etc/openssl-ssl
ENTRYPOINT ["/make_ssl.sh"]
