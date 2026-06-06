> [!IMPORTANT]
> ### Añadir nuevos servicios a la swarm
> Si deseas añadir tus propios servicios, ya sea utilizando imágenes oficiales de docker o modificando las imágenes oficiales con tus propias configuraciones, a continuación se te muestra como hacerlo.

## 1. Crear el fichero de stack
Crea un nuevo fichero .yml en config/swarm/ siguiendo
la estructura de los existentes. Por ejemplo:

```bash
    # Stack de <nombre del servicio>
    version: '3'
    services:
      <nombre>:
        image: <imagen>
        ports:
          - "<puerto>:<puerto>"
        deploy:
          mode: global
```

## 2. Desplegarlo en la swarm
```bash
    docker stack deploy -c config/swarm/<nombre>.yml <nombre>
```

## 3. Añadirlo a deploy.sh y teardown.sh
Para que el nuevo servicio se despliegue y elimine automáticamente junto al resto, añade en deploy.sh:
```bash
    docker stack deploy -c ../config/swarm/<nombre>.yml <nombre>
```

Y en teardown.sh:
```bash
    docker stack rm <nombre>
```

> [!TIP]
> Si estás utilizando una imagen personalizada, asegúrate de que ésta se encuentre disponible en el nodo manager, así como tener una copia de la misma.