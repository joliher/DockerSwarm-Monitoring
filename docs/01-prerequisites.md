# Requisitos previos
A continuación se muestran los requisitos mínimos para poder implementar la red Swarm con 1 nodo manager y 2 nodos worker.

## Hardware
Se necesitarán:
- 3 máquinas físicas o virtuales
- Mínimo 2 núcleos de CPU por máquina
- Mínimo 2 GB de RAM por máquina
- Mínimo 50 GB de almacenamiento por máquina

## Software
- Ubuntu Server en cada máquina
- Docker instalado en cada máquina
  - Guía de instalación: https://docs.docker.com/engine/install/ubuntu/

## Red
- Las 3 máquinas deben poder comunicarse entre sí y deben estar en su propia red aislada, separada de la red doméstica o corporativa.
- El manager debe tener 2 interfaces de red:
  - Una en la red LAN doméstica o corporativa (actuará de enrutador)
  - Una en la red Swarm

## Antes de continuar
Una vez cumplidos los requisitos, continúa con
[02-network-setup.md](02-network-setup.md)