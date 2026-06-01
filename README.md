# Docker Swarm Monitoring

Proyecto de infraestructura basado en Docker Swarm con monitorización mediante Prometheus, Node Exporter y Grafana, y despliegue automatizado mediante Jenkins.

## Estructura del repositorio
...

## Primeros pasos
1. Consulta y completa los requisitos previos en [docs/01-prerequisites.md](docs/01-prerequisites.md)
2. Configura la red siguiendo [docs/02-network-setup.md](docs/02-network-setup.md)
3. Crea la swarm siguiendo [docs/03-swarm-setup.md](docs/03-swarm-setup.md)
4. Instala los servicios que se ejecutarán en el nodo Manager (Jenkins, Prometheus y Grafana) [docs/04-services-setup.md](docs/04-services-setup.md)
5. Modifica [config/global.conf](config/global.conf) con tus IPs y ejecuta [scripts/deploy.sh](scripts/deploy.sh)
6. Consulta [docs/05-post-deploy.md](docs/05-post-deploy.md) para verificar que todo funciona
7. Si deseas añadir tus propios servicios personalizados, consulta [docs/06-adding-services.md](docs/06-adding-services.md)

## Servicios disponibles tras el despliegue
| Servicio    | Puerto |
|-------------|--------|
| Nginx       | 80     |
| Jenkins     | 8080   |
| Prometheus  | 9090   |
| Grafana     | 3000   |