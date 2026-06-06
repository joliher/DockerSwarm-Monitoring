#!/bin/bash

source "$(dirname "$0")/../config/global.conf"

echo "Eliminando stacks de la swarm..."
docker stack rm web
docker stack rm monitor

echo "Esperando a que los servicios se detengan..."
sleep 10

echo "Deteniendo servicios locales..."
sudo systemctl stop prometheus-node-exporter &>/dev/null
sudo systemctl disable prometheus-node-exporter &>/dev/null

sudo systemctl stop prometheus &>/dev/null
sudo systemctl disable prometheus &>/dev/null

sudo systemctl stop grafana-server &>/dev/null
sudo systemctl disable grafana-server &>/dev/null

sudo systemctl stop jenkins &>/dev/null
sudo systemctl disable jenkins &>/dev/null

echo "Entorno eliminado correctamente."

# ─────────────────────────────────────────
# Parámetro opcional: --destroy
# Elimina la swarm por completo
# Uso: ./teardown.sh --destroy
# ─────────────────────────────────────────
if [ "$1" == "--destroy" ]; then
    echo "Eliminando completamente la swarm y limpiando datos persistentes..."
    sudo rm -rf /var/lib/prometheus/metrics2/*
    sudo rm -f /var/lib/grafana/grafana.db
    sudo rm -rf /var/lib/jenkins/*

    echo "Abandonando la swarm..."
    docker swarm leave --force
    echo "Swarm abandonada."
fi