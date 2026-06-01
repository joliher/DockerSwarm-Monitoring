# Instalación de servicios en el manager

Antes de ejecutar deploy.sh es necesario instalar los siguientes
servicios en el nodo manager. Todos los comandos deben ejecutarse
desde el manager.

## Prometheus

Prometheus se encuentra en los repositorios oficiales de Ubuntu:

    sudo apt install prometheus

Verificar que se ha instalado correctamente:

    sudo systemctl status prometheus

## Grafana

    curl https://packages.grafana.com/gpg.key | sudo apt-key add -
    echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install grafana

Verificar que se ha instalado correctamente:

    sudo systemctl status grafana-server

## Jenkins

La guía de instalación oficial se encuentra en:
https://www.jenkins.io/doc/book/installing/linux/

Una vez instalado, es necesario añadir al usuario jenkins
al grupo docker para que pueda ejecutar comandos de Docker:

    sudo usermod -aG docker jenkins

Verificar que se ha instalado correctamente:

    sudo systemctl status jenkins

## Antes de continuar
Una vez instalados los tres servicios, modifica config/global.conf con tus IPs y ejecuta scripts/deploy.sh
A continuación, consulta [05-post-deploy.md](05-post-deploy.md) para comprobar que todo se está ejecutando correctamente.