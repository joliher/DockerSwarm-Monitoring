#!/bin/bash

source "$(dirname "$0")/../config/global.conf"

echo "Desplegando stack de nginx..."
docker stack deploy -c ../config/swarm/web.yml web

echo "Desplegando stack de Node Exporter..."
docker stack deploy -c ../config/swarm/monitoring.yml monitor

echo "Aplicando configuración de Prometheus..."
sudo cp ../config/local/prometheus/prometheus.yml /etc/prometheus/prometheus.yml
sudo systemctl restart prometheus
sudo systemctl enable prometheus

echo "Iniciando Grafana..."
sudo systemctl start grafana-server
sudo systemctl enable grafana-server

echo "Iniciando Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo usermod -aG docker jenkins

echo "Despliegue completado."
echo "Servicios disponibles en ${MANAGER_IP}:"
echo "  Nginx:      http://${MANAGER_IP}:${PORT_NGINX}"
echo "  Jenkins:    http://${MANAGER_IP}:${PORT_JENKINS}"
echo "  Prometheus: http://${MANAGER_IP}:${PORT_PROMETHEUS}"
echo "  Grafana:    http://${MANAGER_IP}:${PORT_GRAFANA}"