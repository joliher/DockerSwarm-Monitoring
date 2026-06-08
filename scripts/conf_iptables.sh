#!/bin/bash

# Sustituye estos valores por los tuyos
IP_ADMIN="TU_IP_AQUI"
IF_LAN="enp0s3"
IF_SWARM="enp0s8"

# --- 1. PROTEGER EL SERVIDOR (INPUT) ---
# Permitir tráfico local y respuestas de internet (CRÍTICO)
sudo iptables -I INPUT 1 -i lo -j ACCEPT
sudo iptables -I INPUT 2 -m state --state RELATED,ESTABLISHED -j ACCEPT
# Permitir acceso total al administrador
sudo iptables -A INPUT -i $IF_LAN -s $IP_ADMIN -j ACCEPT
# Bloquear el resto en la LAN
sudo iptables -A INPUT -i $IF_LAN -j DROP

# --- 2. PROTEGER LOS CONTENEDORES (DOCKER-USER) ---
# Asegurar que la cadena existe por si Docker no está arrancado
sudo iptables -N DOCKER-USER 2>/dev/null || true
# Permitir el tráfico de vuelta (respuestas de internet) para contenedores y workers
sudo iptables -I DOCKER-USER 1 -m state --state RELATED,ESTABLISHED -j RETURN
# Permitir que el mundo acceda al Nginx (puerto 80)
sudo iptables -I DOCKER-USER 2 -i $IF_LAN -p tcp --dport 80 -j RETURN
# Bloquear el resto del tráfico a contenedores que no sea del administrador
sudo iptables -I DOCKER-USER 3 -i $IF_LAN ! -s $IP_ADMIN -j DROP
# Devolver el tráfico permitido a Docker
sudo iptables -A DOCKER-USER -j RETURN

sudo netfilter-persistent save