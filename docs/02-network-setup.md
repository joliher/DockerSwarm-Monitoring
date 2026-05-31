# Configuración de red

## Esquema de red
<imagen del plano de red>

## Red LAN
Red desde la que el administrador accede al nodo manager.
El manager actúa como enrutador entre la red LAN y la red Swarm.

## Red Swarm
Red interna a través de la cual se comunican el manager y los workers.
Los workers no son accesibles directamente desde la red LAN.

## Configurar el manager como enrutador
Añade las siguientes líneas al crontab del manager con `crontab -e`:

    @reboot echo 1 > /proc/sys/net/ipv4/ip_forward
    @reboot iptables -I FORWARD 1 -i <interfaz_LAN> -o <interfaz_Swarm> -j ACCEPT && iptables -I FORWARD 2 -i <interfaz_Swarm> -o <interfaz_LAN> -j ACCEPT
    @reboot iptables -t nat -I POSTROUTING 1 -o <interfaz_LAN> -j MASQUERADE

Sustituye <interfaz_LAN> y <interfaz_Swarm> por los nombres
de tus interfaces de red (ej: ens18, ens19).

## Antes de continuar
Una vez configurada la red, continúa con
[03-swarm-setup.md](03-swarm-setup.md)