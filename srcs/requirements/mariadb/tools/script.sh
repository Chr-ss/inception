#!/bin/bash

	echo "Starting MariaDB service..."
	service mariadb start

if [ ! -d "/var/lib/mysql/wordpress" ]; then
	echo "Waiting for MariaDB to start..."	
	sleep 5

	echo "Initializing MariaDB database..."

	echo "Creating database and user..."
	mariadb -e "
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PWD}';
	CREATE DATABASE IF NOT EXISTS \`${DB_DATABASE}\`;
	CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PWD}';
	GRANT ALL PRIVILEGES ON \`${DB_DATABASE}\`.* TO '${DB_USER}'@'%';
	FLUSH PRIVILEGES;"
	mysqladmin -u${DB_ROOT_USER} -p${DB_ROOT_PWD} shutdown
	echo "Database created, user created, and privileges granted."
else
	echo "Database already exists, skipping creation."
	mysqladmin -u${DB_ROOT_USER} -p${DB_ROOT_PWD} shutdown
fi


echo "MariaDB configuration updated. Script completed successfully."
exec "$@"
