# Añadir nuevos servicios a la swarm
Si deseas añadir tus propios servicios, ya sea utilizando imagenes oficiales de otros servicios, como wordpress, prestashop, etc. o utilizando imagenes personalizadas basadas en tus necesidades específicas, a continuación se te muestra como hacerlo.

## 1. Crear el fichero de stack
Crea un nuevo fichero .yml en config/swarm/ siguiendo la estructura de los existentes. <br>
Por ejemplo:

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
          placement:
            constraints:
            - node.role == worker
```

> [!NOTE]
> Si prefieres añadir algún parámetro a este fichero a través de variables, puedes añadirlas sin ningún problema al fichero [global.conf](../config/global.conf)

## 2. Añadirlo a deploy.sh y teardown.sh
Si has decidido añadir alguna variable al fichero [global.conf](../config/global.conf), bastará con añadir el siguiente contenido al script [deploy.sh](../scripts/deploy.sh)
```bash
envsubst < ../config/swarm/ejemplo.yml | docker stack deploy -c - ejemplo &>/dev/null
```
o si el contenido del fichero .yml está hardcodeado y no utiliza variables:
```bash
docker stack deploy -c config/swarm/ejemplo.yml ejemplo
```

<br>

Y en teardown.sh:
```bash
docker stack rm ejemplo
```

> [!TIP]
> Y recuerda que el proyecto es de código abierto y ajustable según las necesidades individuales de cada uno.
>
> Siéntete libre de analizar y modificar el comportamiento del proyecto en base a tus necesidades.
>
> A partir de esta base, sientete libre de convertir el proyecto en algo totalmente propio ^^