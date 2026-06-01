# Verificación post-despliegue

## Comprobar los stacks desplegados

    docker stack ls

Deberías ver los stacks "web" y "monitor".

## Comprobar los servicios

    docker service ls

Todos los servicios deben mostrar las réplicas completas (ej: 2/2).

## Comprobar los servicios en el navegador
Accede desde cualquier máquina de la red LAN:

| Servicio   | URL                              |
|------------|----------------------------------|
| Nginx      | http://<MANAGER_IP>:80           |
| Jenkins    | http://<MANAGER_IP>:8080         |
| Prometheus | http://<MANAGER_IP>:9090         |
| Grafana    | http://<MANAGER_IP>:3000         |

## Comprobar Prometheus
Accede a http://<MANAGER_IP>:9090/targets
y verifica que los workers aparecen como UP.

## Importar el dashboard en Grafana
1. Accede a Grafana con las credenciales admin/admin
2. Ve a Dashboards → New → Import
3. Importa el fichero config/grafana/dashboard.json

# Añadir servicios custom
Si deseas añadir tus propios servicios a través de imágenes de docker, ya sean oficiales o personalizadas, procede con [06-adding-services.md](06-adding-services.md)