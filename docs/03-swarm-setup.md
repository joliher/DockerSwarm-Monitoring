# Creación de la Docker Swarm

## 1. Añadir el usuario al grupo docker
Ejecuta esto en cada máquina para no tener que usar sudo:

    sudo usermod -aG docker <tu_usuario>
    logout
A continuación, vuelve a logearte con tu usuario.

## 2. Inicializar la swarm en el manager
Sustituye <SWARM_MANAGER_IP> con la dirección IP asociada a la interfaz ubicada en la **Red Swarm**

    docker swarm init --advertise-addr <SWARM_MANAGER_IP>

## Nota
Si tu **red Lan** ya se encuentra dentro del rango 10.0.0.0/8, se debe de configurar manualmente otra pool de direcciones IP para evitar colisiones.

    docker swarm init --advertise-addr 10.5.0.1 --default-addr-pool 172.30.0.0/16

Guarda el token que devuelve el comando, lo necesitarás en el paso siguiente.

## 3. Unir los workers a la swarm
Ejecuta esto en cada worker:

    docker swarm join --token <TOKEN> <SWARM_MANAGER_IP>:2377

## 4. Verificar que los workers se han unido correctamente
Desde el manager:

    docker node ls

Deberías ver el manager y los workers en estado Ready.

## Antes de continuar
Cuando la swarm esté montada y se haya comprobado que funciona, procede con [04-services-setup.md](04-services-setup.md)