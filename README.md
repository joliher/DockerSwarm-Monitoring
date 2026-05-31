# Docker Swarm Monitoring

Proyecto de infraestructura basado en Docker Swarm con monitorización mediante Prometheus, Node Exporter y Grafana, y despliegue automatizado mediante Jenkins.

## Requisitos previos
Consulta [docs/01-prerequisites.md](docs/01-prerequisites.md)

## Estructura del repositorio
...

## Primeros pasos
1. Consulta y completa los pasos de [docs/01-prerequisites.md](docs/01-prerequisites.md)
2. Configura la red siguiendo [docs/02-network-setup.md](docs/02-network-setup.md)
3. Crea la swarm siguiendo [docs/03-swarm-setup.md](docs/03-swarm-setup.md)
4. Modifica config/global.conf con tus IPs
5. Ejecuta scripts/deploy.sh
6. Consulta [docs/04-post-deploy.md](docs/04-post-deploy.md) para verificar que todo funciona

## Servicios disponibles tras el despliegue
| Servicio    | Puerto |
|-------------|--------|
| Nginx       | 80     |
| Jenkins     | 8080   |
| Prometheus  | 9090   |
| Grafana     | 3000   |