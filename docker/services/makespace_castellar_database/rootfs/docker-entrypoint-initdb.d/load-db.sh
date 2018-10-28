#!/usr/bin/env bash
echo "############## DATABASE IMPORT UTILITY ##############"

rm -f /tmp/dump.sql.bz2
rm -f /tmp/dump.sql

echo "Downloading dump..."
s3cmd get s3://makespace_castellar/backup/dump.sql.bz2 /tmp/dump.sql.bz2
if [ $? != 0 ]; then
    echo "Error: Dump download failed"
    exit
fi

echo "Uncompressing dump..."
pv /tmp/dump.sql.bz2 | bunzip2 > /tmp/dump.sql

mysql -u root -e "SET GLOBAL general_log = 'OFF'; SET GLOBAL slow_query_log = 'OFF'; SET autocommit = 0; SET unique_checks = 0; SET foreign_key_checks = 0;"
pv /tmp/dump.sql | mysql -uroot $MYSQL_DATABASE
mysql -u root -e "SET GLOBAL general_log = 'ON'; SET GLOBAL slow_query_log = 'ON'; COMMIT; SET unique_checks = 1; SET foreign_key_checks = 1;"

rm -f /tmp/dump.sql.bz2
rm -f /tmp/dump.sql

echo "Process completed!"
