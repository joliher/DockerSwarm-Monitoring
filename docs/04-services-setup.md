# Instalación de servicios en el manager
A continuación se muestran los pasos a seguir para instalar los servicios de **Prometheus, Grafana y Jenkins** dentro del nodo Manager.

Cabe aclarar que todos los comandos mostrados a continuación deben de ser ejecutado dentro de éste último.

## 1. Prometheus
Prometheus se encuentra en los repositorios oficiales de Ubuntu:

### Instalar Prometheus
```bash
sudo apt install -y prometheus
```

### Verificar que se ha instalado correctamente
```bash
sudo systemctl status prometheus
```

### Detener el servicio temporalmente y borrar información residual
```bash
sudo systemctl stop prometheus
sudo rm -rf /var/lib/prometheus/metrics2/*
```

## 2. Grafana
Para instalar Grafana será necesario hacerlo desde sus repositorios oficiales:
```bash
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://apt.grafana.com/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/grafana.gpg
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install grafana
sudo systemctl daemon-reload
```

Para verificar que se ha instalado correctamente:
```bash
sudo systemctl status grafana-server
```

## 3. Jenkins
La guía de instalación oficial se encuentra en: https://www.jenkins.io/doc/book/installing/linux/

Una vez instalado, es necesario añadir al usuario jenkins al grupo docker para que pueda ejecutar comandos de Docker.

> [!NOTE]
> Al igual que en [03-swarm-setup.md](./03-swarm-setup.md), se recomienda limitar los permisos de ejecución del grupo docker mediante **sudoers** en vez de añadir al usuario directamente al grupo.

```bash
sudo usermod -aG docker jenkins
```

Para verificar que se ha instalado correctamente:
```bash
sudo systemctl status jenkins
```

## 4. Desplegar los stacks y servicios
Una vez instalados los tres servicios anteriores, ya se podrá automatizar el despliegue mediante el script [deploy.sh](../scripts/deploy.sh).

Para hacerlo, accede a la ruta `./DockerSwarm-Monitoring/config/` y modifica los siguientes parámetros en [global.conf](../config/global.conf):
```bash
export LAN_MANAGER_IP="<IP del nodo manager en la red LAN>"

export SWARM_MANAGER_IP="<IP del nodo manager en la red Swarm>"
export SWARM_WORKER1_IP="<IP del worker1 en la red Swarm>"
export SWARM_WORKER2_IP="<IP del worker2 en la red Swarm>"
```

Una vez sustituidos, accede a `./DockerSwarm-Monitoring/scripts/` y ejecuta [deploy.sh](../scripts/deploy.sh):
```bash
chmod +x deploy.sh teardown.sh
bash deploy.sh
```

Y cuando quieras detener la Swarm por completo:
```bash
bash teardown.sh
```

> [!NOTE]
> El script **teardown.sh** está pensado principalmente para **PARAR** los servicios, no para eliminarlos por completo.
>
> Si se desea eliminar toda la configuración de los servicios locales (Jenkins, Grafana y Prometheus), ejecuta con **--destroy**.
>
> Si deseas eliminar también la swarm, ejecuta **--leave-swarm**.

> [!TIP]
> ### A continuación
> Una vez ejecutado el script **deploy.sh** y los servicios se encuentren en funcionamiento, procede con [05-post-deploy.md](05-post-deploy.md) para terminar de configurar los servicios.
> Una vez hecho eso, ¡el proyecto se encontrará desplegado y listo para su uso en producción!