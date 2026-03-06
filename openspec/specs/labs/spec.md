# Laboratorios por Unidad — Specification

## Purpose

Especificaciones para los 8 laboratorios específicos del curso. Actualmente solo existe `labs/infraestructura.md` (guía general de setup). Esta spec define qué DEBE contener cada lab para ser ejecutable por un estudiante.

---

## Requirements

### Requirement: Un Laboratorio Específico por Unidad

El curso DEBE tener exactamente 8 archivos de laboratorio, uno por unidad, en formato Markdown estructurado.

#### Scenario: Existencia de archivos de lab

- GIVEN El directorio `labs/`
- WHEN Se lista su contenido
- THEN DEBE existir `labs/lab-unidad1.md` hasta `labs/lab-unidad8.md`
- AND DEBE existir `labs/infraestructura.md` (ya existe, no eliminar)

---

### Requirement: Estructura Estándar de Laboratorio

Cada archivo de laboratorio DEBE seguir una estructura estandarizada que permita al estudiante ejecutarlo de forma autónoma.

#### Scenario: Estructura mínima de lab

- GIVEN Un archivo `labs/lab-unidadN.md`
- WHEN Se verifica su estructura
- THEN DEBE contener las siguientes secciones:
  1. `# Lab N: {Título del Lab}` — encabezado con número y título
  2. `## Objetivo` — qué debe lograr el estudiante al completarlo
  3. `## Prerrequisitos` — software, accesos y conocimientos necesarios
  4. `## Entorno` — descripción del entorno (Docker, VM, plataforma online)
  5. `## Escenario` — contexto narrativo (ej: "Sos un pentester contratado por...")
  6. `## Pasos` — instrucciones numeradas paso a paso con comandos exactos
  7. `## Resultado Esperado` — cómo sabe el estudiante que lo logró
  8. `## Entregable` — qué debe entregar para evaluación (screenshot, reporte, flag)
  9. `## Recursos` — links a writeups o referencias para desbloquear si se traba

---

### Requirement: Pasos Ejecutables y Verificables

Los pasos del laboratorio DEBEN ser suficientemente específicos para que el estudiante pueda seguirlos sin ambigüedad.

#### Scenario: Comandos con sintaxis exacta

- GIVEN La sección `## Pasos` de cualquier lab
- WHEN Se verifica un paso con comando
- THEN DEBE mostrar el comando en bloque de código con el lenguaje especificado (```bash)
- AND DEBE indicar en qué máquina se ejecuta (atacante / víctima / ambas)
- AND DEBE mostrar el output esperado o parte de él

#### Scenario: Pasos progresivos

- GIVEN Un laboratorio completo
- WHEN Se ejecutan los pasos en orden
- THEN Cada paso DEBE depender solo de los anteriores (sin saltos de contexto)
- AND El estudiante DEBE poder identificar si un paso falló por el output esperado

---

### Requirement: Entorno Basado en Herramientas Gratuitas

Todos los laboratorios DEBEN poder ejecutarse con herramientas gratuitas y open source.

#### Scenario: Sin dependencias de pago

- GIVEN Los prerrequisitos de cualquier lab
- WHEN Se verifica cada herramienta requerida
- THEN DEBE ser gratuita: Docker, Kali Linux, VirtualBox, TryHackMe (free), HackTheBox (free), OverTheWire
- AND NO DEBE requerir licencias de pago (Burp Suite Pro, Cobalt Strike comercial, etc.)

---

### Requirement: Especificaciones por Unidad

Cada laboratorio DEBE tener un escenario apropiado a la unidad correspondiente.

#### Scenario: Lab Unidad 1 — Reconocimiento

- GIVEN `labs/lab-unidad1.md`
- WHEN Se verifica el escenario
- THEN DEBE incluir: reconocimiento pasivo con OSINT, escaneo con Nmap, enumeración con Recon-ng
- AND El entorno DEBE ser una máquina TryHackMe o un contenedor Docker con objetivo simulado

#### Scenario: Lab Unidad 2 — IA y LLM

- GIVEN `labs/lab-unidad2.md`
- WHEN Se verifica el escenario
- THEN DEBE incluir: ejecución de Prompt Injection en un LLM vulnerable (ej: Gandalf AI, HackAPrompt)
- AND DEBE incluir al menos 1 técnica de jailbreaking documentada paso a paso

#### Scenario: Lab Unidad 3 — Web y APIs

- GIVEN `labs/lab-unidad3.md`
- WHEN Se verifica el escenario
- THEN DEBE usar OWASP WebGoat o PortSwigger Web Academy (gratuito)
- AND DEBE cubrir mínimo: SQLi, XSS y una vulnerabilidad de API REST

#### Scenario: Lab Unidad 4 — Active Directory

- GIVEN `labs/lab-unidad4.md`
- WHEN Se verifica el escenario
- THEN DEBE usar una máquina de TryHackMe o HackTheBox con AD (ej: Attacktive Directory)
- AND DEBE incluir: Kerberoasting + Pass-the-Hash como mínimo

#### Scenario: Lab Unidad 5 — Pentesting Autónomo

- GIVEN `labs/lab-unidad5.md`
- WHEN Se verifica el escenario
- THEN DEBE incluir uso de un framework de automatización (Metasploit + scripts, o AutoRecon)
- AND DEBE simular una campaña completa en entorno Metasploitable

#### Scenario: Lab Unidad 6 — Evasión

- GIVEN `labs/lab-unidad6.md`
- WHEN Se verifica el escenario
- THEN DEBE incluir: generación de payload con msfvenom + técnica de ofuscación
- AND DEBE verificar con VirusTotal (free) el nivel de detección

#### Scenario: Lab Unidad 7 — OT/ICS

- GIVEN `labs/lab-unidad7.md`
- WHEN Se verifica el escenario
- THEN DEBE usar un simulador de PLC (ej: OpenPLC en Docker) o Pentagi
- AND DEBE incluir escaneo con s7scan o módulos Modbus de Metasploit

#### Scenario: Lab Unidad 8 — Pentest Completo

- GIVEN `labs/lab-unidad8.md`
- WHEN Se verifica el escenario
- THEN DEBE ser un pentest completo end-to-end en Metasploitable o HackTheBox
- AND El entregable DEBE ser un reporte ejecutivo + técnico completo (el Proyecto Final)

---

### Requirement: Estructura de Laboratorios Dockerizados

El directorio `docker-labs/` DEBE tener una estructura organizada con subcarpetas por cada laboratorio containerizado.

#### Scenario: Estructura principal de docker-labs

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

### Requirement: Archivos Dockerizados por Laboratorio

Cada laboratorio dockerizado DEBE contener los siguientes archivos:

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

### Requirement: Servicios Docker Específicos por Lab

Cada laboratorio DEBE definir servicios Docker apropiados para su escenario.

#### Scenario: Lab 1 Dockerizado — Reconnaissance and Enumeration

- GIVEN `docker-labs/lab1/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con herramientas de reconocimiento
  - Servicio `metasploitable2` — Máquina vulnerable para enumeración
- AND DEBE definir una red bridge personalizada (172.18.1.0/24)

#### Scenario: Lab 3 Dockerizado — Web Security (OWASP WebGoat)

- GIVEN `docker-labs/lab3/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `webgoat` — OWASP WebGoat con vulnerabilidades web
  - Servicio `firefox` — Navegador para acceder a WebGoat
- AND DEBE exponer el puerto 8080
- AND DEBE tener volúmenes para persistencia

#### Scenario: Lab 4 Dockerizado — Active Directory (BloodHound)

- GIVEN `docker-labs/lab4/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con BloodHound e impacket
  - Servicio `dc01` — Controlador de Dominio Windows Server
  - Servicio `bloodhound` — BloodHound Community Edition
- AND DEBE definir una red bridge personalizada (172.18.4.0/24)

#### Scenario: Lab 5 Dockerizado — Automated Pentesting

- GIVEN `docker-labs/lab5/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con AutoRecon y Metasploit
  - Servicio `target` — Máquina vulnerable (OWASP Juice Shop)
- AND DEBE definir red bridge personalizada (172.18.5.0/24)

#### Scenario: Lab 6 Dockerizado — Undetectable Payloads

- GIVEN `docker-labs/lab6/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con msfvenom, Veil-Evasion y mingw-w64
- AND DEBE tener acceso a internet para VirusTotal API
- AND DEBE incluir volumen `lab6_payloads` para almacenar payloads

#### Scenario: Lab 7 Dockerizado — OT Security (OpenPLC)

- GIVEN `docker-labs/lab7/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux con herramientas OT (s7scan, modbus)
  - Servicio `openplc` — OpenPLC v3 para simulación de PLC
- AND DEBE exponer puertos OT estándar (102 TCP, 502 TCP/UDP)
- AND DEBE definir red bridge personalizada (172.18.7.0/24)

#### Scenario: Lab 8 Dockerizado — Final Project

- GIVEN `docker-labs/lab8/docker-compose.yml`
- WHEN Se verifica los servicios
- THEN DEBE incluir:
  - Servicio `kali` — Kali Linux full
  - Servicio `web` — Aplicación web vulnerable (DVWA)
  - Servicio `db` — Base de datos MySQL vulnerable
  - Servicio `api` — API REST vulnerable
- AND DEBE definir una red bridge personalizada (172.18.8.0/24)

---

### Requirement: README.md Dockerizado Estructurado

Cada README.md en `docker-labs/labN/` DEBE seguir una estructura estandarizada para ejecución autónoma.

#### Scenario: Estructura del README dockerizado

- GIVEN Un archivo `README.md` en `docker-labs/labN/`
- WHEN Se verifica su contenido
- THEN DEBE contener las siguientes secciones:
  1. `# Lab N: {Título}` — Encabezado con número y título
  2. `## Overview` — Descripción general del laboratorio
  3. `## Learning Objectives` — Objetivos de aprendizaje
  4. `## Requirements/Prerequisites` — Docker, recursos hardware
  5. `## Architecture` — Diagrama y descripción del entorno
  6. `## Quick Start` — Instrucciones rápidas para levantar el entorno
  7. `## Detailed Exercises` — Pasos del lab con comandos (4-8 ejercicios)
  8. `## Troubleshooting` — Problemas comunes y soluciones
  9. `## Cleanup` — Eliminar contenedores y volúmenes

---

### Requirement: Comandos Docker Ejecutables

Los comandos en el README de docker-labs DEBEN ser ejecutables directamente desde el terminal.

#### Scenario: Docker Compose commands en README

- GIVEN La sección `## Quick Start` del README
- WHEN Se verifica los comandos
- THEN DEBE incluir:
  - `docker compose up -d` — Levantar el entorno
  - `docker compose ps` — Verificar servicios corriendo
  - `docker compose logs -f` — Ver logs en tiempo real
- AND DEBE explicitar cómo entrar en cada contenedor con sintaxis exacta

#### Scenario: Acceso a contenedores

- GIVEN La sección `## Detailed Exercises` del README
- WHEN Se explica cómo acceder a un contenedor
- THEN DEBE usar `docker compose exec <service> bash` como comando principal
- AND DEBE indicar los directorios de inicio y volúmenes montados

---

### Requirement: Requisitos Hardware Docker

Los laboratorios dockerizados DEBEN tener requisitos de hardware realistas y documentados.

#### Scenario: Requisitos mínimos y recomendados

- GIVEN Cualquier README.md en docker-labs/
- WHEN Se verifica la sección `## Requirements/Prerequisites`
- THEN DEBE especificar:
  - Docker Engine 24.0+
  - Docker Compose 2.0+
  - 16GB RAM (8GB mínimo pero limitante)
  - 20GB almacenamiento disponible
- AND DEBE indicar el consumo de recursos específico de ese lab

---

### Requirement: Limpieza de Laboratorios Dockerizados

Cada laboratorio dockerizado DEBE explicar cómo limpiar el entorno completamente.

#### Scenario: Cleanup commands

- GIVEN La sección `## Cleanup` del README
- WHEN Se verifica los comandos
- THEN DEBE incluir:
  - `docker compose down` — Parar servicios
  - `docker compose down -v` — Eliminar volúmenes
  - `docker image rm <image>` — Eliminar imágenes si necesario
- AND DEBE explicar cómo verificar que todo fue limpiado correctamente

---

### Requirement: Compatibilidad Cross-Platform Docker

Los laboratorios dockerizados DEBEN funcionar en diferentes sistemas operativos.

#### Scenario: Compatibilidad cross-platform

- GIVEN Cualquier README.md en docker-labs/
- WHEN Se verifica la sección `## Requirements/Prerequisites`
- THEN DEBE indicar compatibilidad explícita con:
  - Windows 10/11 con WSL2 + Docker Desktop
  - macOS con Docker Desktop (Intel y Apple Silicon)
  - Linux con Docker Engine
- AND DEBE notar cualquier limitación específica por plataforma

---

### Requirement: Health Checks en Docker Compose

Los laboratorios con múltiples servicios DEBEN incluir health checks apropiados.

#### Scenario: Health check configuration

- GIVEN Un archivo `docker-compose.yml` con múltiples servicios
- WHEN Se verifica la sección de cada servicio
- THEN Los servicios críticos DEBEN incluir:
  - `healthcheck:` con test HTTP curl o comando específico
  - Intervals: 30s (estándar)
  - Timeout: 10s (apropiado)
  - Retries: 3-5 (resiliente)
  - Start period: 30-60s (adecuado para startup)

---

### Requirement: Gestión de Recursos en Docker

Cada laboratorio dockerizado DEBE especificar límites de recursos para evitar sobrecarga del sistema.

#### Scenario: Memory limits por servicio

- GIVEN Cualquier servicio en docker-compose.yml
- WHEN Se verifica la sección `resources:`
- THEN DEBE incluir:
  - `limits.memory` — Límite máximo (ej: 3G, 2G, 1.5G)
  - `reservations.memory` — Reserva mínima (ej: 2G, 1G, 512m)
- AND La suma total no DEBE exceder 16GB
