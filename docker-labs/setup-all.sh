#!/bin/bash
# Script de setup para TODOS los Docker Labs
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Setup de TODOS los Docker Labs ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directorio base
BASE_DIR=$(pwd)

# Función para setup de un lab específico
setup_lab() {
    local lab_num=$1
    local lab_dir="lab$lab_num"
    
    echo -e "${BLUE}=== Configurando $lab_dir ===${NC}"
    
    if [ ! -d "$lab_dir" ]; then
        echo -e "${YELLOW}[AVISO]${NC} Directorio $lab_dir no encontrado, saltando..."
        return
    fi
    
    cd "$lab_dir" || return
    
    # Verificar docker-compose.yml
    if [ ! -f "docker-compose.yml" ]; then
        echo -e "${RED}[ERROR]${NC} No se encuentra docker-compose.yml en $lab_dir"
        cd ..
        return
    fi
    
    # Extraer nombres de contenedores del docker-compose.yml
    CONTAINERS=$(grep "container_name:" docker-compose.yml | awk '{print $2}' | tr -d '"')
    
    # Verificar si contenedores ya existen
    for container in $CONTAINERS; do
        if docker ps -a --format "{{.Names}}" | grep -q "$container"; then
            echo -e "${YELLOW}[AVISO]${NC} Contenedor $container ya existe"
            read -p "¿Eliminar y recrear? (s/n): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Ss]$ ]]; then
                echo "Deteniendo y eliminando contenedores..."
                docker-compose down
                break
            else
                echo -e "${GREEN}[INFO]${NC} Manteniendo contenedores existentes"
                cd ..
                return
            fi
        fi
    done
    
    # Iniciar servicios
    echo -e "${GREEN}[INFO]${NC} Iniciando servicios..."
    docker-compose up -d
    
    # Verificar estado
    sleep 3
    for container in $CONTAINERS; do
        if docker ps --format "{{.Names}}" | grep -q "$container"; then
            echo -e "${GREEN}[OK]${NC} Contenedor $container está corriendo"
        else
            echo -e "${RED}[ERROR]${NC} Contenedor $container no está corriendo"
        fi
    done
    
    cd ..
    echo ""
}

# 1. Verificar dependencias
echo -e "${BLUE}=== Verificando dependencias ===${NC}"
if command -v docker &> /dev/null; then
    echo -e "${GREEN}[OK]${NC} Docker instalado: $(docker --version)"
else
    echo -e "${RED}[ERROR]${NC} Docker no encontrado"
    exit 1
fi

if command -v docker-compose &> /dev/null || docker compose version &> /dev/null; then
    echo -e "${GREEN}[OK]${NC} Docker Compose disponible"
else
    echo -e "${RED}[ERROR]${NC} Docker Compose no encontrado"
    exit 1
fi

# 2. Preguntar qué labs configurar
echo ""
echo -e "${BLUE}=== Seleccionar Labs ===${NC}"
echo "1) Todos los labs (1-8)"
echo "2) Labs específicos"
echo "3) Salir"
read -p "Opción: " option

case $option in
    1)
        echo "Configurando todos los labs..."
        for i in {1..8}; do
            setup_lab $i
        done
        ;;
    2)
        echo "Ingrese los números de labs separados por espacios (ej: 1 3 5):"
        read -a labs
        for i in "${labs[@]}"; do
            setup_lab $i
        done
        ;;
    3)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "Opción inválida"
        exit 1
        ;;
esac

echo -e "${GREEN}[OK]${NC} Setup de labs completado"
echo ""
echo "Para verificar el estado de un lab:"
echo "  cd docker-labs/labX && ./check-lab.sh"
echo ""
echo "Para resetear un lab:"
echo "  cd docker-labs/labX && ./reset.sh"