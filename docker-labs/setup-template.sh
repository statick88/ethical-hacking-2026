#!/bin/bash
# Script de setup genérico para Docker Labs
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

# Configuración del lab (editar según sea necesario)
LAB_NAME="labX"
LAB_NETWORK="labX-net"
CONTAINERS=("container1" "container2")  # Editar con nombres reales

echo "=== Setup $LAB_NAME ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para verificar dependencias
check_dependency() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}[OK]${NC} $1 instalado: $($1 --version 2>/dev/null | head -n1)"
        return 0
    else
        echo -e "${RED}[ERROR]${NC} $1 no encontrado"
        return 1
    fi
}

# 1. Verificar dependencias
echo -e "${BLUE}=== Paso 1: Verificando dependencias ===${NC}"
check_dependency "docker"
check_dependency "docker-compose"

# 2. Verificar recursos del sistema
echo ""
echo -e "${BLUE}=== Paso 2: Verificando recursos del sistema ===${NC}"
TOTAL_MEM=$(free -h | awk '/^Mem:/ {print $2}')
AVAILABLE_MEM=$(free -h | awk '/^Mem:/ {print $7}')
echo -e "${GREEN}[INFO]${NC} Memoria total: $TOTAL_MEM"
echo -e "${GREEN}[INFO]${NC} Memoria disponible: $AVAILABLE_MEM"

DISK_SPACE=$(df -h / | awk 'NR==2 {print $4}')
echo -e "${GREEN}[INFO]${NC} Espacio disponible en disco: $DISK_SPACE"

# 3. Verificar contenedores existentes
echo ""
echo -e "${BLUE}=== Paso 3: Verificando contenedores existentes ===${NC}"

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

# 4. Iniciar los servicios
echo ""
echo -e "${BLUE}=== Paso 4: Iniciando servicios Docker ===${NC}"
docker-compose up -d

# 5. Verificar estado de los contenedores
echo ""
echo -e "${BLUE}=== Paso 5: Verificando estado de contenedores ===${NC}"
sleep 5

for container in "${CONTAINERS[@]}"; do
    if docker ps --format "{{.Names}}" | grep -q "$container"; then
        echo -e "${GREEN}[OK]${NC} Contenedor $container está corriendo"
    else
        echo -e "${RED}[ERROR]${NC} Contenedor $container no está corriendo"
        exit 1
    fi
done

# 6. Verificar conectividad entre contenedores
echo ""
echo -e "${BLUE}=== Paso 6: Verificando conectividad ===${NC}"
echo "Esperando 10 segundos para que los servicios se inicialicen..."
sleep 10

# 7. Mostrar información de acceso
echo ""
echo -e "${BLUE}=== Paso 7: Información de acceso ===${NC}"
echo -e "${GREEN}[INFO]${NC} Para acceder a los contenedores:"
for container in "${CONTAINERS[@]}"; do
    echo -e "  ${YELLOW}docker exec -it $container bash${NC}"
done

# 8. Verificación final
echo ""
echo -e "${BLUE}=== Paso 8: Verificación final ===${NC}"
echo -e "${GREEN}[OK]${NC} $LAB_NAME iniciado correctamente"
echo -e "${GREEN}[OK]${NC} Los contenedores están corriendo y son accesibles"
echo ""
echo "=== Setup completado ==="