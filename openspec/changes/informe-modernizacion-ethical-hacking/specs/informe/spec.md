# Spec: Modernización Curricular Ethical Hacking 2026

## Purpose

Esta especificación define los requisitos para la propuesta de modernización curricular del curso de Ethical Hacking en ABACOM, enfocándose en formar "Estrategas de IA" con capacidades de pentesting autónomo.

## Requirements

### Requisito: Estructura Curricular

El programa DEBE incluir 8 módulos especializados con un total de 150 horas.

#### Scenario: Distribución de horas por módulo

- GIVEN La propuesta de modernización
- WHEN Se define la estructura curricular
- THEN La suma total debe ser 150 horas distribuidas en 8 módulos

### Requisito: Contenido de IA y Seguridad

El programa DEBE incluir vulnerabilidades en IA, prompt injection y jailbreaking.

#### Scenario: Inclusión de seguridad en IA

- GIVEN El módulo de IA
- WHEN Se diseña el contenido
- THEN Debe incluir: Prompt Injection, Jailbreaking, Técnicas de Bug Bounty (DAN, RUIN, Master-of-Prompt), Bug Bounty en plataformas de IA

### Requisito: Ciberseguridad Industrial

El programa DEBE incluir hardening y pentesting de sistemas industriales.

#### Scenario: Contenido de ciberseguridad industrial

- GIVEN El módulo 7
- WHEN Se define el contenido
- THEN Debe incluir: OpenClaw (hardening), Pentagi (pentesting automatizado), PLCSploit, s7scan

### Requisito: Laboratorios

Los laboratorios DEBEN utilizar solo opciones gratuitas/open source.

#### Scenario: Selección de herramientas

- GIVEN La sección de laboratorios
- WHEN Se eligen las herramientas
- THEN Solo incluir: Docker, VirtualBox, VMware Fusion, TryHackMe (Free), Hack The Box, OverTheWire

### Requisito: Infraestructura

La infraestructura DEBE incluir introducciones a Docker y Kali Linux.

#### Scenario: Secciones de infraestructura

- GIVEN El documento de infraestructura
- WHEN Se estructura el contenido
- THEN Debe incluir: 8.1 Introducción a Docker, 8.2 Introducción a Kali Linux, 8.3 Laboratorios del Curso

### Requisito: Ortografía y Gramática

El documento DEBE estar libre de errores ortográficos y gramaticales.

#### Scenario: Revisión de errores

- GIVEN El documento completo
- WHEN Se verifica el contenido
- THEN No debe contener: palabras en inglés sin traducir, errores tipográficos

## Bibliography Format

Las referencias DEBEN estar en formato IEEE con URLs verificadas.

## Visual Requirements

- Tablas: Solo encabezados con fondo azul
- Negritas: Uso correcto de `<strong>`
- Cursivas: Uso correcto de `<em>`
- Hipervínculos: Presentes y funcionales
