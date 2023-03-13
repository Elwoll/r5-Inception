#!/bin/bash
service mysql start

mysql << EOF
FLUSH PRIVILEGES;
DELETE FROM	mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
CREATE DATABASE IF NOT EXISTS $MARIADB_NAME DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER IF NOT EXISTS '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
GRANT ALL PRIVILEGES ON $MARIADB_NAME.* TO '$MARIADB_USER'@'%';
FLUSH PRIVILEGES;
EOF
tail -f
#exec mysql -u root

#echo "mariadb"
#mariadb-install-db --datadir=/var/lib/mysql --auth-root-authentication-method=normal
#tail -f
#
#mariadb << EOF
#CREATE DATABASE IF NOT EXISTS $WP_DATABASE_NAME;
#CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';
#GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%';
#ALTER USER 'root'@'localhost' IDENTIFIED BY '$WORDPRESS_ADMIN_PASSWORD';
#FLUSH PRIVILEGES;
#EOF
