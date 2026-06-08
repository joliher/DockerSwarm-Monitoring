# Configuración de red y Firewall

> [!NOTE]
> El proyecto ha sido pensado para implementarse dentro de una RED LOCAL sin estar expuesta directamente a Internet.
>
> Si se desea exponer algún servicio a Internet, es posible hacerlo.
> Para ello, es necesario **conectar directamente a Internet** el nodo manager  mediante una IP pública proporcionada por tu ISP o **a través de una DMZ** configurada en el propio router.
>
> Cualquiera de las 2 opciones es perfectamente válida.

## Hacer persistente la configuración IP
Para hacerlo, previamente será necesario instalar el paquete **iptables-persistent**.

Solo es necesario instalarlo en el **nodo manager**.

```bash
sudo apt-get update
sudo apt-get install -y iptables-persistent
```

Una vez instalado, accede a la carpeta `./DockerSwarm-Monitoring/scripts/` del proyecto.

Modifica los siguientes valores en [conf_iptables.sh](../scripts/conf_iptables.sh)
```bash
IP_ADMIN="TU_IP_AQUI" # <---- La dirección IP que tendrá acceso a los servicios internos del nodo manager.
IF_LAN="enp0s3"
IF_SWARM="enp0s8"
```
Por último, ejecuta el script.
```bash
chmod +x conf_iptables.sh
bash conf_iptables.sh
```

> [!TIP]
> ### A continuación
> Una vez realizados los pasos anteriores, tendrás un Firewall configurado para evitar peticiones no deseadas.
>
> Para continuar con la implementación, revisa [03-swarm-setup.md](03-swarm-setup.md) para poner en marcha Docker Swarm.