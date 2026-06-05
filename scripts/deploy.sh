#!/bin/bash

source "$(dirname "$0")/../config/global.conf"

## DESPLIEGUE DE SERVICIOS EN LOS NODOS WORKERS
# NGINX
echo "Desplegando stack de nginx..."
envsubst < ../config/swarm/web.yml | docker stack deploy -c - web

# NODE EXPORTER
echo "Desplegando stack de Node Exporter..."
envsubst < ../config/swarm/monitoring.yml | docker stack deploy -c - monitor

# AÑADE OTROS SERVICIOS AQUÍ
# echo "Desplegando stack de otro servicio..."
# docker stack deploy -c ../config/swarm/otro_servicio.yml otro_servicio

## SERVICIOS LOCALES DEL NODO MANAGER.
# NODE EXPORTER
echo "Aplicando configuración de Node Exporter..."
envsubst < ../config/local/node-exporter/node-exporter.defaults | sudo tee /etc/default/prometheus-node-exporter
sudo systemctl restart prometheus-node-exporter
sudo systemctl enable prometheus-node-exporter

# PROMETHEUS
echo "Aplicando configuración de Prometheus..."
envsubst < ../config/local/prometheus/prometheus.yml | sudo tee /etc/prometheus/prometheus.yml
sudo systemctl restart prometheus
sudo systemctl enable prometheus

# GRAFANA
echo "Iniciando Grafana..."

envsubst < ../config/local/grafana/datasource.yml | sudo tee /etc/grafana/provisioning/datasources/datasource.yml
sudo cp ../config/local/grafana/dashboards.yml /etc/grafana/provisioning/dashboards/

sudo mkdir -p /var/lib/grafana/dashboards
sudo cp ../config/local/grafana/dashboards/example.json /var/lib/grafana/dashboards/

sudo chown -R grafana:grafana /etc/grafana/provisioning/
sudo chown -R grafana:grafana /var/lib/grafana/dashboards/

sudo systemctl start grafana-server
sudo systemctl enable grafana-server

# JENKINS
echo "Iniciando Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo usermod -aG docker jenkins

# RESUMEN
echo "Despliegue completado."
echo "Servicios disponibles en ${LAN_MANAGER_IP}:"
echo "  Nginx:      http://${LAN_MANAGER_IP}:${PORT_NGINX}"
echo "  Jenkins:    http://${LAN_MANAGER_IP}:${PORT_JENKINS}"
echo "  Prometheus: http://${LAN_MANAGER_IP}:${PORT_PROMETHEUS}"
echo "  Grafana:    http://${LAN_MANAGER_IP}:${PORT_GRAFANA}"