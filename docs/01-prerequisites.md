# Requisitos previos

> [!NOTE]
> Este proyecto ha sido testeado principalmente con **Ubuntu 22.04** en mente.
> Se desconoce la compatibilidad de las instrucciones mostradas a continuación en otros sistemas operativos.

## Hardware
Se necesitarán:
- 2 ordenadores (1 manager + 1 worker) como mínimo.
- Sistema operativo **Ubuntu 22.04** (Desktop o Server)
- Mínimo 2 núcleos de CPU por máquina
- Mínimo 2 GB de RAM por máquina
- Mínimo 30 GB de almacenamiento por máquina

## Red
- Las 2 máquinas deben estar conectadas dentro de su propia red aislada y deben de poder comunicarse entre si.
- El manager debe tener 2 interfaces de red:
  - Una en la red LAN o expuesta a Internet (dependiendo del caso).
  - Una en la red SWARM o red interna.
- El nodo worker tendrá 1 interfaz de red, y se encontrará directamente conectado a la red SWARM.
- Los nodos worker deben de tener acceso a internet.
  - Para hacerlo, desde el nodo manager, ejecuta los siguientes comandos:

> [!NOTE]
> Sustituye **$IF_LAN** e **$IF_SWARM** por las interfaces correspondientes.

```bash
# Habilitar el enrutamiento de paquetes.
sudo sysctl -w net.ipv4.ip_forward=1
```

```bash
# Habilitar NAT a la red Swarm y aceptar las peticiones que vayan hacia Internet.
sudo iptables -t nat -I POSTROUTING 1 -o $IF_LAN -j MASQUERADE
sudo iptables -I FORWARD 1 -i $IF_SWARM -o $IF_LAN -j ACCEPT
sudo iptables -I FORWARD 2 -i $IF_LAN -o $IF_SWARM -m state --state RELATED,ESTABLISHED -j ACCEPT
```

## Software
- Ubuntu 22.04 como Sistema Operativo en cada máquina.
- Docker instalado en cada máquina
  - Guía de instalación: https://docs.docker.com/engine/install/ubuntu/

> [!TIP]
> ### A continuación
> Una vez te has asegurado de que todos los requisitos han sido cumplidos, continúa con [02-network-setup.md](02-network-setup.md) para configurar las reglas del firewall.