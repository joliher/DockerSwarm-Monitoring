> [!IMPORTANT]
> ### Instalación de servicios en el manager
> Antes de ejecutar deploy.sh es necesario instalar los siguientes servicios en el nodo manager.
> Todos los comandos listados a continuación deben ejecutarse en el **nodo manager**.

## Prometheus

Prometheus se encuentra en los repositorios oficiales de Ubuntu:

### 1. Instalar Prometheus
```bash
    sudo apt install -y prometheus
```

### 2. Verificar que se ha instalado correctamente:
```bash
    sudo systemctl status prometheus
```

### 3. Detener el servicio y borrar información temporal.
```bash
    sudo systemctl stop prometheus
    sudo rm -rf /var/lib/prometheus/metrics2/*
```

## Grafana
```bash
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://apt.grafana.com/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/grafana.gpg
    echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee /etc/apt/sources.list.d/grafana.list
    sudo apt-get update
    sudo apt-get install grafana
```

Verificar que se ha instalado correctamente:
```bash
    sudo systemctl status grafana-server
```

## Jenkins

La guía de instalación oficial se encuentra en: https://www.jenkins.io/doc/book/installing/linux/

Una vez instalado, es necesario añadir al usuario jenkins
al grupo docker para que pueda ejecutar comandos de Docker:
```bash
    sudo usermod -aG docker jenkins
```

Verificar que se ha instalado correctamente:
```bash
    sudo systemctl status jenkins
```

> [!TIP]
> ### A continuación
> Una vez instalados los tres servicios, modifica [../config/global.conf](../config/global.conf) con tus IPs y ejecuta [../scripts/deploy.sh](../scripts/deploy.sh)
> A continuación, consulta [05-post-deploy.md](05-post-deploy.md) para comprobar que todo se está ejecutando correctamente.