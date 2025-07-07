
FROM debian:11

RUN apt update -y \
    && apt install -y nginx \
    && apt install -y openssl \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/crasche.42.fr.key \
    -out /etc/nginx/ssl/crasche.42.fr.crt \
    -subj "/C=NL/L=Amsterdam/0=Codam/OU=Student/CN=crasche"

EXPOSE 443

ENTRYPOINT ["/usr/sbin/nginx"]

CMD ["-g", "daemon off;"]
