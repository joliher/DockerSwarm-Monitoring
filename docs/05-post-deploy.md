# Verificación post-despliegue y últimas configuraciones

## 1. Comprobar los stacks desplegados
```bash
    docker stack ls
```

Deberías ver los stacks "web" y "monitor".

## 2. Comprobar los servicios
```bash
    docker service ls
```

Todos los servicios deben mostrar las réplicas completas (ej: 2/2).

> [!WARNING]
> Si aparece algo como 1/2 o 0/1, significa que uno de los nodos worker no es accesible y el servicio no se ha podido desplegar en ese ordenador.

## 3. Comprobar los servicios en el navegador
Accede desde cualquier máquina de la red LAN:

| Servicio   | URL                              |
|------------|----------------------------------|
| Nginx      | http://<LAN_MANAGER_IP>:80       |

Y **exclusivamente** desde el ordenador configurado previamente como el "Administrador":

| Servicio   | URL                                  |
|------------|--------------------------------------|
| Jenkins    | http://<LAN_MANAGER_IP>:8080         |
| Prometheus | http://<LAN_MANAGER_IP>:9090         |
| Grafana    | http://<LAN_MANAGER_IP>:3000         |

## 4. Comprobar Grafana
Gracias al auto-provisionamiento, el origen de datos de Prometheus y el Dashboard de los Nodos ya deberían estar cargados automáticamente.
- Accede a Grafana: `http://<LAN_MANAGER_IP>:3000` con sus credenciales por defecto.
- Ve directamente a **Dashboards** y allí verás tu panel de monitorización llamado "Prueba" listo para usarse.

## 5. Configuración inicial de Jenkins
Como el servidor de Jenkins se instala de cero, necesitas realizar un enlace inicial manual para que el motor reconozca tu repositorio y la pipeline empiece a funcionar.

### **Desbloquear Jenkins:**
Entra a `http://<MANAGER_IP>:8080`. Te pedirá una contraseña inicial que puedes obtener ejecutando este comando en el servidor manager:
```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

### **Instalar dependencias**:
- Selecciona <u>Install suggested plugins</u> y crea tu usuario administrador.
- Crear el trabajo (Job):
    - En el panel principal haz clic en <u>Nueva Tarea (New Item)</u>.
    - Escribe un nombre (por ejemplo **Monitor-Web**), selecciona el tipo <u>**Pipeline**</u> y dale a OK.

### **Vincular el código**:
- En la configuración del Pipeline, baja hasta la sección <u>**Pipeline definition**</u>.
- Elige <u>**Pipeline script from SCM**</u>.
- En <u>**SCM**</u>, elige **"Git"**.
- En <u>**Repository URL**</u>, pon la ruta al repositorio de este proyecto: https://github.com/joliher/DockerSwarm-Monitoring.git
- En <u>**Branch Specifier**</u> indica ***/main**
- En <u>**Script Path**</u>, asegúrate de que ponga exactamente <u>config/local/jenkins/Jenkinsfile</u>

### **Primera ejecución**:
- Guarda la configuración y dale al botón de <u>**Construir ahora (Build Now)**</u>.
- En este momento, Jenkins clonará tus ficheros por primera vez, creará la variable de entorno interna ${WORKSPACE} y ejecutará los pasos automatizados.

A partir de este momento, cada 5 minutos se ejecutará la pipeline, que se asegurará de que el stack web se encuentre siempre desplegado, generando logs acordes.
Los logs son accesibles desde: `/var/lib/jenkins/workspace/<nombre de la tarea>/stack_monitor.log`

> [!TIP]
> ### A continuación
> ¡El proyecto se encuentra desplegado y listo para producción!
>
> Si lo consideras o lo necesitas, los scripts son escalables en función de los nodos Worker que se quieran utilizar, así como las funcionalidades y servicios que van a estar desplegados.
>
> Si deseas añadir tus propios servicios con imagenes oficiales o personalizadas, puedes proceder con [06-adding-services.md](06-adding-services.md)