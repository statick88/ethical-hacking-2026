#!/bin/bash
# Script de verificación para lab8
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Verificación lab8 ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contenedores de este lab
CONTAINERS=(lab8-api lab8-db lab8-kali)

# 1. Verificar contenedores
echo -e "${BLUE}=== Paso 1: Verificando contenedores ===${NC}"

ALL_RUNNING=true
for container in "${CONTAINERS[@]}"; do
    if docker ps --format "{{.Names}}" | grep -q "$container"; then
        echo -e "${GREEN}[OK]${NC} Contenedor $container está corriendo"
    else
        echo -e "${RED}[ERROR]${NC} Contenedor $container NO está corriendo"
        ALL_RUNNING=false
    fi
done

# 2. Verificar recursos
echo ""
echo -e "${BLUE}=== Paso 2: Verificando recursos ===${NC}"

for container in "${CONTAINERS[@]}"; do
    if docker ps --format "{{.Names}}" | grep -q "$container"; then
        MEM_USAGE=$(docker stats --no-stream --format "{{.MemUsage}}" $container)
        echo -e "${GREEN}[INFO]${NC} $container: $MEM_USAGE"
    fi
done

# 3. Resumen
echo ""
echo -e "${BLUE}=== Resumen de Verificación ===${NC}"

if $ALL_RUNNING; then
    echo -e "${GREEN}[OK]${NC} Todos los contenedores están corriendo"
    echo -e "${GREEN}[OK]${NC} lab8 está listo para usar"
else
    echo -e "${RED}[ERROR]${NC} Algunos contenedores no están corriendo"
    echo -e "${YELLOW}[INFO]${NC} Ejecuta: ./setup.sh para iniciar el lab"
fi
