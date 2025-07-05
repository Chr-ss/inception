FROM debian:12

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	mariadb-server && \
	apt clean && \
	rm -rf /var/lib/apt/lists/*

COPY ./tools/script.sh .

RUN  chmod +x ./script.sh

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["bash", "./script.sh"]

CMD ["mysqld_safe"]