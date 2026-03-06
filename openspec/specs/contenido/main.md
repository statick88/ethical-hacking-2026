# Delta Spec: Contenido del Informe (8 Módulos)

## Purpose

Esta especificación define los requisitos para el contenido curricular de los 8 módulos de Ethical Hacking 2026, estructurando un programa de 150 horas enfocado en estrategia de IA y pentesting autónomo.

## ADDED Requirements

### Requirement: Estructura de 8 Módulos Especializados

El programa DEBE dividirse en exactamente 8 módulos con una distribución específica de horas de estudio.

#### Scenario: Validación de distribución de horas

- GIVEN El programa de modernización curricular
- WHEN Se verifica la estructura de módulos
- THEN El total debe sumar 150 horas
- AND Cada módulo debe tener una descripción de objetivos de aprendizaje
- AND La progresión debe ser de lo básico a lo avanzado

#### Scenario: Módulo 1 - Fundamentos y Reconocimiento Agéntico (15 horas)

- GIVEN El contexto de IA agéntica en pentesting
- WHEN Se define el módulo introductorio
- THEN DEBE incluir: Conceptos de agentes autónomos, Reconocimiento pasivo y activo, Osint y recopilación de datos, Introducción a prompt engineering
- AND Debe establecer fundamentos para los módulos subsecuentes

#### Scenario: Módulo 2 - Vulnerabilidades en IA y Modelos de Lenguaje (20 horas)

- GIVEN La importancia de la seguridad en sistemas de IA
- WHEN Se diseña el contenido especializado
- THEN DEBE incluir: Prompt Injection y sus variantes, Jailbreaking de LLMs, Técnicas de Bug Bounty (DAN, RUIN, Master-of-Prompt), Explotación de parámetros de temperatura y tokens, Bug Bounty en plataformas de IA (OpenAI, Anthropic, etc.)
- AND Debe incluir casos de estudio reales de vulnerabilidades

#### Scenario: Módulo 3 - Explotación Web y APIs 2026 (20 horas)

- GIVEN La evolución de vulnerabilidades web
- WHEN Se actualiza el contenido de seguridad web
- THEN DEBE incluir: OWASP Top 10 2024 actualizado, Vulnerabilidades en APIs REST y GraphQL, Server-Side Template Injection (SSTI), SQL Injection avanzado, CSRF, XXE y otras vulnerabilidades emergentes
- AND Debe incluir laboratorios prácticos con escenarios reales

#### Scenario: Módulo 4 - Hacking de Identidad y AD Moderno (20 horas)

- GIVEN La complejidad de los sistemas de identidad corporativos
- WHEN Se define el módulo de autenticación y autorización
- THEN DEBE incluir: Active Directory atacante (Kerberoasting, Pass-the-Hash), OAuth 2.0 y OpenID Connect, MFA bypass, Phishing de credenciales, Lateral movement en entornos híbridos (On-prem + Cloud)
- AND Debe incluir técnicas de evasión de contraseñas

#### Scenario: Módulo 5 - Pentesting Autónomo y Red Teaming Agéntico (20 horas)

- GIVEN La necesidad de automatizar pentest con IA
- WHEN Se diseña el módulo de automatización
- THEN DEBE incluir: Orquestación de agentes de IA para pentesting, Cadenas de acciones (chains) para explotación secuencial, Reconocimiento agéntico con herramientas como Shodan, Censys, etc., Red Teaming con IA agéntica, Detección y evasión de EDR/XDR
- AND Debe incluir prototipos de agentes básicos

#### Scenario: Módulo 6 - Evasión de Defensas (20 horas)

- GIVEN La sofisticación de los sistemas defensivos
- WHEN Se define el módulo de evasión
- THEN DEBE incluir: Evasión de firewalls y WAF, Evasión de antivirus y YARA rules, Ofuscación de código (shellcode, C2), Detección de honeypots y sandbox, Privacidad en infraestructura (VPN, proxies, Tor), Técnicas anti-forense
- AND Debe incluir análisis de detectabilidad

#### Scenario: Módulo 7 - Ciberseguridad Industrial (20 horas)

- GIVEN La importancia de proteger infraestructura crítica
- WHEN Se diseña el módulo de OT/IT
- THEN DEBE incluir: Introducción a redes industriales (Modbus, Profibus), Herramientas de hardening (OpenClaw), Pentesting automatizado (Pentagi), Escaneo de PLCs (PLCSploit, s7scan), SCADA y HMI, Seguridad en IIoT
- AND Debe incluir casos reales de ataques industriales

#### Scenario: Módulo 8 - Post-Explotación, Reporte y Ética (15 horas)

- GIVEN El ciclo completo de un pentest
- WHEN Se define el módulo de cierre
- THEN DEBE incluir: Perseverancia y lateral movement, Reporte profesional de vulnerabilidades, Ética en pentesting y marcos legales, Remediación y hardening, Presentación ejecutiva de hallazgos
- AND Debe incluir plantillas de reportes

### Requirement: Progresión Pedagógica Clara

El contenido DEBE seguir una estructura que progrese de conceptos básicos a avanzados.

#### Scenario: Flujo lógico entre módulos

- GIVEN Los 8 módulos en orden
- WHEN Un estudiante completa la progresión
- THEN El Módulo 1 introduce conceptos fundamentales
- AND El Módulo 2 profundiza en IA
- AND El Módulo 3 expande a web
- AND El Módulo 4 introduce identidad
- AND El Módulo 5 automatiza ataques
- AND El Módulo 6 enseña evasión
- AND El Módulo 7 especializa en industrial
- AND El Módulo 8 cierra con ética y reportes

### Requirement: Casos de Estudio y Ejemplos Reales

El programa DEBE incluir casos de estudio de ataques reales y vulnerabilidades publicadas.

#### Scenario: Referencia a incidentes conocidos

- GIVEN El contexto de cada módulo
- WHEN Se presenta un concepto
- THEN DEBE incluir al menos un ejemplo o caso de estudio real
- AND El ejemplo debe ser verificable o citado de fuentes públicas
- AND Debe incluir detalles técnicos y lecciones aprendidas

### Requirement: Objetivos de Aprendizaje Medibles

Cada módulo DEBE tener objetivos de aprendizaje (Learning Outcomes) claramente definidos.

#### Scenario: Definición de competencias

- GIVEN Un módulo completado
- WHEN Un estudiante termina el módulo
- THEN El estudiante DEBE poder demostrar habilidades específicas
- AND Cada habilidad DEBE ser evaluable mediante laboratorios o quizzes
- AND Los objetivos DEBEN alinearse con certificaciones relevantes

## MODIFIED Requirements

### Requirement: Actualización de Contenido Existente (si aplica)

Si hay contenido previo, DEBE ser revisado y actualizado con técnicas 2026.

#### Scenario: Versioning de contenido

- GIVEN Contenido de cursos anteriores
- WHEN Se moderniza el programa
- THEN Los contenidos antiguos DEBEN ser marcados como deprecated o actualizados
- AND Las nuevas técnicas DEBEN tener prioridad sobre las antiguas
- AND Se DEBEN documentar los cambios entre versiones

## Bibliography Format

- IEEE standard para referencias técnicas
- URLs verificadas y accesibles
- Fechas de acceso para contenido dinámico
- Libros, papers y recursos online mezcladosformat

## Considerations

- **Tiempo de estudio**: 150 horas asume dedicación a tiempo completo o equivalente distribuido
- **Profundidad vs Amplitud**: Cada módulo es introductorio con profundidad selectiva
- **Herramientas en cambio**: Se asume actualización anual de herramientas específicas
- **Certificaciones**: No es un programa de certificación formal, pero alinea con OSCP+, CEH v13
