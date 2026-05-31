# Añadir nuevos servicios a la swarm

## 1. Crear el fichero de stack
Crea un nuevo fichero .yml en config/swarm/ siguiendo
la estructura de los existentes. Por ejemplo:

    # Stack de <nombre del servicio>
    version: '3'
    services:
      <nombre>:
        image: <imagen>
        ports:
          - "<puerto>:<puerto>"
        deploy:
          mode: global

## 2. Desplegarlo en la swarm

    docker stack deploy -c config/swarm/<nombre>.yml <nombre>

## 3. Añadirlo a deploy.sh y teardown.sh
Para que el nuevo servicio se despliegue y elimine
automáticamente junto al resto, añade en deploy.sh:

    docker stack deploy -c ../config/swarm/<nombre>.yml <nombre>

Y en teardown.sh:

    docker stack rm <nombre>