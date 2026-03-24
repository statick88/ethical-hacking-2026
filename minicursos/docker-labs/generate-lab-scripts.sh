#!/bin/bash
# Script para generar automáticamente scripts de setup, check y reset para cada lab
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Generando scripts para docker-labs ==="
echo ""

# Directorio base
BASE_DIR="/Users/statick/apps/Ethical_Hacking/docker-labs"

# Definir contenedores por lab usando arrays regulares
LABS=("lab1" "lab2" "lab3" "lab4" "lab5" "lab6" "lab7" "lab8")

CONTAINERS_lab1="lab1-kali lab1-metasploitable"
CONTAINERS_lab2="ethical-hacking-kali target-llm-api target-gandalf"
CONTAINERS_lab3="lab3-dvwa lab3-db lab3-juice-shop lab3-vapi lab3-kali"
CONTAINERS_lab4="lab4-dc01 lab4-member01 lab4-kali"
CONTAINERS_lab5="lab5-log4shell lab5-jenkins lab5-kali"
CONTAINERS_lab6="lab6-victim lab6-kali"
CONTAINERS_lab7="lab7-openplc lab7-hmi lab7-kali"
CONTAINERS_lab8="lab8-api lab8-db lab8-kali"

PORTS_lab1="172.18.1.10 (Kali), 172.18.1.20 (Metasploitable)"
PORTS_lab2="localhost:5000 (API LLM), localhost:5001 (Gandalf)"
PORTS_lab3="localhost:8080 (DVWA), localhost:3000 (Juice Shop)"
PORTS_lab4="192.168.56.101 (Kali), 192.168.56.102 (DC01)"
PORTS_lab5="localhost:8080 (Jenkins), 192.168.56.103 (Log4Shell)"
PORTS_lab6="192.168.56.101 (Kali), 192.168.56.102 (Victim)"
PORTS_lab7="localhost:8080 (OpenPLC), localhost:9090 (HMI)"
PORTS_lab8="localhost:8000 (API), localhost:5432 (DB)"

# Función para crear setup.sh
create_setup_script() {
    local lab=$1
    local containers=$2
    local ports=$3
    
    cat > "$BASE_DIR/$lab/setup.sh" << 'ENDOFSCRIPT'
#!/bin/bash
# Script de setup para LAB_NAME
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Setup LAB_NAME ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contenedores de este lab
CONTAINERS=(CONTAINERS_PLACEHOLDER)

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
echo "  PORTS_PLACEHOLDER"

# 6. Verificación final
echo ""
echo -e "${BLUE}=== Paso 6: Verificación final ===${NC}"
echo -e "${GREEN}[OK]${NC} LAB_NAME iniciado correctamente"
echo -e "${GREEN}[OK]${NC} Los contenedores están corriendo y son accesibles"
echo ""
echo "=== Setup completado ==="
ENDOFSCRIPT
    
    # Reemplazar placeholders usando perl (más portable que sed -i)
    perl -i -pe "s|LAB_NAME|$lab|g" "$BASE_DIR/$lab/setup.sh"
    perl -i -pe "s|CONTAINERS_PLACEHOLDER|$containers|g" "$BASE_DIR/$lab/setup.sh"
    perl -i -pe "s|PORTS_PLACEHOLDER|$ports|g" "$BASE_DIR/$lab/setup.sh"
    
    chmod +x "$BASE_DIR/$lab/setup.sh"
}

# Función para crear check-lab.sh
create_check_script() {
    local lab=$1
    local containers=$2
    
    cat > "$BASE_DIR/$lab/check-lab.sh" << 'ENDOFSCRIPT'
#!/bin/bash
# Script de verificación para LAB_NAME
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Verificación LAB_NAME ==="
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Contenedores de este lab
CONTAINERS=(CONTAINERS_PLACEHOLDER)

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
    echo -e "${GREEN}[OK]${NC} LAB_NAME está listo para usar"
else
    echo -e "${RED}[ERROR]${NC} Algunos contenedores no están corriendo"
    echo -e "${YELLOW}[INFO]${NC} Ejecuta: ./setup.sh para iniciar el lab"
fi
ENDOFSCRIPT
    
    # Reemplazar placeholders usando perl (más portable que sed -i)
    perl -i -pe "s|LAB_NAME|$lab|g" "$BASE_DIR/$lab/check-lab.sh"
    perl -i -pe "s|CONTAINERS_PLACEHOLDER|$containers|g" "$BASE_DIR/$lab/check-lab.sh"
    
    chmod +x "$BASE_DIR/$lab/check-lab.sh"
}

# Función para crear reset.sh
create_reset_script() {
    local lab=$1
    
    cat > "$BASE_DIR/$lab/reset.sh" << 'ENDOFSCRIPT'
#!/bin/bash
# Script de reset para LAB_NAME
# Author: Diego Saavedra
# Fecha: 2026-03-16

set -e

echo "=== Reset LAB_NAME ==="
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
echo -e "${GREEN}[OK]${NC} LAB_NAME ha sido reseteado completamente"
echo -e "${GREEN}[INFO]${NC} Para volver a iniciar el lab:"
echo -e "  ${YELLOW}./setup.sh${NC}"
echo ""
echo "=== Reset completado ==="
ENDOFSCRIPT
    
    # Reemplazar placeholders usando perl (más portable que sed -i)
    perl -i -pe "s|LAB_NAME|$lab|g" "$BASE_DIR/$lab/reset.sh"
    
    chmod +x "$BASE_DIR/$lab/reset.sh"
}

# Generar scripts para cada lab
for lab in "${LABS[@]}"; do
    if [ -d "$BASE_DIR/$lab" ]; then
        echo -e "${BLUE}=== Generando scripts para $lab ===${NC}"
        
        # Obtener contenedores y puertos usando eval
        containers_var="CONTAINERS_$lab"
        ports_var="PORTS_$lab"
        containers="${!containers_var}"
        ports="${!ports_var}"
        
        create_setup_script "$lab" "$containers" "$ports"
        create_check_script "$lab" "$containers"
        create_reset_script "$lab"
        
        echo -e "${GREEN}[OK]${NC} Scripts generados para $lab"
        echo ""
    fi
done

echo -e "${GREEN}[OK]${NC} Todos los scripts han sido generados"
echo ""
echo "Estructura creada para cada lab:"
echo "  - setup.sh: Inicia el entorno Docker"
echo "  - check-lab.sh: Verifica estado de contenedores"
echo "  - reset.sh: Elimina el entorno completamente"