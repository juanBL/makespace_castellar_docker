FROM mysql:5.6

RUN apt-get clean && apt-get update && apt-get install -y s3cmd pv bzip2

ADD /rootfs /

RUN chmod 777 /tmp

RUN chmod +x /docker-entrypoint-initdb.d/load-db.sh
