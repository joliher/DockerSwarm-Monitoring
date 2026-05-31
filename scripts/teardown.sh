#!/bin/bash

source "$(dirname "$0")/../config/global.conf"

echo "Eliminando stacks de la swarm..."
docker stack rm web
docker stack rm monitor

echo "Esperando a que los servicios se detengan..."
sleep 10

echo "Abandonando la swarm..."
docker swarm leave --force

echo "Deteniendo servicios locales..."
sudo systemctl stop prometheus
sudo systemctl disable prometheus

sudo systemctl stop grafana-server
sudo systemctl disable grafana-server

sudo systemctl stop jenkins
sudo systemctl disable jenkins

echo "Entorno eliminado correctamente."