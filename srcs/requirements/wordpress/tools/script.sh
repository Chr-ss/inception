#!bin/bash

# Function to wait for MariaDB to be ready
wait_for_mariadb() {
    while ! mysql -h"$DB_HOST" -P"$DB_PORT" -u"$DB_USER" -p"$DB_USER_PWD" -e "SELECT 1" 2>/dev/null; do
        echo "Waiting for MariaDB to be ready... sleeping for 5 seconds."
        sleep 5
    done
    echo "MariaDB is ready!"
}


echo "Waiting for MariaDB to be ready..."
wait_for_mariadb

echo "Creating WordPress configuration..."
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create    --dbname=$DB_DATABASE \
                        --dbuser=$DB_USER \
                        --dbpass=$DB_USER_PWD \
                        --dbhost=$DB_HOST \
                        --allow-root  \
                        --skip-check

    wp core install     --url=$DOMAIN_NAME \
                        --title=$TITEL \
                        --admin_user=$WP_ADMIN \
                        --admin_password=$WP_ADMIN_PWD \
                        --admin_email=$WP_ADMIN_EMAIL \
                        --allow-root

    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PWD --allow-root

    wp config set FORCE_SSL_ADMIN 'false' --allow-root

    chmod 777 /var/www/html/wp-content

    wp theme install astra --activate --allow-root

fi

echo "Starting WP.."
exec "$@"

