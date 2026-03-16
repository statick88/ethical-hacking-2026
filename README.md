# Guía de Instalación y Configuración - Ethical Hacking 2026

> **Nota importante**: Hemos actualizado este curso para cumplir con los estándares ABACOM, incluyendo:
> - ✅ Sistema Anti-IA en quizzes y evaluaciones
> - ✅ Comandos parciales en labs (no copy-paste)
> - ✅ Scripts de automatización para docker-labs
> - ✅ Estructura estandarizada de laboratorios

---

## Objetivos de la Guía

Al finalizar esta guía, serás capaz de:
- Configurar tu entorno de trabajo para el curso
- Instalar todas las herramientas necesarias
- Ejecutar los laboratorios Docker de forma automatizada
- Resolver problemas comunes de instalación

---

## 1. Requisitos Previos

### 1.1. Sistema Operativo

Necesitas un sistema operativo compatible:
- **Windows**: 10/11 (64-bit)
- **macOS**: 10.15+
- **Linux**: Ubuntu/Debian (recomendado)

Recursos mínimos:
- **RAM**: 8GB mínimo (16GB recomendado)
- **Disco**: 20GB de espacio libre

### 1.2. Software Necesario

#### 1.2.1. Quarto CLI

**¿Por qué?**: Haremos todo el material del curso con Quarto.

```bash
# macOS/Linux
wget -qO- https://github.com/quarto-dev/quarto-cli/releases/download/v1.9.26/quarto-1.9.26-linux-amd64.deb > quarto.deb
sudo dpkg -i quarto.deb
rm quarto.deb

# Verificar instalación
quarto --version
```

**Resultado esperado**: Deberías ver la versión de Quarto (ej: 1.9.26).

#### 1.2.2. Node.js y npm

**¿Por qué?**: Algunas herramientas del curso requieren Node.js.

```bash
# macOS/Linux
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verificar instalación
node --version
npm --version
```

**Resultado esperado**: Versiones de Node.js (18.x) y npm.

#### 1.2.3. Docker

**¿Por qué?**: Los laboratorios prácticos se ejecutan en contenedores Docker.

```bash
# macOS/Linux
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Verificar instalación
docker --version
docker-compose --version
```

**Resultado esperado**: Versiones de Docker y Docker Compose.

#### 1.2.4. Git

**¿Por qué?**: Para clonar y actualizar el repositorio del curso.

```bash
# macOS/Linux
sudo apt-get install git

# Verificar instalación
git --version
```

**Resultado esperado**: Versión de Git.

---

## 2. Instalación del Curso

### 2.1. Clonar el Repositorio

```bash
git clone https://github.com/tu-usuario/ethical-hacking-2026.git
cd ethical-hacking-2026
```

### 2.2. Descarga Directa (Alternativa)

1. Descargar el ZIP del repositorio
2. Extraer en una carpeta
3. Abrir terminal en esa carpeta

---

## 3. Configuración Inicial

### 3.1. Instalar Dependencias

```bash
npm install
```

### 3.2. Verificar Instalación

Ejecuta estos comandos para verificar que todo está correctamente configurado:

```bash
make check-quarto
make check-docker
make check-node
make check-npm
```

**Resultado esperado**: Deberías ver mensajes `[OK]` para cada herramienta.

---

## 4. Uso del Curso

### 4.1. Construir el Proyecto

Genera el libro completo del curso:

```bash
make build
```

### 4.2. Iniciar Servidor de Desarrollo

Vista previa con hot-reload:

```bash
make dev
```

### 4.3. Verificar Integridad

Comprueba que todos los archivos necesarios existen:

```bash
make test
```

---

## 5. Laboratorios Docker

### 5.1. Iniciar Laboratorios

#### Opción 1: Todos los laboratorios

```bash
make start-labs
```

#### Opción 2: Laboratorio específico

```bash
make start-lab N=1  # Inicia lab 1
make start-lab N=2  # Inicia lab 2
# ... hasta N=8
```

### 5.2. Verificar Estado

#### Opción 1: Todos los laboratorios

```bash
make status-labs
```

#### Opción 2: Laboratorio específico

```bash
make check-lab N=1  # Verifica lab 1
```

### 5.3. Resetear Laboratorio

Si necesitas limpiar un laboratorio:

```bash
make reset-lab N=1  # Resetea lab 1
```

### 5.4. Detener Laboratorios

```bash
make stop-labs
```

### 5.5. Uso Directo con Scripts

Cada laboratorio tiene scripts de automatización:

```bash
cd docker-labs/lab1
./setup.sh      # Iniciar el laboratorio
./check-lab.sh  # Verificar estado
./reset.sh      # Resetear el laboratorio
```

---

## 6. Despliegue

### 6.1. Despliegue Básico

```bash
make deploy
```

### 6.2. Despliegue con GitHub Actions

El proyecto incluye un pipeline CI/CD automático que se ejecuta en cada push al repositorio.

---

## 7. Troubleshooting

### 7.1. Problemas Comunes

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

### 7.2. Verificación Final

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

---

## 8. Contribuir

Si encuentras errores o quieres mejorar el curso:

1. Fork del repositorio
2. Crear branch para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit de cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push al branch (`git push origin feature/nueva-funcionalidad`)
5. Crear Pull Request

---

## 9. Soporte

### Problemas Técnicos

- Revisar la documentación
- Verificar logs de errores
- Consultar la comunidad

### Reportar Bugs

- Describir el problema claramente
- Incluir mensajes de error
- Indicar pasos para reproducir

---

## 10. Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE para detalles.

---

**Alumno**: Diego Medardo Saavedra García  
**Universidad**: Universidad Complutense de Madrid  
**Máster**: Ciberseguridad: Seguridad Defensiva y Ofensiva  
**Curso**: 2026/2027