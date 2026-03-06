# Quizzes por Unidad — Specification

## Purpose

Especificaciones para los 8 sets de evaluación del curso. Actualmente solo existe `quizzes/guia.md` (guía de formato, sin preguntas reales). Esta spec define qué DEBE contener cada quiz para ser evaluable.

---

## Requirements

### Requirement: Un Set de Quiz por Unidad

El curso DEBE tener exactamente 8 archivos de quiz, uno por unidad.

#### Scenario: Existencia de archivos de quiz

- GIVEN El directorio `quizzes/`
- WHEN Se lista su contenido
- THEN DEBE existir `quizzes/unidad1.md` hasta `quizzes/unidad8.md`
- AND DEBE existir `quizzes/guia.md` (ya existe, no eliminar)

---

### Requirement: Estructura Estándar de Quiz

Cada archivo de quiz DEBE contener exactamente: 10 preguntas de opción múltiple + 2 escenarios prácticos.

#### Scenario: Cantidad de preguntas correcta

- GIVEN Un archivo `quizzes/unidadN.md`
- WHEN Se cuentan los elementos evaluativos
- THEN DEBE contener exactamente 10 preguntas de opción múltiple
- AND DEBE contener exactamente 2 escenarios prácticos
- AND DEBE indicar la respuesta correcta de cada pregunta (con explicación)

#### Scenario: Formato de pregunta de opción múltiple

- GIVEN Una pregunta de opción múltiple en cualquier quiz
- WHEN Se verifica su formato
- THEN DEBE tener: enunciado de pregunta + 4 opciones (a, b, c, d) + respuesta correcta + explicación
- AND Las 4 opciones DEBEN ser plausibles (no opciones trampa obvias)
- AND La explicación DEBE indicar POR QUÉ la opción correcta es correcta

#### Scenario: Formato de escenario práctico

- GIVEN Un escenario práctico en cualquier quiz
- WHEN Se verifica su formato
- THEN DEBE tener: descripción del escenario + pregunta abierta o de análisis + respuesta esperada + criterios de evaluación
- AND El escenario DEBE simular una situación real de trabajo

---

### Requirement: Cobertura de Contenido por Unidad

Las preguntas de cada quiz DEBEN cubrir los temas principales de su unidad correspondiente.

#### Scenario: Distribución de preguntas por subtema

- GIVEN Un quiz de la unidad N con 10 preguntas
- WHEN Se mapean las preguntas a los subtemas de la unidad
- THEN CADA subtema principal (###) de la unidad DEBE tener al menos 1 pregunta
- AND No DEBE haber más de 4 preguntas sobre un mismo subtema

---

### Requirement: Dificultad Progresiva

Las preguntas DEBEN distribuirse en 3 niveles de dificultad.

#### Scenario: Distribución de dificultad

- GIVEN Un set de 10 preguntas de opción múltiple
- WHEN Se clasifican por dificultad
- THEN DEBE haber: 4 preguntas Básicas (definición/reconocimiento) + 4 Intermedias (aplicación/análisis) + 2 Avanzadas (evaluación/síntesis)
- AND Las preguntas DEBEN ordenarse de menor a mayor dificultad

---

### Requirement: Criterios de Aprobación Claros

Cada quiz DEBE indicar el criterio de aprobación.

#### Scenario: Puntaje mínimo explícito

- GIVEN El encabezado o pie de cualquier quiz
- WHEN Se verifica la información de aprobación
- THEN DEBE indicar: "Puntaje mínimo para aprobar: 7/10 (70%)"
- AND DEBE indicar qué pasa si no se aprueba (posibilidad de repetir, sin penalización)

---

### Requirement: Cobertura Temática por Unidad

#### Scenario: Quiz Unidad 1 — Metodología y Reconocimiento

- GIVEN `quizzes/unidad1.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: fases del pentesting, diferencias OSSTMM/PTES, uso de Nmap, OSINT automatizado, SpiderFoot/Recon-ng

#### Scenario: Quiz Unidad 2 — IA y LLM

- GIVEN `quizzes/unidad2.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: OWASP Top 10 LLM, tipos de Prompt Injection, técnicas de jailbreaking, Bug Bounty en IA, responsible disclosure

#### Scenario: Quiz Unidad 3 — Web y APIs

- GIVEN `quizzes/unidad3.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: OWASP Top 10 Web, SQLi, XSS, CSRF, vulnerabilidades de API REST y GraphQL

#### Scenario: Quiz Unidad 4 — AD y Identidad

- GIVEN `quizzes/unidad4.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: arquitectura AD, Kerberoasting, Pass-the-Hash, Golden Ticket, Azure AD token theft

#### Scenario: Quiz Unidad 5 — Pentesting Autónomo

- GIVEN `quizzes/unidad5.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: agentic pentesting, MITRE ATT&CK TTPs, C2 frameworks, automatización de reportes

#### Scenario: Quiz Unidad 6 — Evasión

- GIVEN `quizzes/unidad6.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: AMSI bypass, LOLBins, DLL hijacking, process injection, timestomping, OpSec

#### Scenario: Quiz Unidad 7 — OT/ICS

- GIVEN `quizzes/unidad7.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: arquitectura Purdue, protocolos Modbus/S7comm, SCADA vulnerabilities, OpenClaw, Pentagi

#### Scenario: Quiz Unidad 8 — Post-Explotación y Ética

- GIVEN `quizzes/unidad8.md`
- WHEN Se verifica cobertura
- THEN DEBE incluir preguntas sobre: persistence mechanisms, estructura de reportes, divulgación responsable, marco legal español, GDPR
