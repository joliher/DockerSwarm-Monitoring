# Creación de la Docker Swarm

## Añadir usuario al grupo docker
El primer paso a seguir para implementar la Docker Swarm será añadir a nuestro usuario del sistema al grupo **docker**.

Esto se hace para evitar problemas de permisos con la ejecución de comandos como `docker node ls`, `docker service ls` y otros comandos relacionados con docker.

Para hacerlo, ejecuta lo siguiente en cada nodo en el que se encuentre instalado docker:
```bash
sudo usermod -aG docker <tu_usuario>
logout
```

A continuación, vuelve a logearte con tu usuario.

> [!NOTE]
> Desde el punto de vista de la ciberseguridad, es recomendable crear tus propias reglas en el fichero **sudoers** en vez de dar permiso total a la ejecución de todos los comandos relacionados con docker, pero este proyecto actualmente no contempla esa posibilidad.

## Inicializar la swarm en el manager
El siguiente paso será inicializar la Swarm y unir los nodos Worker a la misma.

> [!WARNING]
> Si tu **red LAN** ya se encuentra dentro del rango 10.0.0.0/8, se debe de configurar manualmente otra pool de direcciones IP para evitar colisiones.

Para inicializar la Swarm si tu red LAN forma parte de la red 10.0.0.0/8 o derivados, ejecuta lo siguiente:
```bash
docker swarm init --advertise-addr <SWARM_MANAGER_IP> --default-addr-pool 172.30.0.0/16
```

Si **NO** se da el caso anterior, puedes iniciar la Swarm sin especificar nada:
```bash
docker swarm init --advertise-addr <SWARM_MANAGER_IP>
```

En cualquiera de ambos casos, guarda el token que devuelve el comando.
Lo necesitarás en el paso siguiente.

## Unir los workers a la swarm
Ejecuta el comando devuelto por el apartado anterior **en cada nodo worker** que desees unir a la swarm:
```bash
docker swarm join --token <TOKEN> <SWARM_MANAGER_IP>:2377
```

## Verificar que los workers se han unido correctamente
Desde el manager:
```bash
docker node ls
```

Deberías ver el manager y los workers en estado **Ready**.

> [!TIP]
> ### A continuación
> Una vez realizados los pasos anteriores, la Swarm ya estará creada y los nodos Worker estarán a la espera de recibir órdenes desde el nodo Manager.
>
> A continuación, puedes proceder con [04-services-setup.md](04-services-setup.md) para implementar algunos servicios a **nivel local** que se usarán exclusivamente para administrar el nodo Manager.