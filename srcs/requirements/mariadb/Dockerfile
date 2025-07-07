FROM debian:11

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	mariadb-server \
	net-tools -y && \
	apt clean && \
	rm -rf /var/lib/apt/lists/* 

RUN sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 

COPY requirements/mariadb/tools/script.sh .
RUN  chmod +x ./script.sh

ENTRYPOINT ["bash", "./script.sh"]

CMD ["mysqld"]
