# Laboratorios Dockerizados — Specification

## Purpose

Especificaciones para los laboratorios dockerizados del curso de Ethical Hacking 2026. Define los requisitos técnicos y de contenido para cada lab containerizado.

---

## Requirements

### Requirement: Estructura de Directorios

El directorio `docker-labs/` DEBE tener una estructura organizada con subcarpetas por cada laboratorio.

#### Scenario: Estructura principal

- GIVEN El directorio `docker-labs/`
- WHEN Se lista su contenido
- THEN DEBE existir las siguientes subcarpetas:
  - `lab1/` — Reconnaissance and Enumeration
  - `lab3/` — Web Security (OWASP WebGoat)
  - `lab4/` — Active Directory (BloodHound)
  - `lab5/` — Automated Pentesting
  - `lab6/` — Undetectable Payloads
  - `lab7/` — OT Security (OpenPLC)
  - `lab8/` — Final Project

---

### Requirement: Archivos por Laboratorio

Cada laboratorio dockerizado DEBE contener al menos los siguientes archivos:

#### Scenario: Archivos mínimos por lab

- GIVEN Un directorio `docker-labs/labN/`
- WHEN Se verifica su contenido
- THEN DEBE existir `docker-compose.yml`
- AND DEBE existir `README.md`

#### Scenario: Docker Compose válido

- GIVEN Un archivo `docker-compose.yml` en `labN/`
- WHEN Se ejecuta `docker compose config`
- THEN DEBE validar sin errores
- AND DEBE definir al menos un servicio

---

### Requirement: Docker Compose Services

Cada laboratorio DEBE definir servicios Docker específicos para su escenario.

#### Scenario: Lab 1 — Reconnaissance and Enumeration

- GIVEN `docker-labs/lab1/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con herramientas de reconocimiento
  - Servicio `metasploitable2` — Máquina vulnerable para enumeración
- AND DEBE definir una red bridge personalizada

#### Scenario: Lab 3 — Web Security (OWASP WebGoat)

- GIVEN `docker-labs/lab3/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `webgoat` — OWASP WebGoat con vulnerabilidades web
- AND DEBE exponer el puerto 8080
- AND DEBE tener volúmenes para persistencia

#### Scenario: Lab 4 — Active Directory (BloodHound)

- GIVEN `docker-labs/lab4/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con BloodHound y impacket
  - Servicio `dc01` — Controlador de Dominio Windows Server
  - Servicio `bloodhound` — BloodHound Community Edition
- AND DEBE definir una red bridge personalizada

#### Scenario: Lab 5 — Automated Pentesting

- GIVEN `docker-labs/lab5/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con AutoRecon y Metasploit
  - Servicio `target` — Máquina vulnerable (Metasploitable 3)

#### Scenario: Lab 6 — Undetectable Payloads

- GIVEN `docker-labs/lab6/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con msfvenom, Veil-Evasion
- AND DEBE tener acceso a internet para VirusTotal API

#### Scenario: Lab 7 — OT Security (OpenPLC)

- GIVEN `docker-labs/lab7/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con herramientas de OT (s7scan, modbus)
  - Servicio `openplc` — OpenPLC v3 para PLC simulation
- AND DEBE exponer puertos OT estándar (102, 502)

#### Scenario: Lab 8 — Final Project

- GIVEN `docker-labs/lab8/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux full
  - Servicio `web` — Aplicación web vulnerable
  - Servicio `db` — Base de datos MySQL vulnerable
  - Servicio `api` — API REST vulnerable
- AND DEBE definir una red bridge personalizada

---

### Requirement: README.md Estructurado

Cada README.md DEBE seguir una estructura estandarizada para que el estudiante pueda ejecutar el lab de forma autónoma.

#### Scenario: Estructura mínima del README

- GIVEN Un archivo `README.md` en `labN/`
- WHEN Se verifica su contenido
- THEN DEBE contener las siguientes secciones:
  1. `# Lab N: {Título}` — Encabezado con número y título
  2. `## Objetivos` — Qué debe aprender el estudiante
  3. `## Prerrequisitos` — Docker, recursos hardware
  4. `## Arquitectura` — Diagramas del entorno
  5. `## Setup` — Instrucciones para levantar el entorno
  6. `## Laboratorio` — Pasos del lab con comandos
  7. `## Troubleshooting` — Problemas comunes y soluciones
  8. `## Cleanup` — Eliminar contenedores y volúmenes

---

### Requirement: Comandos Ejecutables

Los comandos en el README.md DEBEN ser ejecutables directamente desde el terminal.

#### Scenario: Docker Compose commands

- GIVEN La sección `## Setup` del README
- WHEN Se verifica los comandos
- THEN DEBE incluir:
  - `docker compose up -d` — Levantar el entorno
  - `docker compose ps` — Verificar servicios
- AND DEBE explicitar cómo entrar en cada contenedor

#### Scenario: Access to containers

- GIVEN La sección `## Laboratorio` del README
- WHEN Se explica cómo acceder a un contenedor
- THEN DEBE usar el comando `docker exec -it <container> bash`
- OR DEBE usar `docker compose exec <service> bash`

---

### Requirement: Recursos Hardware

Los laboratorios DEBEN tener requisitos de hardware realistas.

#### Scenario: Requisitos mínimos

- GIVEN Cualquier README.md
- WHEN Se verifica la sección `## Prerrequisitos`
- THEN DEBE especificar:
  - Docker Engine 24.0+
  - Docker Compose 2.0+
  - 8GB RAM mínimo (16GB recomendado)
  - 20GB almacenamiento disponible

---

### Requirement: Cleanup

Cada laboratorio DEBE explicar cómo limpiar el entorno.

#### Scenario: Eliminar contenedores

- GIVEN La sección `## Cleanup` del README
- WHEN Se verifica los comandos
- THEN DEBE incluir:
  - `docker compose down` — Parar servicios
  - `docker compose down -v` — Eliminar volúmenes
- AND DEBE explicar cómo eliminar imágenes si es necesario

---

### Requirement: Compatibilidad

Los laboratorios DEBEN funcionar en diferentes sistemas operativos.

#### Scenario: Compatibilidad cross-platform

- GIVEN Cualquier README.md
- WHEN Se verifica la sección `## Prerrequisitos`
- THEN DEBE indicar compatibilidad con:
  - Windows 10/11 con WSL2
  - macOS con Docker Desktop
  - Linux con Docker Engine
