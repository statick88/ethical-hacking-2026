# Instalación y Configuración de Ethical Hacking 2026

## Requisitos Previos

### Sistema Operativo
- Windows 10/11, macOS 10.15+, o Linux (Ubuntu/Debian recomendado)
- 8GB RAM mínimo (16GB recomendado)
- 20GB de espacio libre en disco

### Software Necesario

#### 1. Quarto CLI
```bash
# macOS/Linux
wget -qO- https://github.com/quarto-dev/quarto-cli/releases/download/v1.9.26/quarto-1.9.26-linux-amd64.deb > quarto.deb
sudo dpkg -i quarto.deb
rm quarto.deb

# Windows
# Descargar desde https://github.com/quarto-dev/quarto-cli/releases
```

#### 2. Node.js y npm
```bash
# macOS/Linux
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Windows
# Descargar desde https://nodejs.org/
```

#### 3. Docker
```bash
# macOS/Linux
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Windows
# Descargar Docker Desktop desde https://www.docker.com/products/docker-desktop
```

#### 4. Git
```bash
# macOS/Linux
sudo apt-get install git

# Windows
# Descargar desde https://git-scm.com/
```

## Instalación

### Opción 1: Clonar el Repositorio
```bash
git clone https://github.com/tu-usuario/ethical-hacking-2026.git
cd ethical-hacking-2026
```

### Opción 2: Descarga Directa
1. Descargar el ZIP del repositorio
2. Extraer en una carpeta
3. Abrir terminal en esa carpeta

## Configuración

### Instalar Dependencias
```bash
npm install
```

### Verificar Instalación
```bash
make check-quarto
make check-docker
make check-node
make check-npm
```

## Uso

### Construir el Proyecto
```bash
make build
```

### Iniciar Servidor de Desarrollo
```bash
make dev
```

### Verificar Integridad
```bash
make test
```

### Verificar Laboratorios Docker
```bash
make check-labs
```

## Laboratorios Docker

### Iniciar Laboratorios
```bash
make start-labs
```

### Detener Laboratorios
```bash
make stop-labs
```

### Verificar Estado
```bash
make status-labs
```

## Despliegue

### Despliegue Básico
```bash
make deploy
```

### Despliegue con GitHub Actions
El proyecto incluye un pipeline CI/CD automático que se ejecuta en cada push al repositorio.

## Troubleshooting

### Problemas Comunes

#### Quarto no encontrado
```bash
# Reinstalar Quarto
wget -qO- https://github.com/quarto-dev/quarto-cli/releases/download/v1.9.26/quarto-1.9.26-linux-amd64.deb > quarto.deb
sudo dpkg -i quarto.deb
```

#### Docker no funciona
```bash
# Verificar servicio de Docker
sudo systemctl status docker

# Iniciar servicio si está detenido
sudo systemctl start docker

# Agregar usuario al grupo docker
sudo usermod -aG docker $USER
```

#### npm no funciona
```bash
# Reinstalar npm
sudo apt-get install npm

# Actualizar npm
npm install -g npm
```

### Verificación Final
```bash
# Verificar todo
make check

# Si todo está correcto, deberías ver:
# - Quarto instalado
# - Docker instalado
# - Node.js instalado
# - npm instalado
# - Laboratorios Docker configurados
```

## Contribuir

1. Fork del repositorio
2. Crear branch para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit de cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Crear Pull Request

## Soporte

Para problemas técnicos:
- Revisar la documentación
- Verificar logs de errores
- Consultar la comunidad

Para reportar bugs:
- Describir el problema claramente
- Incluir mensajes de error
- Indicar pasos para reproducir

## Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para detalles.
