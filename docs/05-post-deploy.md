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

## Comprobar Grafana
Gracias al auto-provisionamiento, el origen de datos de Prometheus y el Dashboard de los Nodos ya deberían estar cargados automáticamente.
1. Accede a Grafana: `http://<MANAGER_IP>:3000` (credenciales por defecto: `admin` / `admin`).
2. Ve directamente a **Dashboards** y allí verás tu panel de monitorización listo para usarse.

## Configuración inicial de Jenkins
Como el servidor de Jenkins se instala de cero, necesitas realizar un enlace inicial manual para que el motor reconozca tu repositorio y la pipeline empiece a funcionar:
1. **Desbloquear Jenkins:** Entra a `http://<MANAGER_IP>:8080`. Te pedirá una contraseña inicial que puedes obtener ejecutando este comando en el servidor manager:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
2. **Instalar dependencias**: Selecciona "Install suggested plugins" y crea tu usuario administrador.
3. **Crear el trabajo (Job)**:
En el panel principal haz clic en "Nueva Tarea" (New Item).
Escribe un nombre (por ejemplo Monitor-Web), selecciona el tipo "Pipeline" y dale a OK.
4. **Vincular el código**:
En la configuración del Pipeline, baja hasta la sección Pipeline definition.
Elige "Pipeline script from SCM".
En SCM, elige Git.
En Repository URL, pon la ruta al repositorio de este proyecto (https://github.com/joliher/DockerSwarm-Monitoring.git).
En Branch Specifier indica */main
En Script Path, asegúrate de que ponga exactamente: config/local/jenkins/Jenkinsfile
5. **Primera ejecución**:
Guarda la configuración y dale al botón de "Construir ahora" (Build Now).
En este momento, Jenkins clonará tus ficheros por primera vez, creará la variable de entorno interna ${WORKSPACE} y ejecutará los pasos automatizados.

A partir de este momento, cada 5 minutos se ejecutará la pipeline, que se asegurará de que el stack web se encuentre siempre desplegado, generando logs acordes.
Los logs son accesibles desde: /var/lib/jenkins/workspace/<nombre de la tarea>/stack_monitor.log

## Importar el dashboard en Grafana
1. Accede a Grafana con las credenciales admin/admin
2. Ve a Dashboards → New → Import
3. Importa el fichero config/grafana/dashboard.json

# Añadir servicios custom
Si deseas añadir tus propios servicios a través de imágenes de docker, ya sean oficiales o personalizadas, procede con [06-adding-services.md](06-adding-services.md)