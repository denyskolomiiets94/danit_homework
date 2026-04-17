#!/bin/bash
set -e

info() {
 echo "### [APP] $1"
}

info "Оновлення пакетів"
apt-get update -y

info "Встановлення Java / Git / Netcat"
apt-get install -y openjdk-17-jdk git netcat-openbsd

info "Створення користувача"
id -u appuser &>/dev/null || useradd -m appuser

cd /home/appuser

info "Інсталювання postgresql-client"
apt-get install -y postgresql-client #роблю інсталяцію  postgresql-client, щоб мати потім можливість підключення до БД

info "Клонування репозиторію"

if [ ! -d spring-petclinic ]; then
 sudo -u appuser git clone https://github.com/spring-projects/spring-petclinic.git
fi

chown -R appuser:appuser /home/appuser

info "Очікування БД"

until nc -z ${DB_IP} 5432; do
 echo "БД ще не готова..."
 sleep 2
done

info "Створення .env"

cat > /home/appuser/.env <<EOF
SPRING_PROFILES_ACTIVE=${SPRING_PROFILES_ACTIVE}
SPRING_DATASOURCE_URL=jdbc:postgresql://${DB_IP}:5432/${DB_NAME}
SPRING_DATASOURCE_USERNAME=${DB_USER}
SPRING_DATASOURCE_PASSWORD=${DB_PASS}
SPRING_JPA_HIBERNATE_DDL_AUTO=update
EOF

chown appuser:appuser /home/appuser/.env
chmod 600 /home/appuser/.env

cd /home/appuser/spring-petclinic

info "Збірка застосунку "

sudo -u appuser ./mvnw clean package -DskipTests

info "Копіювання jar"

cp target/*.jar /home/appuser/app.jar
chown appuser:appuser /home/appuser/app.jar

info "Встановлення systemd"

cp /vagrant/provision/petclinic.service \
/etc/systemd/system/petclinic.service

chmod 644 /etc/systemd/system/petclinic.service

systemctl daemon-reload
systemctl enable petclinic
systemctl restart petclinic

info "Застосунок готовий"
