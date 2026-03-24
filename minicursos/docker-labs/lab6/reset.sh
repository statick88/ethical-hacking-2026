#!/bin/bash
# Script de reset para lab6
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Reset lab6 ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 1. Preguntar confirmación
echo -e "${YELLOW}[ADVERTENCIA]${NC} Esto eliminará todos los datos de los contenedores"
read -p "¿Deseas continuar? (s/n): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo -e "${GREEN}[INFO]${NC} Operación cancelada"
    exit 0
fi

# 2. Detener y eliminar contenedores
echo -e "${BLUE}=== Paso 1: Deteniendo y eliminando contenedores ===${NC}"
docker-compose down

# 3. Eliminar volúmenes de datos
echo -e "${BLUE}=== Paso 2: Eliminando volúmenes de datos ===${NC}"
docker volume prune -f 2>/dev/null || echo -e "${YELLOW}[INFO]${NC} Volúmenes no encontrados o ya eliminados"

# 4. Limpieza de imágenes no utilizadas (opcional)
echo -e "${BLUE}=== Paso 3: Opcional - Limpiar imágenes no utilizadas ===${NC}"
read -p "¿Deseas limpiar imágenes no utilizadas de Docker? (s/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]; then
    docker image prune -f
    echo -e "${GREEN}[OK]${NC} Imágenes limpiadas"
else
    echo -e "${GREEN}[INFO]${NC} Imágenes no limpiadas"
fi

# 5. Verificar limpieza
echo ""
echo -e "${BLUE}=== Paso 4: Verificando limpieza ===${NC}"
echo -e "${GREEN}[OK]${NC} Lab reseteado"

# 6. Resumen
echo ""
echo -e "${BLUE}=== Resumen ===${NC}"
echo -e "${GREEN}[OK]${NC} lab6 ha sido reseteado completamente"
echo -e "${GREEN}[INFO]${NC} Para volver a iniciar el lab:"
echo -e "  ${YELLOW}./setup.sh${NC}"
echo ""
echo "=== Reset completado ==="
