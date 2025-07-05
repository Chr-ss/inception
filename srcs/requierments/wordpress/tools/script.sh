#!bin/bash

# wait for mysql to start
sleep 10
# Install Wordpress

if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_USER_PASSWORD --dbhost=$mysql_host --allow-root  --skip-check

    wp core install --url=$DOMAIN_NAME --title=$TITEL --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

    wp config  set WP_DEBUG true  --allow-root

    wp config set FORCE_SSL_ADMIN 'false' --allow-root

    chmod 777 /var/www/html/wp-content

    wp theme install astra --activate

fi


# /usr/sbin/php-fpm7.3 -F

