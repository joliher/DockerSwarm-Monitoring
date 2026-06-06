# Docker Swarm Monitoring

Proyecto de infraestructura basado en Docker Swarm con monitorización mediante Prometheus, Node Exporter y Grafana, y despliegue automatizado mediante Jenkins.

## Estructura del repositorio
```text
.
├── config
│   ├── global.conf
│   ├── local
│   │   ├── grafana
│   │   │   ├── dashboards
│   │   │   │   └── example.json
│   │   │   ├── dashboard.yml
│   │   │   └── datasource.yml
│   │   ├── jenkins
│   │   │   └── Jenkinsfile
│   │   ├── node-exporter
│   │   │   └── node-exporter
│   │   └── prometheus
│   │       └── prometheus.yml
│   └── swarm
│       ├── monitoring.yml
│       └── web.yml
├── docs
│   ├── 01-prerequisites.md
│   ├── 02-network-setup.md
│   ├── 03-swarm-setup.md
│   ├── 04-services-setup.md
│   ├── 05-post-deploy.md
│   └── 06-adding-services.md
├── img
│   └── plano.png
├── README.md
└── scripts
    ├── conf_iptables.sh
    ├── deploy.sh
    └── teardown.sh
```

## Primeros pasos
1. Consulta y completa los requisitos previos en [docs/01-prerequisites.md](docs/01-prerequisites.md)
2. Configura la red siguiendo [docs/02-network-setup.md](docs/02-network-setup.md)
3. Crea la swarm siguiendo [docs/03-swarm-setup.md](docs/03-swarm-setup.md)
4. Instala los servicios que se ejecutarán en el nodo Manager (Jenkins, Prometheus y Grafana) [docs/04-services-setup.md](docs/04-services-setup.md)
5. Consulta [docs/05-post-deploy.md](docs/05-post-deploy.md) para verificar que todo funciona correctamente.
6. Si deseas añadir tus propios servicios personalizados, consulta [docs/06-adding-services.md](docs/06-adding-services.md)

## Servicios disponibles tras el despliegue
| Servicio    | Puerto |
|-------------|--------|
| Nginx       | 80     |
| Jenkins     | 8080   |
| Prometheus  | 9090   |
| Grafana     | 3000   |