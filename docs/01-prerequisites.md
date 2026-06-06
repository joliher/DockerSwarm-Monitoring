> [!IMPORTANT]
> ### Requisitos previos
> A continuación se muestran los requisitos mínimos para implementar este proyecto.

## Hardware
Se necesitarán:
- 3 máquinas físicas o virtuales
- Mínimo 2 núcleos de CPU por máquina
- Mínimo 2 GB de RAM por máquina
- Mínimo 50 GB de almacenamiento por máquina

## Red
- Las 3 máquinas deben poder comunicarse entre sí y deben estar en su propia red aislada, separada de la red doméstica o corporativa.
- El manager debe tener 2 interfaces de red:
  - Una en la red LAN doméstica o expuesta a Internet (actuará de enrutador).
  - Una en la red Swarm o red interna.
- Los nodos worker deben de tener acceso a internet.
```bash
  # Ejecutar los siguientes comandos desde el nodo manager
  # Sustituye **$IF_LAN** y **$IF_SWARM** por las interfaces LAN y SWARM respectivamente.
  sudo sysctl -w net.ipv4.ip_forward=1
  sudo iptables -t nat -I POSTROUTING 1 -o $IF_LAN -j MASQUERADE
  sudo iptables -I FORWARD 1 -i $IF_SWARM -o $IF_LAN -j ACCEPT
  sudo iptables -I FORWARD 2 -i $IF_LAN -o $IF_SWARM -m state --state RELATED,ESTABLISHED -j ACCEPT
```

## Software
- Ubuntu Server en cada máquina
- Docker instalado en cada máquina
  - Guía de instalación: https://docs.docker.com/engine/install/ubuntu/

> [!TIP]
> ### A continuación
> Una vez cumplidos los requisitos, continúa con [02-network-setup.md](02-network-setup.md)