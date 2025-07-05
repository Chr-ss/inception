FROM debian:12

# ARG DOMAIN_NAME
# ENV DOMAIN_NAME=$DOMAIN_NAME

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    nginx \
    openssl && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssl/private

RUN openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/server.key \
  -out /etc/ssl/private/server.crt \
  -subj "/C=NL/ST=ADAM/L=Amsterdam/O=Codam/CN=localhost"

COPY ./conf/nginx.conf /etc/nginx/sites-available/default

COPY ./tools/script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["bash", "script.sh"]

# RUN sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/default   

# ENTRYPOINT ["nginx", "-g", "daemon off;"]