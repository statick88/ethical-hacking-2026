# Lab 1: Reconocimiento y Enumeración

## Objetivos del Laboratorio

En este laboratorio, seremos capaces de:
- Realizar reconocimiento pasivo con herramientas OSINT
- Escanear una red y enumerar puertos con Nmap
- Enumerar servicios vulnerables con scripts de Nmap
- Analizar una máquina vulnerable (Metasploitable 2)
- Documentar hallazgos de seguridad

---

## 1. Requisitos Previos

### 1.1. Software Necesario

- **Docker Engine**: 24.0 o superior
- **Docker Compose**: 2.0 o superior
- **Conexión a internet**: Para descargar imágenes Docker

### 1.2. Recursos del Sistema

- **RAM**: 8GB mínimo (16GB recomendado)
- **Almacenamiento**: 10GB disponibles
- **CPU**: Mínimo 2 núcleos

---

## 2. Arquitectura del Laboratorio

```
lab1-net (172.18.1.0/24)
├── kali (172.18.1.10) — Atacante con herramientas de reconocimiento
└── metasploitable2 (172.18.1.20) — Objetivo vulnerable
```

**Descripción**:
- **Kali**: Máquina atacante con herramientas de pentesting
- **Metasploitable2**: Máquina vulnerable con múltiples servicios expuestos

---

## 3. Configuración del Entorno

### 3.1. Opción Recomendada: Scripts de Automatización

Hemos creado scripts para facilitar el uso del laboratorio:

```bash
# Navegar al directorio del lab
cd /ruta/a/tu/directorio/Ethical_Hacking/docker-labs/lab1

# Iniciar el laboratorio
./setup.sh

# Verificar estado
./check-lab.sh

# Resetear el laboratorio (eliminar todo)
./reset.sh
```

**¿Qué hace cada script?**
- `setup.sh`: Verifica dependencias, inicia contenedores, verifica conectividad
- `check-lab.sh`: Verifica estado de contenedores y recursos
- `reset.sh`: Detiene y elimina contenedores, limpia volúmenes

### 3.2. Opción Manual: Docker Compose

Si prefieres control manual, sigue estos pasos:

#### Paso 1: Clonar el Repositorio

```bash
cd /ruta/a/tu/directorio
git clone <repo-url>
cd Ethical_Hacking/docker-labs/lab1
```

#### Paso 2: Levantar el Entorno

```bash
# Levantar servicios en modo detached (fondo)
docker compose up -d

# Verificar que los servicios están corriendo
docker compose ps
```

**Resultado esperado**: Deberías ver dos contenedores corriendo.

#### Paso 3: Acceder a la Máquina Kali

```bash
# Ingresar a la consola de Kali
docker compose exec kali bash

# Actualizar paquetes e instalar herramientas
apt update && apt install -y nmap whois dig theharvester subfinder gobuster enum4linux
```

---

## 4. Ejercicios del Laboratorio

### 4.1. Reconocimiento Pasivo

**Objetivo**: Recolectar información sobre el objetivo sin interactuar directamente con él.

#### Ejercicio 1: Información de Dominio con WHOIS

Haremos uso de la herramienta `whois` para obtener información de registro.

**Comando**:
```bash
whois empresa-ejemplo.com
```

**Resultado esperado**: Información de registro (contacto, fechas, nameservers).

#### Ejercicio 2: Enumeración DNS con dig

Haremos consultas DNS para descubrir servicios.

**Comandos**:
```bash
# Consultar nameservers
dig NS empresa-ejemplo.com

# Consultar mailservers
dig MX empresa-ejemplo.com
```

**Resultado esperado**: Lista de servidores de nombres y correos.

### 4.2. Escaneo de Red con Nmap

**Objetivo**: Identificar puertos abiertos y servicios en la red.

#### Ejercicio 3: Escaneo TCP SYN Rápido

**Comando**:
```bash
nmap -sS -F 192.168.56.0/24
```

**Resultado esperado**: Lista de hosts con puertos abiertos.

#### Ejercicio 4: Escaneo Completo

**Comando**:
```bash
nmap -sS -sV -sC -p- 192.168.56.5 -oN scan_full.txt
```

**Resultado esperado**: Archivo con todos los puertos y servicios detectados.

### 4.3. Enumeración de Servicios

**Objetivo**: Identificar servicios vulnerables en el objetivo.

#### Ejercicio 5: Enumeración SMB

**Comando**:
```bash
enum4linux 192.168.56.5
```

**Resultado esperado**: Información de recursos compartidos SMB.

---

## 5. Verificación del Laboratorio

Hemos completado el laboratorio cuando:

- [ ] WHOIS devolvió información del dominio
- [ ] DNS enumeró nameservers y mailservers
- [ ] Encontraste al menos 1 subdominio
- [ ] Escaneo completo guardado en `scan_full.txt`
- [ ] Identificaste al menos 1 vulnerabilidad
- [ ] Documentaste hallazgos en el reporte

---

## 6. Troubleshooting

### Problema 1: "No hay conectividad entre contenedores"

**Solución**:
```bash
# Verifica que la red esté creada
docker network ls
docker network inspect lab1-net
```

### Problema 2: "No se puede acceder a Kali"

**Solución**:
```bash
# Reinicia el servicio
docker compose restart kali
docker compose exec kali bash
```

### Problema 3: "Nmap no está instalado"

**Solución**:
```bash
# Instala nmap desde Kali
apt update && apt install -y nmap
```

---

## 7. Entregable

**Archivo**: `reconnaissance_report.md`

**Contenido**:
- Información de dominio (WHOIS, DNS)
- Subdominios encontrados
- Puertos abiertos con servicios
- Tecnologías identificadas
- Hallazgos de seguridad iniciales
- Recomendaciones para siguiente fase

---

## 8. Recursos

- [Nmap Documentation](https://nmap.org/book/man.html)
- [OSINT Framework](https://osintframework.com/)
- [Metasploitable 2 Vulnerabilities](https://docs.rapid7.com/metasploit/metasploitable-2/)

---

**Alumno**: Diego Medardo Saavedra García  
**Universidad**: Universidad Complutense de Madrid  
**Máster**: Ciberseguridad: Seguridad Defensiva y Ofensiva  
**Curso**: 2026/2027