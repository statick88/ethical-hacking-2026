# Contenido de Unidades — Specification

## Purpose

Especificaciones para el desarrollo del contenido pedagógico real de las 8 unidades del curso. Actualmente cada unidad es un esqueleto de 36-45 líneas con bullets sin desarrollar. Esta spec define qué DEBE contener cada unidad para ser considerada "completa".

---

## Requirements

### Requirement: Estructura Estándar de Unidad

Cada archivo `contenido/unidadN.qmd` DEBE seguir una estructura pedagógica completa y consistente. La estructura es obligatoria para todas las unidades.

#### Scenario: Estructura mínima presente

- GIVEN Un archivo de unidad `contenido/unidadN.qmd`
- WHEN Se verifica su estructura
- THEN DEBE contener las siguientes secciones en este orden:
  1. `# Unidad N: {Título}` — encabezado principal
  2. `## Objetivos de Aprendizaje` — lista de 3-5 objetivos medibles con verbos de Bloom
  3. `## Contenido Teórico` — desarrollo por subtemas (mínimo 3 subsecciones `###`)
  4. `## Herramientas` — tabla con herramienta, descripción, instalación/URL
  5. `## Laboratorio` — escenario completo con pasos (referencia al lab específico)
  6. `## Recursos Adicionales` — links a lecturas complementarias
  7. `## Bibliografía` — mínimo 2 referencias

#### Scenario: Longitud mínima de contenido

- GIVEN Un archivo de unidad completado
- WHEN Se cuenta el contenido
- THEN DEBE tener un mínimo de 300 líneas
- AND Cada subsección `###` de contenido teórico DEBE tener mínimo 5 líneas de explicación real (no solo bullets)

---

### Requirement: Objetivos con Verbos de Bloom

Los objetivos de aprendizaje DEBEN usar verbos de acción de la Taxonomía de Bloom para que sean medibles y evaluables.

#### Scenario: Verbos de acción presentes

- GIVEN La sección `## Objetivos de Aprendizaje` de cualquier unidad
- WHEN Se leen los objetivos
- THEN Cada objetivo DEBE iniciar con un verbo de acción (Identificar, Ejecutar, Analizar, Implementar, Evaluar, Demostrar, Configurar, etc.)
- AND Los objetivos DEBEN ser verificables al final de la unidad

---

### Requirement: Tabla de Herramientas

Cada unidad DEBE incluir una tabla de herramientas estructurada que el estudiante pueda usar como referencia rápida.

#### Scenario: Tabla presente y completa

- GIVEN La sección `## Herramientas` de una unidad
- WHEN Se verifica la tabla
- THEN DEBE tener columnas: `Herramienta | Propósito | Instalación / URL`
- AND DEBE listar mínimo 3 herramientas relevantes para la unidad
- AND Las URLs DEBEN ser funcionales

---

### Requirement: Contenido Teórico Desarrollado

Cada subsección del contenido teórico DEBE tener explicación real — no solo listas de bullets. Debe incluir contexto, ejemplos concretos o fragmentos de código/comandos cuando aplique.

#### Scenario: Unidad 1 — Fundamentos y Reconocimiento Agéntico

- GIVEN `contenido/unidad1.qmd`
- WHEN Se verifica el contenido de `### 1.1 Metodología de Pentesting`
- THEN DEBE explicar las fases (Reconocimiento, Escaneo, Explotación, Post-Explotación, Reporte) con descripción de cada una
- AND DEBE incluir un diagrama o tabla comparativa de OSSTMM vs PTES vs OWASP
- AND `### 1.2 Reconocimiento Agéntico` DEBE incluir ejemplos de comandos de Nmap/Recon-ng/SpiderFoot

#### Scenario: Unidad 2 — Vulnerabilidades en IA y LLM

- GIVEN `contenido/unidad2.qmd`
- WHEN Se verifica el contenido de `### 2.2 Prompt Injection`
- THEN DEBE incluir ejemplos reales de payloads de Direct e Indirect Injection
- AND DEBE incluir el OWASP Top 10 para LLMs con descripción de cada ítem
- AND `### 2.3 Técnicas de Jailbreaking` DEBE describir DAN, RUIN y Master-of-Prompt con ejemplos

#### Scenario: Unidad 3 — Explotación Web y APIs

- GIVEN `contenido/unidad3.qmd`
- WHEN Se verifica el contenido
- THEN DEBE incluir descripción detallada de cada ítem del OWASP Top 10 2025/2026
- AND DEBE incluir ejemplos de payloads para XSS, SQLi y GraphQL injection
- AND DEBE tener bibliografía con referencias a OWASP

#### Scenario: Unidad 4 — Hacking de Identidad y AD

- GIVEN `contenido/unidad4.qmd`
- WHEN Se verifica el contenido
- THEN DEBE explicar el flujo de Kerberoasting paso a paso
- AND DEBE incluir comandos de BloodHound, Impacket y CrackMapExec
- AND DEBE cubrir Azure AD / Entra ID con técnicas de token theft

#### Scenario: Unidad 5 — Pentesting Autónomo

- GIVEN `contenido/unidad5.qmd`
- WHEN Se verifica el contenido
- THEN DEBE explicar el concepto de agentic pentesting con ejemplos de frameworks
- AND DEBE incluir el framework MITRE ATT&CK como referencia de TTPs
- AND DEBE describir C2 frameworks (Cobalt Strike, Sliver, Havoc) con sus características

#### Scenario: Unidad 6 — Evasión de Defensas

- GIVEN `contenido/unidad6.qmd`
- WHEN Se verifica el contenido
- THEN DEBE explicar AMSI bypass con al menos 2 técnicas documentadas
- AND DEBE incluir ejemplos de Living off the Land Binaries (LOLBins)
- AND DEBE cubrir técnicas de timestomping y artifact wiping

#### Scenario: Unidad 7 — Ciberseguridad Industrial

- GIVEN `contenido/unidad7.qmd`
- WHEN Se verifica el contenido
- THEN DEBE explicar la arquitectura Purdue para OT/ICS
- AND DEBE describir protocolos Modbus y S7comm con sus vulnerabilidades
- AND DEBE incluir instrucciones de uso de OpenClaw y Pentagi

#### Scenario: Unidad 8 — Post-Explotación, Reporte y Ética

- GIVEN `contenido/unidad8.qmd`
- WHEN Se verifica el contenido
- THEN DEBE incluir plantilla de reporte de pentest (Executive Summary + Technical Findings)
- AND DEBE cubrir el marco legal español (Ley 34/2002, Código Penal art. 197bis)
- AND DEBE tener sección de Proyecto Final con entregables claros
