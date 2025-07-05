#!/bin/bash

sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/default   

nginx -g "daemon off;"