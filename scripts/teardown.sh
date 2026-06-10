#!/bin/bash
# Copyright (C) 2026  Jose Luis Oliver Herranz
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

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
echo "Si deseas eliminar configuraciones anteriores, ejecuta este script con el parámetro --destroy"
echo "Si solo quieres abandonar la swarm sin eliminar datos, usa: ./teardown.sh --leave-swarm"
echo "Ejemplo: ./teardown.sh [--destroy] [--leave-swarm]"

# ─────────────────────────────────────────
# Parámetro opcional: --destroy
# Elimina la swarm por completo
# Uso: ./teardown.sh --destroy
# ─────────────────────────────────────────

while [ $# -gt 0 ]; do
    case $1 in
        --destroy)
            echo "Limpiando datos persistentes..."
            sudo rm -rf /var/lib/prometheus/metrics2/*
            sudo rm -f /var/lib/grafana/grafana.db
            sudo rm -rf /var/lib/jenkins/*
        ;;
        --leave-swarm)
            echo "Abandonando la swarm..."
            docker swarm leave --force
            echo "Swarm abandonada."
        ;;
    esac
    shift
done
