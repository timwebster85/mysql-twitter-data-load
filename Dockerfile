FROM mysql

COPY ./data/*.csv ./var/lib/mysql-files/

ENV MYSQL_ROOT_PASSWORD=my-secret-pw

ADD ./scripts/create-schema.sql /docker-entrypoint-initdb.d

EXPOSE 3306