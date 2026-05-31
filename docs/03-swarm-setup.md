# Creación de la Docker Swarm

## 1. Añadir el usuario al grupo docker
Ejecuta esto en cada máquina para no tener que usar sudo:

    sudo usermod -aG docker <tu_usuario>
    logout

## 2. Inicializar la swarm en el manager

    docker swarm init --advertise-addr <SWARM_MANAGER_IP>

Guarda el token que devuelve el comando, lo necesitarás en el paso siguiente.

## 3. Unir los workers a la swarm
Ejecuta esto en cada worker:

    docker swarm join --token <TOKEN> <SWARM_MANAGER_IP>:2377

## 4. Verificar que los workers se han unido correctamente
Desde el manager:

    docker node ls

Deberías ver el manager y los workers en estado Ready.

## Antes de continuar
Una vez formada la swarm, modifica config/global.conf
con tus IPs y ejecuta scripts/deploy.sh