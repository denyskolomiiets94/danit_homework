#!/bin/bash
set -e

info() {
 echo "### [DB] $1"
}

info "Оновлення пакетів"
apt-get update -y

info "Встановлення PostgreSQL"
apt-get install -y postgresql postgresql-contrib netcat-openbsd

info "Налаштування мережі PostgreSQL"

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" \
/etc/postgresql/*/main/postgresql.conf

echo "host all all 192.168.1.0/24 md5" >> \
/etc/postgresql/*/main/pg_hba.conf

info "Перезапуск PostgreSQL"
systemctl restart postgresql

info "Створення БД та користувача"

sudo -u postgres psql -v ON_ERROR_STOP=1 <<EOF

SELECT 'CREATE DATABASE ${DB_NAME}'
WHERE NOT EXISTS (
SELECT FROM pg_database WHERE datname='${DB_NAME}'
)\gexec

DO \$\$
BEGIN
IF NOT EXISTS (
SELECT FROM pg_roles WHERE rolname='${DB_USER}'
) THEN
CREATE USER ${DB_USER} WITH PASSWORD '${DB_PASS}';
END IF;
END
\$\$;

GRANT ALL PRIVILEGES ON DATABASE ${DB_NAME} TO ${DB_USER};

EOF

info "База готова"
