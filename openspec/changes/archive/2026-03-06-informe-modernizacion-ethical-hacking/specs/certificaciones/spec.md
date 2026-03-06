# Delta Spec: Certificaciones de Referencia

## Purpose

Esta especificación define las certificaciones internacionales que sirven como referencia para validar las competencias adquiridas en el programa de modernización.

## ADDED Requirements

### Requirement: OSCP+ (Offensive Security Certified Professional Plus) como Referencia Principal

El programa DEBE alinearse con OSCP+ como certificación de referencia principal.

#### Scenario: Alineamiento con OSCP+

- GIVEN El programa de 150 horas
- WHEN Se estructura el contenido
- THEN Los módulos 3, 5 y 8 DEBEN alinearse con objetivos OSCP+
- AND Se DEBE documentar mapeo entre contenido del curso y habilidades OSCP+
- AND Se DEBEN incluir ejercicios similares a OSCP+ labs
- AND Se DEBE documentar que el programa es introducción a nivel OSCP+

#### Scenario: Componentes de OSCP+ cubiertos

- GIVEN El programa completo de 8 módulos
- WHEN Se revisa cobertura de OSCP+
- THEN Se DEBEN cubrir:
  - Información Gathering (Módulo 1)
  - Vulnerability Assessment (Módulo 2, 3)
  - Exploitation (Módulo 3, 5)
  - Privilege Escalation (Módulo 4, 5)
  - Lateral Movement (Módulo 4, 5)
  - Port Redirection & Tunneling (Módulo 5)
  - Web Application Attacks (Módulo 3)
  - Password Attacks (Módulo 4)
  - Metasploit (Módulo 5)
  - PowerShell & AD Attacks (Módulo 4)
  - Linux Privilege Escalation (Módulo 6)
  - Windows Privilege Escalation (Módulo 6)
- AND Se DEBE documentar que OSCP+ requiere práctica adicional posterior

### Requirement: CEH v13 (Certified Ethical Hacker) como Referencia Secundaria

El programa DEBE alinearse parcialmente con CEH v13.

#### Scenario: Cobertura de domínios CEH v13

- GIVEN El módulo 1 (Fundamentos)
- WHEN Se estructura el contenido
- THEN DEBE cubrir dominios de CEH v13:
  - Footprinting & Reconnaissance
  - Scanning Networks
  - Enumeration
  - Vulnerability Analysis
- AND Se DEBE documentar que el programa va más allá de CEH v13
- AND Se DEBE indicar que CEH es nivel más introductorio

#### Scenario: Certificaciones complementarias por módulo

- GIVEN Cada módulo
- WHEN Se completa
- THEN DEBE haber referencia a certificación relevante:
  - Módulo 2: Security+ (CompTIA)
  - Módulo 3: Bug Bounty Hunter (HackerOne/Bugcrowd credentials)
  - Módulo 4: AZ-500 (Microsoft Azure Security Engineer)
  - Módulo 5: OSCP+ (Offensive Security)
  - Módulo 6: GIAC Security Essentials (GSEC) - parte de Security+
  - Módulo 7: CPNI (Network Infrastructure) - industrial focus
  - Módulo 8: GPEN (GIAC Penetration Tester)

### Requirement: Bug Bounty Credentials como Validación Alternativa

El programa DEBE reconocer bug bounty como validación de habilidades.

#### Scenario: Reconocimiento de bug bounty

- GIVEN Un estudiante que completa módulos
- WHEN Reporta vulnerabilidades en programas de bug bounty
- THEN Se DEBE documentar que reportes aceptados son validación de habilidades
- AND Se DEBEN proporcionar recursos sobre bug bounty (HackerOne, Bugcrowd, Intigriti)
- AND Se DEBE incluir guía ética y legal
- AND Se DEBEN documentar vulnerabilidades reportables por tipo

#### Scenario: Casos de estudio de bug bounty

- GIVEN El programa de formación
- WHEN Se enseña explotación
- THEN Se DEBEN incluir casos reales de bug bounty reportados
- AND Se DEBE documentar metodología de responsable disclosure
- AND Se DEBEN incluir ejemplos de CVE generados desde programas de bug bounty

### Requirement: Certificaciones Recomendadas No Requeridas

El programa NO DEBE requerir certificaciones, pero SÍ debe indicar ruta clara.

#### Scenario: Ruta de certificaciones post-curso

- GIVEN Un estudiante que completa el programa
- WHEN Busca certificarse
- THEN DEBE haber documento con ruta recomendada:
  - Corto plazo: Security+, CEH (1-3 meses de prep)
  - Mediano plazo: OSCP+, Azure Security (2-6 meses)
  - Largo plazo: GPEN, GIAC, ECSQ (6-12 meses)
- AND Se DEBEN documentar costos estimados de certificaciones
- AND Se DEBEN incluir recursos de preparación gratuitos

### Requirement: Documentación de Equivalencias

El programa DEBE documentar qué habilidades equivalen a qué certificación.

#### Scenario: Matriz de habilidades vs certificaciones

- GIVEN Los 8 módulos completados
- WHEN Se revisan habilidades adquiridas
- THEN DEBE haber matriz que mapee:
  - Habilidad específica (ej: "SQL Injection exploitation")
  - Certificación que la valida (CEH, OSCP+, Security+)
  - Porcentaje de cobertura (ej: "CEH cubre 80% de la habilidad")
  - Recursos adicionales para completar brecha
- AND La matriz DEBE ser verificable contra objetivos de certificación

### Requirement: Actualización Anual de Certificaciones

El programa DEBE documentar revisión anual de certificaciones.

#### Scenario: Control de vigencia

- GIVEN El año 2026
- WHEN Se publique el informe
- THEN DEBE indicarse:
  - Versión de certificación (CEH v13, OSCP+ 2026, etc.)
  - Fecha de próxima actualización recomendada
  - Cambios anticipados en certificaciones futuras
- AND Se DEBEN documentar deprecations (ej: CEH v12 → v13)

### Requirement: Industry Recognition

El programa DEBE documentar reconocimiento de certificaciones en industria.

#### Scenario: Valor en mercado laboral

- GIVEN Las certificaciones recomendadas
- WHEN Un empleador revisa candidatos
- THEN DEBE documentarse:
  - Nivel de reconocimiento en mercado (Alto/Medio/Bajo)
  - Salarios estimados para certificados (rango)
  - Demanda en mercado laboral
  - Sectores que más la valoran
- AND Se DEBEN incluir datos de fuentes como Indeed, Salary.com, etc.

### Requirement: Preparación sin Certificación

El programa DEBE ser completo incluso sin meta de certificación.

#### Scenario: Habilidades independientes de certificación

- GIVEN Un estudiante sin interés en certificarse
- WHEN Completa el programa
- THEN DEBE haber validación alternativa:
  - Portfolio de laboratorios completados
  - Documentación de vulnerabilidades encontradas
  - Reportes de pentesting ejercicios
  - Contribuciones a proyectos open source de seguridad
  - Participación en CTF competitivos

## MODIFIED Requirements

### Requirement: Transparencia sobre Limitaciones

Se DEBE documentar transparentemente qué NO cubre el programa respecto a certificaciones.

#### Scenario: Claidades sobre gaps

- GIVEN Un estudiante considerando certificarse
- WHEN Revisa programa
- THEN DEBE quedar claro:
  - Este programa es introducción, certificación requiere estudio adicional
  - Ciertas áreas (ej: management, compliance) no están cubiertas completamente
  - Certificaciones requieren prueba de experiencia práctica
  - El programa prepara pero NO garantiza aprobación

## Bibliography Format

- Enlaces oficiales a certificaciones (CompTIA, Offensive Security, etc.)
- Planes de estudio oficiales linkados
- Datos de salarios de fuentes verificables
- Noticias de cambios en certificaciones
- Información de prerequisitos
- URLs a portales de examen

## Considerations

- **Evolución rápida**: Las certificaciones cambian frecuentemente (v13 → v14, etc.)
- **Costo**: Certificaciones oficiales son caras (OSCP+ $950+, CEH $325+)
- **Experiencia requerida**: Algunas certificaciones requieren años de experiencia
- **Validez**: Certificaciones expiran y requieren renovación
- **Mercado laboral**: El reconocimiento varía por región y sector
- **Alternativas emergentes**: Micro-credenciales (Coursera, edX) son alternativa creciente
- **Ética**: Algunos programas de certificación tienen controversia sobre validez real
