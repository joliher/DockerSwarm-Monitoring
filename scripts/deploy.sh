#!/bin/bash
# Copyright (C) 2026  Jose Luis Oliver Herranz
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

source "$(dirname "$0")/../config/global.conf"

## DESPLIEGUE DE SERVICIOS EN LOS NODOS WORKERS
# NGINX
echo "Desplegando stack de nginx..."
envsubst < ../config/swarm/web.yml | docker stack deploy -c - web &>/dev/null

# NODE EXPORTER
echo "Desplegando stack de Node Exporter..."
envsubst < ../config/swarm/monitoring.yml | docker stack deploy -c - monitor &>/dev/null

# AÑADE OTROS SERVICIOS AQUÍ
# echo "Desplegando stack de otro servicio..."
# docker stack deploy -c ../config/swarm/otro_servicio.yml otro_servicio

## SERVICIOS LOCALES DEL NODO MANAGER.
# NODE EXPORTER
echo "Aplicando configuración de Node Exporter..."
envsubst < ../config/local/node-exporter/node-exporter | sudo tee /etc/default/prometheus-node-exporter &>/dev/null
sudo systemctl restart prometheus-node-exporter &>/dev/null
sudo systemctl enable prometheus-node-exporter &>/dev/null

# PROMETHEUS
echo "Aplicando configuración de Prometheus..."
envsubst < ../config/local/prometheus/prometheus.yml | sudo tee /etc/prometheus/prometheus.yml &>/dev/null
sudo systemctl restart prometheus &>/dev/null
sudo systemctl enable prometheus &>/dev/null

# GRAFANA
echo "Iniciando Grafana..."

envsubst < ../config/local/grafana/datasource.yml | sudo tee /etc/grafana/provisioning/datasources/datasource.yml &>/dev/null
sudo cp ../config/local/grafana/dashboard.yml /etc/grafana/provisioning/dashboards/ &>/dev/null

sudo mkdir -p /var/lib/grafana/dashboards
sudo cp ../config/local/grafana/dashboards/example.json /var/lib/grafana/dashboards/ &>/dev/null

sudo chown -R grafana:grafana /etc/grafana/provisioning/
sudo chown -R grafana:grafana /var/lib/grafana/dashboards/

sudo systemctl restart grafana-server &>/dev/null
sudo systemctl enable grafana-server &>/dev/null

# JENKINS
echo "Iniciando Jenkins..."
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins &>/dev/null
sudo systemctl enable jenkins &>/dev/null

# RESUMEN
echo "Despliegue completado."
echo "Servicios disponibles en ${LAN_MANAGER_IP}:"
echo "  Nginx:      http://${LAN_MANAGER_IP}:${PORT_NGINX}"
echo "  Jenkins:    http://${LAN_MANAGER_IP}:${PORT_JENKINS}"
echo "  Prometheus: http://${LAN_MANAGER_IP}:${PORT_PROMETHEUS}"
echo "  Grafana:    http://${LAN_MANAGER_IP}:${PORT_GRAFANA}"