#!/bin/bash


# # Start MariaDB
# service mariadb start

# # Wait for MariaDB to fully start
# sleep 5

# # Securely connect as root (assumes socket auth or no password yet)
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY \`${MYSQL_ROOT_PASSWORD}\`;"
# mysql -e "FLUSH PRIVILEGES;"
# mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
# mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
# # mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

# # Now connect using the new root password to verify it works
# mysqladmin -uroot -p"${MYSQL_ROOT_PASSWORD}" shutdown

# service mariadb start

# mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
# mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
# mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# mysql -e "FLUSH PRIVILEGES;"
# mysqladmin -u${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} shutdown

chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql

mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chmod -R 755 /var/run/mysqld


echo "Creating database"
service mariadb start
sleep 2
mysql -u root ${MYSQL_ROOT_PASSWORD} << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE ;
CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' ;
FLUSH PRIVILEGES ;
EOF
service mariadb stop
echo "Database created"

sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf



exec "$@"


