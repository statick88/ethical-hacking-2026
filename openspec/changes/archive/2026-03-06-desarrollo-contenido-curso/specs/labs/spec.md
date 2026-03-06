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
