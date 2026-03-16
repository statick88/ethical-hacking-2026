#!/bin/bash
# Script de setup para lab5
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Setup lab5 ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contenedores de este lab
CONTAINERS=(lab5-log4shell lab5-jenkins lab5-kali)

# 1. Verificar dependencias
echo -e "${BLUE}=== Paso 1: Verificando dependencias ===${NC}"
if command -v docker &> /dev/null; then
    echo -e "${GREEN}[OK]${NC} Docker instalado: $(docker --version | head -n1)"
else
    echo -e "${RED}[ERROR]${NC} Docker no encontrado"
    exit 1
fi

# 2. Verificar contenedores existentes
echo ""
echo -e "${BLUE}=== Paso 2: Verificando contenedores existentes ===${NC}"

for container in "${CONTAINERS[@]}"; do
    if docker ps -a --format "{{.Names}}" | grep -q "$container"; then
        echo -e "${YELLOW}[AVISO]${NC} El contenedor $container ya existe"
        read -p "¿Deseas eliminarlo y recrearlo? (s/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Ss]$ ]]; then
            echo "Eliminando contenedores existentes..."
            docker-compose down
            break
        else
            echo -e "${GREEN}[INFO]${NC} Manteniendo contenedores existentes"
            exit 0
        fi
    fi
done

# 3. Iniciar los servicios
echo ""
echo -e "${BLUE}=== Paso 3: Iniciando servicios Docker ===${NC}"
docker-compose up -d

# 4. Verificar estado de los contenedores
echo ""
echo -e "${BLUE}=== Paso 4: Verificando estado de contenedores ===${NC}"
sleep 5

for container in "${CONTAINERS[@]}"; do
    if docker ps --format "{{.Names}}" | grep -q "$container"; then
        echo -e "${GREEN}[OK]${NC} Contenedor $container está corriendo"
    else
        echo -e "${RED}[ERROR]${NC} Contenedor $container no está corriendo"
        exit 1
    fi
done

# 5. Mostrar información de acceso
echo ""
echo -e "${BLUE}=== Paso 5: Información de acceso ===${NC}"
echo -e "${GREEN}[INFO]${NC} Accesos disponibles:"
echo "  localhost:8080 (Jenkins), 192.168.56.103 (Log4Shell)"

# 6. Verificación final
echo ""
echo -e "${BLUE}=== Paso 6: Verificación final ===${NC}"
echo -e "${GREEN}[OK]${NC} lab5 iniciado correctamente"
echo -e "${GREEN}[OK]${NC} Los contenedores están corriendo y son accesibles"
echo ""
echo "=== Setup completado ==="
